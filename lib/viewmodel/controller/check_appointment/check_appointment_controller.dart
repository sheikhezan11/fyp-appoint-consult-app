import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../model/bookappointment_model.dart';
import '../../../utils/doctors.dart';
import '../dashboard/dashboard_controller.dart';

class CheckAppointmentController extends GetxController {
  final DashboardController controller = Get.find<DashboardController>();
  var appointments = <BookAppointmentModel>[].obs;
  var upcomingAppointments = <BookAppointmentModel>[].obs;
  var completedAppointments = <BookAppointmentModel>[].obs;
  var cancelledAppointments = <BookAppointmentModel>[].obs;
  String chooseTime = '';
  String doctorId = "";
bool isAppointmentTime(String appointmentDate, String workingTime) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('d-M-yyyy h:mma');
    try {
      DateTime appointmentDateTime = dateFormat.parse('$appointmentDate $workingTime');
      // Allow a margin of error of a few minutes (e.g., 5 minutes) if needed
      return now.difference(appointmentDateTime).inMinutes.abs() <= 5;
    } catch (e) {
      // Log the error or handle it as needed
      if (kDebugMode) {
        print('Error parsing date: $e');
      }
      return false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
    getDoctorIds();
  }
  void onTimeSelected(String time) {
      // Update the selected time for the selected doctor
      selectedDoctor.selectedTime = time;
      chooseTime = selectedDoctor.selectedTime!;
      if (kDebugMode) {
        print(chooseTime);
      }
      // Update the UI by triggering a re-build
      update(["day"]);
    }

  Future<void> fetchAppointments() async {
    try {
      CollectionReference appointmentsRef =
          FirebaseFirestore.instance.collection('bookAppointment');
      QuerySnapshot querySnapshot =
          await appointmentsRef.where('uid', isEqualTo: controller.id).get();

      var allAppointments = querySnapshot.docs.map((doc) {
        return BookAppointmentModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      appointments.value = allAppointments;
      updateFilteredAppointments();
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching appointments: $error");
      }
    }
  }

  void updateFilteredAppointments() {
    upcomingAppointments.value = appointments
        .where((appointment) => appointment.status == 'Upcoming')
        .toList();
    completedAppointments.value = appointments
        .where((appointment) => appointment.status == 'Completed')
        .toList();
    cancelledAppointments.value = appointments
        .where((appointment) => appointment.status == 'Cancelled')
        .toList();
  }

  Future<List<String>> getBookAppointmentIds() async {
    List<String> appointmentIds = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bookAppointment').get();

      for (var doc in querySnapshot.docs) {
        appointmentIds.add(doc.id);
      }

      return appointmentIds;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching appointment IDs: $error");
      }
      return [];
    }
  }

  List<String> doctorsIdsCheck = [];

  Future<Map<String, String>> getDoctorIds() async {
    Map<String, String> doctorIds = {};

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      for (var doc in querySnapshot.docs) {
        doctorIds[doc.id] = doc['doctorUID']; // Assuming doctorUID is a field in the doctor document
      }
      if (kDebugMode) {
        print(doctorIds);
      }
      doctorsIdsCheck = doctorIds.keys.toList();
      await getDoctorWorkingTimes(doctorIds); // Call getDoctorWorkingTimes with doctorIds
      return doctorIds;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching doctor IDs: $error");
      }
      return {};
    }
  }

 Future<void> cancelAppointmentsForDoctorAndDate(String doctorUid, String appointmentDate) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bookAppointment')
        .where('doctorUid', isEqualTo: doctorUid)
        .where('appointmentDate', isEqualTo: appointmentDate)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({'status': 'Cancelled'});
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


  Doctor selectedDoctor = dummyDoctors[0];
  late Map<String, List<String>> doctorWorkingTimes; // Modify type to Map

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Modify to accept Map of doctorIds
  Future<void> getDoctorWorkingTimes(Map<String, String> doctorIds) async {
    try {
      doctorWorkingTimes = {}; // Clear previous data
      for (var doctorId in doctorIds.keys) {
        DocumentSnapshot<Map<String, dynamic>> doctorDoc = await _firestore
            .collection('doctors')
            .doc(doctorIds[doctorId]) // Use the doctor UID from the map
            .get();

        if (doctorDoc.exists) {
          String? workingTimeData = doctorDoc.data()?['workingTime'];
          if (workingTimeData != null && workingTimeData.isNotEmpty) {
            doctorWorkingTimes[doctorId] = workingTimeData.split(', '); // Store working times for each doctor
            if (kDebugMode) {
              print(doctorWorkingTimes);
            }
          } else {
            doctorWorkingTimes[doctorId] = [];
          }
        } else {
          doctorWorkingTimes[doctorId] = [];
        }
      }
    } catch (e) {
      doctorWorkingTimes = {};
      if (kDebugMode) {
        print('Error retrieving doctor\'s working time: $e');
      }
    }
    update(["day"]);
  }



Future<void> rescheduleAppointment(String appointmentId, String newDate, String newTime) async {
  try {
    // Reference to the appointment document
    DocumentReference appointmentRef = FirebaseFirestore.instance
        .collection('bookAppointment')
        .doc(appointmentId);

    // Get the appointment document
    DocumentSnapshot appointmentSnapshot = await appointmentRef.get();

    // Check if the appointment exists
    if (appointmentSnapshot.exists) {
      // Update the appointment data
      await appointmentRef.update({
        'appointmentDate': newDate,
        'workingTime': newTime,
      });

      if (kDebugMode) {
        print('Appointment rescheduled successfully!');
      }
    } else {
      if (kDebugMode) {
        print('Appointment not found!');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error rescheduling appointment: $error');
    }
  }
}


}
