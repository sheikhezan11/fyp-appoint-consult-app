import 'package:get/get.dart';

import '../../controller/doctor_detail/doctor_detail_controller.dart';

class DoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorDetailController());
  }
}
