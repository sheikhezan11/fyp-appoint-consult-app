import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/navbar_model.dart';
import '../../../model/usermodel.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  UserModel? userModel;

  Future<void> fetchUserData(profileId) async {
    try {
      if (kDebugMode) {
        print(profileId);
      }
      // Get document snapshot from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(profileId) // Use user's UID to fetch specific document
          .get();

      if (snapshot.exists) {
        // If document exists, parse its data into UserModel
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        userModel = UserModel.fromMap(data);
      } else {
        if (kDebugMode) {
          print("Document does not exist");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching user data: $error");
      }
    }
  }
  static HomeController instance = Get.find();

  late NavbarModel navbarItems;
  Future<dynamic>? off(String page, {dynamic arguments}) async {
    int index = navbarItems.items.indexWhere(
      (element) => element.title.toLowerCase().contains(
            page.replaceAll("/", "").replaceAll("_", " "),
          ),
    );

    if ( navbarItems.currentRouteIndex == index) return;

    navbarItems = navbarItems.copyWith(currentRouteIndex: index);

    if (kDebugMode) {
      print(navbarItems.currentRouteIndex);
    }

    update(["bottom_nav_bar"]);

    await Get.offAllNamed(
      page,
      id: 1,
      arguments: arguments,
    );
  }


}
