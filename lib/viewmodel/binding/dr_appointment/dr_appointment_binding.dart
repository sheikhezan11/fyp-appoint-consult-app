import 'package:MedEase/viewmodel/controller/dr_appointment/dr_appointment_controller.dart';
import 'package:get/get.dart';


class DrAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrAppointmentController());
  }
}
