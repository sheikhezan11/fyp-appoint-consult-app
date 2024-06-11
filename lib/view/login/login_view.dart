import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';
import '../../viewmodel/controller/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller=Get.put(LoginController());
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
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
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                    child: SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        controller: controller.emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Email Address',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more validation rules here if needed
                          return null;
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: TextFormField(
                        controller: controller.passwordcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isObscure.value =
                                    !controller.isObscure.value;
                              },
                              child: Icon(controller.isObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        obscureText: controller.isObscure.value,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,vertical: 10.0),
                    child: Obx(
                      () => CustomButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        buttonTitle: "Login",
                        textClr: Colors.white,
                        clr: const Color(0xff68609c),
                        isLoading: controller.isLoading.value,
                        ontapp: () {
                          if (controller.loginFormKey.currentState!
                              .validate()) {
                            controller.login(
                                controller.emailcontroller.text.trim(),
                                controller.passwordcontroller.text.trim());
                            controller.isLoading.value = true;
                            controller.emailcontroller.clear();
                            controller.passwordcontroller.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 12.0),
                                      child: Container(
                                        width: 100,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 40.0, left: 30),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Forgot password",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xff68609c),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 30, right: 30),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Enter your email for the verification proccesss, we will send password change link to your email.",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 30),
                                      child: FadeInUp(
                                        duration: const Duration(
                                            milliseconds: 1000),
                                        child: TextField(
                                          // controller: emailcontroller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12)),
                                            labelText: 'Email ',
                                          ),
                                        ),
                                      ),
                                    ),
                                    FadeInUp(
                                        duration: const Duration(
                                            milliseconds: 1200),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0,
                                              vertical: 10.0),
                                          child: CustomButton(
                                              clr: const Color(0xff68609c),
                                              textClr: Colors.green,
                                              buttonTitle: "Send",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50.0,
                                              ontapp: () {
                                                Get.toNamed(Routes.otpView);
                                              }),
                                        )),
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff68609c)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.registerView);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Color(0xff68609c),
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
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
