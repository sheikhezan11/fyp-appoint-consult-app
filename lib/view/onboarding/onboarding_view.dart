import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resources/routes/pages.dart';
import '../../utils/custom_button.dart';
import '../../viewmodel/controller/onboarding/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller=Get.put(OnboardingController());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50, right: 20),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Routes.loginView);
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff68609c),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 600,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          controller.currentPage.value = index;
                        },
                        controller: controller.pageController,
                        itemCount: controller.items.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Image.asset(
                                  controller.items[index].images,
                                  // scale: 1.1,
                                  width: 400,
                                  height: 400,
                                ),
                              ),
                              Text(
                                controller.items[index].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24, color: Color(0xff68609c)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        controller.items[index].subtitle,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SmoothPageIndicator(
                                    controller: controller.pageController,
                                    count: controller.items.length,
                                    effect: const ExpandingDotsEffect(
                                        activeDotColor: Color(0xff68609c),
                                        dotWidth: 15,
                                        dotHeight: 13)),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomButton(
              
                clr: const Color(0xff68609c),
                textClr: Colors.white,
                buttonTitle: "NEXT",
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                ontapp: () {
                  int nextPageIndex = controller.currentPage.value + 1;

                  if (nextPageIndex == controller.items.length) {
                     Get.offAllNamed(Routes.loginView);
                  } else {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
