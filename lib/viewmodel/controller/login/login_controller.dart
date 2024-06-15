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
    isLoading.value = false;

    String errorMessage;
    switch (ex.code) {
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided.';
        break;
      default:
        errorMessage = ex.message ?? 'An undefined error occurred.';
    }

    if (kDebugMode) {
      print('FirebaseAuthException: ${ex.code} - ${ex.message}');
    }

    CustomSnackbar.show(Get.context!, errorMessage);
    return; // Exit the function if there's an error
  } catch (ex) {
    isLoading.value = false;

    String errorMessage = 'An error occurred. Please try again later.';
    if (kDebugMode) {
      print('Exception: $ex');
    }

    CustomSnackbar.show(Get.context!, errorMessage);
    return; // Exit the function if there's an error
  }

  // ignore: unnecessary_null_comparison
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
      CustomSnackbar.show(Get.context!, "Patient logged in successfully!");

      // Navigate to user dashboard
      Get.toNamed(Routes.dashboard, arguments: {"id": uid});
    } else if (doctorsSnapshot.docs.isNotEmpty) {
      if (kDebugMode) {
        print("User found in doctors collection: $uid");
      }
      CustomSnackbar.show(Get.context!, "Doctor logged in successfully!");

      // Navigate to doctor dashboard
      Get.toNamed(Routes.newPassword);
    } else {
      if (kDebugMode) {
        print("User not found in users or doctors collection");
      }
      CustomSnackbar.show(Get.context!, "User not found.");
    }
    isLoading.value = false; // Make sure to set isLoading to false after processing
  }
}



  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    super.onInit();
  }
}
