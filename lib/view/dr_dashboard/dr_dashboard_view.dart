import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedEase/viewmodel/controller/dr_dashboard/dr_dashboard_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../resources/routes/pages.dart';

class DrDashboardView extends GetView<DrDashboardController> {
  const DrDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("DashBoard"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(
                    Routes.loginView); // Example navigation using GetX
              } catch (e) {
                if (kDebugMode) {
                  print("Error signing out: $e");
                }
                // Handle error, if any
              }
            },
            child: const Icon(
              Icons.logout,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 8,
                      crossAxisSpacing:
                          8, // Aspect ratio of the items (width / height)
                    ),
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable grid's scrolling
                    itemCount: controller.checkList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        print(controller.doctorUid);
                        Get.toNamed(Routes.drAppointmentCheck
                           );
                      },
                      child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(controller.checkList[index]["color"]),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.checkList[index]["Total"]
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  controller.checkList[index]["name"]
                                      .toString(),
                                  style: const TextStyle(
                                    height: 1.1,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  )),
              const SizedBox(height: 20.0),
              controller.disapprovedAppointments.isEmpty
                  ? const SizedBox(
                      height: 10.0,
                    )
                  : const Text(
                      "Appointment Requests",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              Obx(
                () {
                  if (controller.disapprovedAppointments.isEmpty) {
                    return const Center(
                      child: Text(
                        "No appointments!!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.disapprovedAppointments.length,
                      itemBuilder: (context, index) {
                        var appointment =
                            controller.disapprovedAppointments[index];
                        String appointmentDate =
                            appointment['appointmentDate'] ?? '';
                        String userProfile = appointment['userProfile'] ?? '';
                        String userName = appointment['userName'] ?? '';
                        String doctorSpeciality =
                            appointment['doctorSpeciality'] ?? '';
                        String workingTime = appointment['workingTime'] ?? '';
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Date: $appointmentDate",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                          NetworkImage(userProfile),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          doctorSpeciality,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Appointment Time: $workingTime",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await controller.disapproveRequest(
                                            appointment['doctorUid'],
                                            appointmentDate,
                                            "Cancelled");
                                      },
                                      child: Container(
                                        width: 145.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Denied",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 50.0),
                                    GestureDetector(
                                      onTap: () async {
                                        await controller.disapproveRequest(
                                            appointment['doctorUid'],
                                            appointmentDate,
                                            "Upcoming");
                                      },
                                      child: Container(
                                        width: 145.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color: Colors.green,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
