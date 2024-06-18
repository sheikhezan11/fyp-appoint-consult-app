import 'package:get/get.dart';

import '../../controller/dr_dashboard/dr_dashboard_controller.dart';

class DrDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrDashboardController());
  }
}
