import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DrDashboardController extends GetxController {
  late String doctorUid;
  RxList<Map<String, dynamic>> checkList = [
    {"name": "Complete Appointment", "Total": 0, "color": 0xff36c4c5},
    {"name": "Pending Appointment", "Total": 0, "color": 0xff8c7bff},
    {"name": "Cancelled Appointment", "Total": 0, "color": 0xffff5f2d},
  ].obs;

  var appointmentList = [].obs;
  var disapprovedAppointments = [].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _timer;

  @override
  void onInit() {
    doctorUid = Get.arguments != null ? Get.arguments["doctorUid"] : "";
    super.onInit();
    fetchAppointments();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetchAppointments();
      if (kDebugMode) {
        print("Fetching appointments...");
      }
    });
  }

  Future<void> fetchAppointments() async {
    try {
      var querySnapshot = await _firestore
          .collection('bookAppointment')
          .where('doctorUid', isEqualTo: doctorUid)
          .get();

      var appointments = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id;
        return data;
      }).toList();

      appointmentList.assignAll(appointments); // Update appointmentList with new data

      // Filter disapproved appointments
      var disapproved = appointments.where((appointment) => appointment['status'] == 'Disapproved').toList();
      disapprovedAppointments.assignAll(disapproved); // Update disapprovedAppointments with new data

      // Update checklist totals
      updateChecklistTotals();
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching appointments: $error");
      }
    }
  }

  void updateChecklistTotals() {
    int completed = appointmentList.where((appointment) => appointment['status'] == 'Completed').length;
    int pending = appointmentList.where((appointment) => appointment['status'] == 'Upcoming').length;
    int cancelled = appointmentList.where((appointment) => appointment['status'] == 'Cancelled').length;

    checkList[0]["Total"] = completed;
    checkList[1]["Total"] = pending;
    checkList[2]["Total"] = cancelled;

    checkList.refresh(); // Trigger update to UI
  }

  Future<void> disapproveRequest(String doctorUid, String appointmentDate, String type) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookAppointment')
          .where('doctorUid', isEqualTo: doctorUid)
          .where('appointmentDate', isEqualTo: appointmentDate)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update({'status': type});
      }

      if (kDebugMode) {
        print("Appointments Cancelled Successfully!");
      }
      fetchAppointments(); // Refresh the appointments list
    } catch (error) {
      if (kDebugMode) {
        print("Error cancelling appointments: $error");
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
