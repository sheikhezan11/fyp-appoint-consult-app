import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DrDashboardController extends GetxController {
  late String doctorUid;
  List<Map<String, dynamic>> checkList = [
    {"name": "Complete Appointment", "Total": 0, "color": 0xff36c4c5},
    {"name": "Pending Appointment", "Total": 0, "color": 0xff8c7bff},
    {"name": "Cancelled Appointment", "Total": 0, "color": 0xffff5f2d},
  ];

  var appointmentList = [].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    doctorUid = Get.arguments != null ? Get.arguments["doctorUid"] : "";
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
  try {
    var querySnapshot = await _firestore
        .collection('bookAppointment')
        .where('doctorUid', isEqualTo: doctorUid)
        .where('status', isEqualTo: 'Disapproved') // Filter appointments with status 'Disapproved'
        .get();

    var appointments = querySnapshot.docs.map((doc) {
      // ignore: unnecessary_cast
      var data = doc.data() as Map<String, dynamic>;
      data['documentId'] = doc.id;
      return data;
    }).toList();

    appointmentList.assignAll(appointments); // Update appointmentList with new data
    
    if (kDebugMode) {
      print(appointmentList); // Optionally print the updated list
    }
  } catch (error) {
    if (kDebugMode) {
      print("Error fetching appointments: $error");
    }
  }
}


  // void updateAppointmentStatus(String documentId, String status) async {
  //   try {
  //     await _firestore
  //         .collection('bookAppointment')
  //         .doc(documentId)
  //         .update({'status': status});
  //     var index = appointmentList
  //         .indexWhere((element) => element['documentId'] == documentId);
  //     if (index != -1) {
  //       appointmentList[index]['status'] = status;
  //       appointmentList.refresh();
  //       fetchAppointments(); // Refresh appointment list after updating status
  //     }
  //   } catch (e) {
  //     print("Error updating appointment status: $e");
  //   }
  // }

  // void approveAppointment(String documentId) {
  //   updateAppointmentStatus(documentId, 'Approved');
  // }

  // void disapproveAppointment(String documentId) {
  //   updateAppointmentStatus(documentId, 'Disapproved');
  // }
}
