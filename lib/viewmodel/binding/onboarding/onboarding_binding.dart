import 'package:get/get.dart';

import '../../controller/onboarding/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => OnboardingController());
  }
}