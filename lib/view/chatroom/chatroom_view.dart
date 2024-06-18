import 'package:MedEase/model/chat_model.dart';
import 'package:MedEase/viewmodel/controller/chat_screen/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../viewmodel/controller/dashboard/dashboard_controller.dart';

class ChatScreen extends GetView<ChatScreenController> {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(controller.appointmentId)
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
                    return ListTile(
                      title: Text(message.message),
                      subtitle: Text(message.senderUid == controller.doctorUid
                          ? 'Doctor'
                          : 'Patient'),
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
        .doc(controller.appointmentId)
        .collection('messages')
        .add(chatMessage.toMap());
  }
}
