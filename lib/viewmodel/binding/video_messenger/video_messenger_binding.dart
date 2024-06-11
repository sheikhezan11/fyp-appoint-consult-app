import 'package:get/get.dart';

import '../../controller/video_messenger/video_messenger_controller.dart';


class VideoMessengerBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => VideoMessengerController());
  }
}