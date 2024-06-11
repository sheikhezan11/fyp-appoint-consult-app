
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../resources/assets.dart';

class OnboardingItems {
  String images;
  String title;
  String subtitle;
  OnboardingItems({
    required this.images,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController =
      PageController(viewportFraction: 0.9, keepPage: true, initialPage: 0);
  var currentPage = 0.obs;
  RxDouble textOpacity = 1.0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void goToNextPage(int totalPages) {
    if (currentPage.value < totalPages - 1) {
      currentPage++;
    } else {}
  }

  final List items = RxList<OnboardingItems>([
    OnboardingItems(
        images: AssetsImages.on1,
        title: "Find Trusted Doctors",
        subtitle:
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old."),
    OnboardingItems(
        images: AssetsImages.on2,
        title: "Choose Best Doctors",
        subtitle:
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old."),
    OnboardingItems(
        images: AssetsImages.on3,
        title: "Easy Appointments",
        subtitle:
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old."),
  ]);
}