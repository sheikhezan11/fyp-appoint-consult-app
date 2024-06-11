// RegisterController
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/doctormodel.dart';
import '../../../model/usermodel.dart';
import '../../../resources/routes/pages.dart';
import '../../helper/herlper.dart';

class RegisterController extends GetxController {
  UserModel? userModel;
  DoctorModel? doctorModel;
     final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  RxString? userType = 'Patient'.obs;
  RxBool obscureText = false.obs;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  void signUp(String email, String password) async {
  UserCredential? credential;

  try {
    isLoading.value = true;
    credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (ex) {
    if (kDebugMode) {
      print(ex.code.toString());
    }
  }

  if (credential != null) {
    String uid = credential.user!.uid;
    if (userType?.value == "Patient") {
      // Create UserModel for patients
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        fullname: namecontroller.text,
        profilepic: "",
      );

      // Save user data in Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((_) {
        if (kDebugMode) {
          print("New Patient Created!");
        }
        CustomSnackbar.show(Get.context!, "New Patient Created!");
        isLoading.value = false;

        // Navigate to patient profile view
        Get.toNamed(Routes.profileView, arguments: {
          "userModel": newUser,
          "firebaseUser": credential?.user!,
        });
      }).catchError((error) {
        if (kDebugMode) {
          print("Error creating user: $error");
        }
      });
    } else {
      // Create DoctorModel for doctors
      DoctorModel newDoctor = DoctorModel(
        uid: uid,
        email: email,
        doctorName: namecontroller.text,
        profilepic: "",
        // Add more doctor-specific fields here
      );

      // Save doctor data in Firestore
      await FirebaseFirestore.instance.collection("doctors").doc(uid).set(newDoctor.toMap()).then((_) {
        if (kDebugMode) {
          print("New Doctor Created!");
        }
        CustomSnackbar.show(Get.context!, "New Doctor Created!");

        isLoading.value = false;

        // Navigate to doctor profile view
        Get.toNamed(Routes.doctorProfile, arguments: {
          "doctorMod": newDoctor,
          "firebaseUser": credential?.user!,
        });
      }).catchError((error) {
        if (kDebugMode) {
          print("Error creating doctor: $error");
        }
      });
    }
  }
}


}
