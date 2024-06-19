import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:MedEase/viewmodel/controller/dashboard/dashboard_controller.dart';

import '../../model/chat_model.dart';
import '../../viewmodel/controller/chat_screen/chat_screen_controller.dart';

class ChatScreen extends GetView<ChatScreenController> {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(generateChatId(
                      controller.doctorUid, controller.patientUid))
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs.map((doc) {
                  return ChatMessageModel.fromMap(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    DateTime dateTime = message.timestamp.toDate();
                    String formattedTime =
                        DateFormat('hh:mm a').format(dateTime);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: message.senderUid ==
                                Get.find<DashboardController>().id
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: message.senderUid ==
                                      Get.find<DashboardController>().id
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.message,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Enter your message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              String message = messageController.text.trim();
              if (message.isNotEmpty) {
                await sendMessage(message);
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

 Future<void> sendMessage(String message) async {
  String chatId = generateChatId(controller.doctorUid, controller.patientUid);

  ChatMessageModel chatMessage = ChatMessageModel(
    senderUid: Get.find<DashboardController>().id,
    receiverUid: controller.doctorUid == Get.find<DashboardController>().id
        ? controller.patientUid
        : controller.doctorUid,
    message: message,
    timestamp: Timestamp.now(),
  );

  await FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .add(chatMessage.toMap());
}

String generateChatId(String uid1, String uid2) {
  List<String> uids = [uid1, uid2];
  uids.sort(); // Ensure consistent order to create the same chatId for any user combination
  return "${uids[0]}_${uids[1]}";
}

}
