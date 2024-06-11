import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

import '../../resources/assets.dart';
import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff68609c)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child:  GestureDetector(
                         onTap: (){
                      Get.close(-1);
                    },
                        child: const Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.asset(
                    AssetsImages.logo1,
                    scale: 2.1,
                  ),
                ),
                const SizedBox(height: 10.0,),
                const Text(
                  'Verify Code',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 10),
                  child: Text(
                    'Your new password must be different from previously used password',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Pinput(
                  length: 5,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  // ignore: avoid_print
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: CustomButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        buttonTitle: "Verify",
                        textClr: Colors.white,
                        clr: const Color(0xff68609c),
                        ontapp: () {
                          Get.toNamed(Routes.newPassword);
                        },
                      ),
                    )),
                      Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't get the code?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                          },
                          child: const Text(
                            "Resend",
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
            ),
          )),
    );
  }
}
