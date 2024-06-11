import 'package:get/get.dart';

import '../../controller/categories/categories_controller.dart';


class CategoryBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => CategoryController());
  }
}