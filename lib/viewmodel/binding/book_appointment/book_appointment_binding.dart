import 'package:get/get.dart';

import '../../controller/book_appointment/book_appointment_controller.dart';

class BookAppointmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BookAppointmentController());
  }

}