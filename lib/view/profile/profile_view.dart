import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import '../../utils/custom_button.dart';
import '../../viewmodel/controller/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10.0,
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
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: GestureDetector(
                  onTap: () {
                    controller.showPhotoOption();
                  },
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: SizedBox(
                  height: 60.0,
                  child: TextField(
                    controller: controller.namecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Name',
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: SizedBox(
                  height: 60.0,
                  child: TextField(
                    controller: controller.datePickerController,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: "Click here to select date"),
                    onTap: () => controller.onTapFunction(context: context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: SizedBox(
                  height: 60.0,
                  child: TextField(
                    controller: controller.genderController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Gender',
                    ),
                  ),
                ),
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 25.0),
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    buttonTitle: "Save",
                    textClr: Colors.white,
                    clr: const Color(0xff68609c),
                    ontapp: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          Future.delayed(const Duration(seconds: 3), () {
                            controller.checkValues(); 
                            Navigator.pop(context);
                            // Get.toNamed(Routes.dashboard);
                          });
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
                                      "Your account is ready to use. You will be redirected to the Home Page in a few seconds....",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  const SpinKitFadingCircle(
                                    color: Color(0xff68609c),
                                    size: 50.0,
                                  ),
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
          ),
        ),
      ),
    );
  }
}
