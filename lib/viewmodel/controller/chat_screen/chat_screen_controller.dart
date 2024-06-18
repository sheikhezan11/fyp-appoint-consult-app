import 'package:get/get.dart';

class ChatScreenController extends GetxController{
  late String appointmentId;
  late String doctorUid;
  late String patientUid;

  @override
  void onInit() {
    appointmentId=Get.arguments!=null?Get.arguments['appointmentId']:"";
    doctorUid=Get.arguments!=null?Get.arguments['doctorUid']:"";
    patientUid=Get.arguments!=null?Get.arguments['patientUid']:"";
    super.onInit();
  }
}