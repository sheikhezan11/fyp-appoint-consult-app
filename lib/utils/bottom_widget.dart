import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../view/appointments/check_appointments.dart';
import '../view/home/home_view.dart';
import '../view/location/location_view.dart';
import '../view/profile_bottom/profile_bottom_view.dart';
import '../viewmodel/controller/check_appointment/check_appointment_controller.dart';
import '../viewmodel/controller/home/home_controller.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  final HomeController homeController = Get.put(HomeController());
  final CheckAppointmentController checkAppointmentController =
      Get.put(CheckAppointmentController());
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeView(),
    const LocationView(),
    const CheckAppointments(),
    const ProfileBottom(),
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _getCurrentScreen(),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMaterialButton(Icons.home_filled, 0),
                _buildMaterialButton(Icons.location_on_outlined, 1),
                _buildMaterialButton(Icons.calendar_month_outlined, 2),
                _buildMaterialButton(Icons.person_2_outlined, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCurrentScreen() {
    return screens[currentTab];
  }

  Widget _buildMaterialButton(IconData icon, int index) {
    bool isSelected = index == currentTab;

    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentTab = index;
          });
        },
        child: Icon(
          icon,
          size: 30,
          color: isSelected ? const Color(0xff68609c) : Colors.black,
        ),
      ),
    );
  }
}
