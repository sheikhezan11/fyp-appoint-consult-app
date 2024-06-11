import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/routes/pages.dart';
import '../../viewmodel/controller/dashboard/dashboard_controller.dart';

class ProfileBottom extends StatelessWidget {
  const ProfileBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(dashboardController.userModel?.profilepic ?? ""),
            ),
          ),
          Text(
            dashboardController.userModel?.fullname ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            dashboardController.userModel?.email ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: profileMethod(Icons.person_3_outlined, "Edit Prodile"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                profileMethod(Icons.notifications_outlined, "Notifiications"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                profileMethod(Icons.contact_support_outlined, "Help & Support"),
          ),
          GestureDetector(
            onTap: () async{
               try {
                    await FirebaseAuth.instance.signOut();
                   
                    Get.offAllNamed(Routes.loginView); // Example navigation using GetX
                  } catch (e) {
                    if (kDebugMode) {
                      print("Error signing out: $e");
                    }
                    // Handle error, if any
                  }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: profileMethod(Icons.logout, "Logout"),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox profileMethod(IconData Icon1, title) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icon1, color: Colors.black.withOpacity(0.5)),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.5))
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
