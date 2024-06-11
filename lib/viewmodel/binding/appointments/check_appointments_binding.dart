import 'package:get/get.dart';

import '../../controller/check_appointment/check_appointment_controller.dart';

class CheckAppointmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CheckAppointmentController());
  }

}