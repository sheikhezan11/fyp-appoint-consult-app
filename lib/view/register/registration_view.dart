import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';
import '../../viewmodel/controller/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller=Get.put(RegisterController());
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.signUpKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: Text(
                      'Join Us To Start Searching',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                    child: Text(
                      'You can search course, apply course and find scholarship for abroad studies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: controller.namecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your Name";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: controller.emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: 'Email Address',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.obscureText.value =
                                      !controller.obscureText.value;
                                },
                                child: Icon(controller.obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          obscureText: controller
                              .obscureText.value, // Passwords are obscured
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            // You can add more validation rules here if needed
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: const Color(0xff68609c)),
                              ),
                              child: Obx(
                                () => RadioListTile(
                                  title: const Text('Patient'),
                                  value: 'Patient',
                                  groupValue: controller.userType!
                                      .value, // Access the value property
                                  onChanged: (value) {
                                    controller.userType!.value =
                                        value as String;
                                    if (kDebugMode) {
                                      print('User selected Patient');
                                    }
                                    // Add more actions as needed
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: const Color(0xff68609c)),
                                ),
                                child: Obx(
                                  () => RadioListTile(
                                    title: const Text('Doctor'),
                                    value: 'Doctor',
                                    groupValue: controller.userType!
                                        .value, // Access the value property
                                    onChanged: (value) {
                                      controller.userType!.value =
                                          value as String;
                                      if (kDebugMode) {
                                        print('User selected Doctor');
                                      }
                                      // Add more actions as needed
                                    },
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Obx(
                          () => CustomButton(
                              isLoading: controller.isLoading.value,
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              buttonTitle: "Create Account",
                              textClr: Colors.white,
                              clr: const Color(0xff68609c),
                              ontapp: () async {
                                if (controller.signUpKey.currentState!
                                    .validate()) {
                                  controller.signUp(
                                      controller.emailcontroller.text,
                                      controller.passwordController.text);
                                  controller.isLoading.value = true;
                                  // controller.namecontroller.clear();
                                  // controller.emailcontroller.clear();
                                  // controller.passwordController.clear();
                                }
    
                                // Get.toNamed(Routes.profileView);
                              }),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'or',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        contWidget(
                          FontAwesomeIcons.facebook,
                          () {},
                        ),
                        contWidget(FontAwesomeIcons.google, () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an Account?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.loginView);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xff68609c),
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  contWidget(IconData iconn, ontapp) {
    return GestureDetector(
      onTap: ontapp,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff68609c)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: FaIcon(
            iconn,
            size: 30,
          ),
        ),
      ),
    );
  }
}
