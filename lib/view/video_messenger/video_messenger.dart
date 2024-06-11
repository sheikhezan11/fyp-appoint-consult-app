import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../constant/call_info.dart';
import '../../viewmodel/controller/video_messenger/video_messenger_controller.dart';


final int userID = Random().nextInt(1000);

class VideoCallPage extends GetView<VideoMessengerController> {
  const VideoCallPage({
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
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
