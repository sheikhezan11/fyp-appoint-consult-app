import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/bookappointment_model.dart';
import '../../../model/doctormodel.dart';
import '../../../utils/doctors.dart';
import '../dashboard/dashboard_controller.dart';

class BookAppointmentController extends GetxController {
  String doctorId = "";
  String chooseTime='';
  void onTimeSelected(String time) {
    // Update the selected time for the selected doctor
    selectedDoctor.selectedTime = time;
    chooseTime=selectedDoctor.selectedTime!;
    if (kDebugMode) {
      print(chooseTime);
    }
    // Update the UI by triggering a re-build
    update(["day"]);
  }

  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  Doctor selectedDoctor = dummyDoctors[0]; // Default doctor selection
  DateTime visibleMonth =
      DateTime.now(); // Add this line to maintain the visible month

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      // Update the visible month to the selected date's month
      visibleMonth = DateTime(picked.year, picked.month);
      update(["day"]); // Ensure to trigger UI update after selecting a date
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    // Update the visible month only if the selected day is within the visible month
    if (selectedDay.month == focusedDay.month &&
        selectedDay.year == focusedDay.year) {
      visibleMonth = DateTime(selectedDay.year, selectedDay.month);
    }
    update(["day"]); // Ensure to trigger UI update after selecting a day
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getDoctorData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('doctors').doc(uid).get();
      return snapshot.data();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching doctor data: $e");
      }
      return null;
    }
  }

  late List<String> doctorWorkingTimes;
  late DoctorModel doctorModel;
  BookAppointmentModel bookAppointmentModel = BookAppointmentModel();

  @override
  void onInit() {
    print(dashboardController.id);
    doctorId = Get.arguments != null ? Get.arguments["doctorId"] : "";
    doctorModel = Get.arguments != null
        ? Get.arguments["doctorDetail"]
        : DoctorModel(); // Proper initialization
    doctorWorkingTimes = [];
    if (kDebugMode) {
      print("Doctor Info: ${doctorModel.aboutDoctor}");
    }
      super.onInit();
    // Call getDoctorWorkingTimes and store the result in doctorWorkingTimes
    getDoctorWorkingTimes(doctorId);
  }

  Future<void> getDoctorWorkingTimes(String doctorUID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doctorDoc =
          await _firestore.collection('doctors').doc(doctorUID).get();

      if (doctorDoc.exists) {
        String? workingTimeData = doctorDoc.data()?['workingTime'];
        if (workingTimeData != null && workingTimeData.isNotEmpty) {
          doctorWorkingTimes = workingTimeData.split(', ');
          if (kDebugMode) {
            print(doctorWorkingTimes);
          }
        } else {
          doctorWorkingTimes = [];
        }
      } else {
        doctorWorkingTimes = [];
      }
    } catch (e) {
      doctorWorkingTimes = [];
      if (kDebugMode) {
        print('Error retrieving doctor\'s working time: $e');
      }
    }
    update(["day"]);
  }

  final DashboardController dashboardController =
      Get.put(DashboardController());
  String jadoId="";
  Future<void> uploadAppointmentData() async {
  try {
    String? profileImage = doctorModel.profilepic;
    String? fullName = doctorModel.doctorName;
    String? doctorSpeciality = doctorModel.doctorSpeciality;
    String? doctorAddress = doctorModel.doctorAddress;
    String? email = doctorModel.email;

    String date = '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    String appointmentTime = chooseTime;

    bookAppointmentModel = BookAppointmentModel(
      uid: dashboardController.id,
      doctorName: fullName,
      profilePic: profileImage,
      doctorSpeciality: doctorSpeciality,
      doctorAddress: doctorAddress,
      doctorDate: date,
      email: email,
      doctorTime: appointmentTime,
      status: "Disapproved",
      doctorUid: doctorModel.uid,
      userEmail: dashboardController.userModel?.email,
      userName: dashboardController.userModel?.fullname,
      userProfilePic: dashboardController.userModel?.profilepic,
    );

    // Nullify the parameters after they are used
    profileImage = "";
    fullName = "";
    doctorSpeciality = "";
    doctorAddress = "";
    email = "";

    // Get a reference to the collection
    CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection("bookAppointment");

    // Add the document to the collection and get the document reference
    DocumentReference docRef = await appointmentsCollection.add(bookAppointmentModel.toMap());

    // Get the generated document ID
    String documentId = docRef.id;
    jadoId=documentId;
    // Create a map with the appointment data including the document ID
    Map<String, dynamic> appointmentData = bookAppointmentModel.toMap();
    appointmentData['documentId'] = documentId;

    // Update the document in Firestore with the appointment data including the document ID
    await docRef.update(appointmentData);

    if (kDebugMode) {
      print("Document ID: $documentId");
      print("Data uploaded successfully!");
    }
  } catch (error) {
    if (kDebugMode) {
      print("Error uploading data: $error");
    }
  }
}


}
