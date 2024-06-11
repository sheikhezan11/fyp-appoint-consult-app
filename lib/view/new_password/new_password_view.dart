import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/assets.dart';
import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
             Padding(
              padding:const EdgeInsets.only(left: 10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.close(-1);
                    },
                    child:const Icon(
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
                     
            const Text(
              'Create New Password',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              'Your new password must be different from previously used password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10.0,vertical: 10.0),
              child: SizedBox(
                height: 60.0,
                child: TextField(
                  // controller: emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.visibility_off)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10.0, ),
              child: SizedBox(
                height: 60.0,
            
                child: TextField(
                  // controller: emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Confirm Password',
                      suffixIcon: const Icon(Icons.visibility_off)),
                ),
              ),
            ),
            FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    buttonTitle: "Reset Password",
                    textClr: Colors.white,
                    clr: const Color(0xff68609c),
                    ontapp: () {
                      Get.toNamed(Routes.registerView);
                    },
                  ),
                )),
           
                    ],
                  ),
          )),
    );
  }
}
