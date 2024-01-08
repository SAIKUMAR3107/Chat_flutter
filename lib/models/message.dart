import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String senderId;
  String senderEmail;
  String recieverId;
  String message;
  Timestamp timeStamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.timeStamp
  });

  Map<String,dynamic> toMap() {
    return {
      'senderId' : senderId,
      'senderEmail' : senderEmail,
      'recieverId' : recieverId,
      'message' : message,
      'timeStamp' : timeStamp
    };
  }

}