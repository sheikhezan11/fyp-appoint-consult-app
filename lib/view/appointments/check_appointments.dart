import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/bookappointment_model.dart';
import '../../resources/routes/pages.dart';
import '../../viewmodel/controller/check_appointment/check_appointment_controller.dart';

class CheckAppointments extends GetView<CheckAppointmentController> {
  const CheckAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckAppointmentController controller =
        Get.put(CheckAppointmentController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "My Bookings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          bottom: const TabBar(tabs: [
            Tab(text: "Upcoming"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ]),
        ),
        body: TabBarView(
          children: [
            Obx(() => buildAppointmentList(
                controller.upcomingAppointments, controller)),
            Obx(() => buildAppointmentList(
                controller.completedAppointments, controller)),
            Obx(() => buildAppointmentList(
                controller.cancelledAppointments, controller)),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentList(List<BookAppointmentModel> appointments,
      CheckAppointmentController controller) {
    if (appointments.isEmpty) {
      return const Center(child: Text('No appointments'));
    }
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        bool isUpcoming = appointments[index].status == "Upcoming";
        // ignore: unused_local_variable
        bool isCancelled = appointments[index].status == "Cancelled";

        return Container(
          padding: const EdgeInsets.all(2.0),
          margin: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                offset: Offset(2, 2),
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey,
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${appointments[index].doctorDate}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${appointments[index].doctorTime}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Divider(color: Colors.grey, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                              appointments[index].profilePic.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointments[index].doctorName ?? ""),
                        Text(appointments[index].doctorSpeciality ?? ""),
                        Text(appointments[index].doctorAddress ?? ""),
                      ],
                    ),
                  ],
                ),
              ),
              if (isUpcoming)
                const Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Contact: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.videoPage, arguments: {
                          "callId": appointments[index].documentId,
                          "userName": appointments[index].doctorName
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          color: const Color(0xff68609c),
                        ),
                        width: 50,
                        height: 50.0,
                        child: const Icon(
                          Icons.video_call_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  InkWell(
                     onTap: () {
                      Get.toNamed(Routes.voicePage, arguments: {
                        "callId": appointments[index].documentId,
                        "userName": appointments[index].doctorName
                      });
                    },
                    // onTap: () async {
                      
                      // const phoneNumber = '+92073874347433';
                      // final Uri launchUri = Uri(
                      //   scheme: 'tel',
                      //   path: phoneNumber,
                      // );
                      // if (await canLaunch(launchUri.toString())) {
                      //   await launch(launchUri.toString());
                      // } else {
                      //   // Handle error: Could not launch the phone call
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //         content: Text('Could not launch the phone call')),
                      //   );
                      // }
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: const Color(0xff68609c),
                      ),
                      width: 50,
                      height: 50.0,
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,  
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: const Color(0xff68609c),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: const Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                child: Divider(color: Colors.grey, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isUpcoming)
                      GestureDetector(
                        onTap: () async {
                          String doctorUid = appointments[index].doctorUid ??
                              ""; // Replace with actual doctor UID
                          String appointmentDate =
                              appointments[index].doctorDate ??
                                  ""; // Replace with actual appointment date
                          await controller.cancelAppointmentsForDoctorAndDate(
                              doctorUid, appointmentDate);
                        },
                        child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Center(child: Text("Cancel")),
                        ),
                      ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    if (isUpcoming)
                      GestureDetector(
                        onTap: () async {
                          String? doctorUID = appointments[index].doctorUid;
                          if (doctorUID != null) {
                            await controller
                                .getDoctorWorkingTimes({'id': doctorUID});
                            if (kDebugMode) {
                              print("TEST: ${appointments[index].documentId}");
                            }
                            showModalBottomSheet(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (context) => RescheduleBottomSheet(
                                id: appointments[index].documentId ?? "",
                                time: appointments[index].doctorDate ?? "",
                              ),
                            );
                          } else {
                            if (kDebugMode) {
                              print('Error: doctorUID is null');
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff68609c),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          width: 140,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Reschedule",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class RescheduleBottomSheet extends StatefulWidget {
  final String id;
  final String time;
  const RescheduleBottomSheet({
    required this.id,
    required this.time,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RescheduleBottomSheetState createState() => _RescheduleBottomSheetState();
}

class _RescheduleBottomSheetState extends State<RescheduleBottomSheet> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final CheckAppointmentController controller =
        Get.find<CheckAppointmentController>();

    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Previous Date: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.time,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            const Text(
              "Select Date:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                    const Icon(Icons.calendar_month)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTimeContainer(controller.doctorWorkingTimes),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.rescheduleAppointment(
                  widget.id,
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  controller.chooseTime,
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeContainer(Map<String, List<String>> doctorWorkingTimes) {
    if (doctorWorkingTimes.isEmpty) {
      return const Center(child: Text("No working times available"));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: doctorWorkingTimes.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Time: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 2.0,
                children: entry.value.map((workingTime) {
                  return _buildTimeSlot(workingTime);
                }).toList(),
              ),
            ],
          );
        }).toList(),
      );
    }
  }

  Widget _buildTimeSlot(String time) {
    final CheckAppointmentController controller =
        Get.find<CheckAppointmentController>();
    return InkWell(
      onTap: () {
        controller.onTimeSelected(time);
      },
      child: GetBuilder<CheckAppointmentController>(
          id: "day",
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(2, 2), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  color: controller.selectedDoctor.selectedTime == time
                      ? const Color(0xff68609c)
                      : Colors.transparent,
                ),
                color: controller.selectedDoctor.selectedTime == time
                    ? const Color(0xff68609c)
                    : const Color(0xfff9fafb),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.selectedDoctor.selectedTime == time
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            );
          }),
    );
  }
}
