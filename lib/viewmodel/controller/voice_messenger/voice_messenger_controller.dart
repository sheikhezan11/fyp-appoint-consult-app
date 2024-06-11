import 'package:get/get.dart';

class VoiceMessengerController extends GetxController{
   late String callId="";
  late String userName="";

  @override
  void onInit() {
    callId=Get.arguments!=null?Get.arguments["callId"]:"";
    userName=Get.arguments!=null?Get.arguments["userName"]:"";
    super.onInit();
  }
}