import 'package:get/get.dart';

import '../../controller/location_view/location_view_controller.dart';
class LocationBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => LocationController());
  }
}