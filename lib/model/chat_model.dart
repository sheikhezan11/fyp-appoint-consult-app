import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  String senderUid;
  String receiverUid;
  String message;
  Timestamp timestamp;

  ChatMessageModel({
    required this.senderUid,
    required this.receiverUid,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      senderUid: map['senderUid'],
      receiverUid: map['receiverUid'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}
