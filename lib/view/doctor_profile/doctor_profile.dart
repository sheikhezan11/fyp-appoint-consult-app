import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_button.dart';
import '../../viewmodel/controller/doctor_profile/doctor_profile_controller.dart';

class DoctorProfile extends GetView<DoctorProfileController> {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final DoctorProfileController doctorProfileController =
        Get.put(DoctorProfileController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.close(-1);
                      },
                      child: const Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                const Text(
                  'Fill Your Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                controller.showPhotoOption();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: (controller.imageFile != null)
                      ? FileImage(controller.imageFile!)
                      : null,
                  child: (controller.imageFile == null)
                      ? const Icon(
                          Icons.person,
                          size: 60,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.doctorNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Doctor Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.speciallityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Doctor Speciality',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: controller.aboutController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'About you',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.workingTimeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Working time',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.workingDaysController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Working Days',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  controller: controller.addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'doctor address',
                  ),
                ),
              ),
            ),
            FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: CustomButton(
                      clr: const Color(0xff68609c),
                      textClr: Colors.green,
                      buttonTitle: "Send",
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      ontapp: () {
                        controller.uploadData();
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
