import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../constant/call_info.dart';
import '../../viewmodel/controller/voice_messenger/voice_messenger_controller.dart';


final int userID = Random().nextInt(1000);

class VoiceCallPage extends GetView<VoiceMessengerController> {
  const VoiceCallPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      userName: controller.userName,
      appID: CallInfo.appID,
      appSign: CallInfo.appSign,
      callID: controller.callId,
      userID: userID.toString(),
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
