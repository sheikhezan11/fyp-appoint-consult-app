import 'package:get/get.dart';

import '../../controller/voice_messenger/voice_messenger_controller.dart';


class VoiceMessengerBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => VoiceMessengerController());
  }
}