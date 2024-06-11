import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_button.dart';
import '../../viewmodel/controller/book_appointment/book_appointment_controller.dart';

class BookAppointment extends GetView<BookAppointmentController> {
  const BookAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: GetBuilder<BookAppointmentController>(
        id: "day",
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  2, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xfff9fafb),
                        ),
                        child: TableCalendar(
                          locale: "en_US",
                          rowHeight: 43,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          focusedDay: controller.visibleMonth,
                          firstDay: DateTime.utc(2010, 10, 14),
                          lastDay: DateTime.utc(2030, 3, 30),
                          availableGestures: AvailableGestures.all,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, controller.selectedDate),
                          onDaySelected: (selectedDay, focusedDay) {
                            // Call the controller's method to handle day selection
                            controller.onDaySelected(
                                selectedDay, controller.focusedDay);
                          },
                          // Add this line to display the correct month
                          calendarFormat: CalendarFormat.month,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Select Date:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            Text(
                                '${controller.selectedDate.day}/${controller.selectedDate.month}/${controller.selectedDate.year}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Select Hour',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTimeContainer(controller.doctorWorkingTimes),
                    ],
                  ),
                ),
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    clr: const Color(0xff68609c),
                    textClr: Colors.green,
                    buttonTitle: "Confirm",
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    ontapp: () async{
                    await  controller.uploadAppointmentData();
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 50.0,
                                    child: Icon(
                                      Icons.verified,
                                      size: 50.0,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Center(
                                    child: Text(
                                      "Congratulations!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7.0),
                                  Center(
                                    child: Text(
                                      "Your appointment with ${controller.selectedDoctor.name} is confirmed for ${controller.selectedDate.day}-${controller.selectedDate.month}-${controller.selectedDate.year} at ${controller.selectedDoctor.selectedTime}.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  CustomButton(
                                      clr: const Color(0xff68609c),
                                      textClr: Colors.green,
                                      buttonTitle: "Done",
                                      width: MediaQuery.of(context).size.width,
                                      height: 50.0,
                                      ontapp: () {
                                        Get.close(-1);
                                      }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeContainer(List<String> doctorWorkingTimes) {
    if (doctorWorkingTimes.isEmpty) {
      return const Center(
        child: Text("No working times available"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Wrap(
          spacing: 12.0,
          runSpacing: 4.0,
          children: doctorWorkingTimes.map((workingTime) {
            return _buildTimeSlot(workingTime);
          }).toList(),
        ),
      );
    }
  }

  Widget _buildTimeSlot(String time) {
    return InkWell(
      onTap: () {
        controller.onTimeSelected(time);
      },
      child: Container(
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
      ),
    );
  }
}
