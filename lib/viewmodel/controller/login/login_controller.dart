import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/routes/pages.dart';
import '../../helper/herlper.dart';

class LoginController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late GlobalKey<FormState> loginFormKey;
  RxBool isLoading = false.obs;
  RxBool isObscure = false.obs;
  RxString id = "".obs;

  void login(String email, String password) async {
    UserCredential? credential;
    try {
      isLoading.value = true;
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      if (kDebugMode) {
        print(ex.code.toString());
      }
      isLoading.value = false;
    }
    if (credential != null) {
      String uid = credential.user!.uid;

      // Check if user exists in either users or doctors collection
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();
      QuerySnapshot doctorsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('uid', isEqualTo: uid)
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        if (kDebugMode) {
          print("User found in users collection: $uid");
        }
        CustomSnackbar.show(Get.context!, "Patient logged In Successfully!");

        // Navigate to user dashboard
        Get.toNamed(Routes.dashboard, arguments: {"id": uid});
        return;
      } else if (doctorsSnapshot.docs.isNotEmpty) {
        if (kDebugMode) {
          print("User found in doctors collection: $uid");
        }
        // Navigate to doctor dashboard
        CustomSnackbar.show(Get.context!, "Doctor logged In Successfully!");

        Get.toNamed(Routes.newPassword);
        return;
      } else {
        if (kDebugMode) {
          print("User not found in users or doctors collection");
        }
      }
    }
  }

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    super.onInit();
  }
}
