
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../model/doctormodel.dart';

class DoctorDetailController extends GetxController {
  RxBool expanded = false.obs;
  DoctorModel? detail;
  String doctorId = "";
  @override
  void onInit() {
    super.onInit();
    doctorId = Get.arguments != null ? Get.arguments['doctorId'] : "";
    detail = Get.arguments != null ? Get.arguments['detail'] : "";
    // getDoctorById(doctorId);
    if (kDebugMode) {
      print("doctor: $doctorId");
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<DoctorModel?> getDoctorById(String doctorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('doctors').doc(doctorId).get();
      if (snapshot.exists) {
        // Map snapshot data to Doctor model
        DoctorModel doctor = DoctorModel.fromJson(snapshot.data()!);
        if (kDebugMode) {
          print(doctor);
        }
        return doctor;
      } else {
        return null; // Doctor not found
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching doctor details: $e");
      }
      return null; // Error occurred
    }
  }
}
