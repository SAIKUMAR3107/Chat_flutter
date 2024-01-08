import 'package:chatting_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get instance of user
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user Stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String recieverId, String message) async {
    //get current user info
    final String currentUsedId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp time = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderId: currentUsedId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        message: message,
        timeStamp: time);

    //construct chat room ID for two users (sorted for uniqueness)
    List<String> ids = [currentUsedId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }

  //recieve message
  Stream<QuerySnapshot> getMesssage(String userId, String otherUserId) {
    //construct a chat room id for two user
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timeStamp")
        .snapshots();
  }
}
