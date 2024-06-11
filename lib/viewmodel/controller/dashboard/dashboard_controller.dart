import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import '../../../model/usermodel.dart';
import '../../../view/appointments/check_appointments.dart';
import '../../../view/home/home_view.dart';
import '../../../view/location/location_view.dart';
import '../../../view/profile_bottom/profile_bottom_view.dart';
import '../login/login_controller.dart';

class DashboardController extends GetxController{
    final LoginController controller=Get.put(LoginController());
  UserModel? userModel;
RxInt selectedIndex = 0.obs;
  final List<Widget> screens = [
    const HomeView(),
    const LocationView(),
    const CheckAppointments(),
    const ProfileBottom()
    // Add your other views here
  ];
 late String id;
  Future<void> fetchUserData() async {
    try {
      if (kDebugMode) {
        print(id);
      }
      // Get document snapshot from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(id) // Use user's UID to fetch specific document
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

  void fetchAndSetUserData() async {
  await fetchUserData();
  // Now you can use the fetched user data as needed
  if (kDebugMode) {
    print("User data: ${userModel.toString()}");
    print("User id: ${userModel?.uid.toString()}");
  }
}


@override
  void onInit() {
        id = Get.arguments != null ? Get.arguments['id'] : "";
   fetchAndSetUserData();
    super.onInit();
  }

  
}