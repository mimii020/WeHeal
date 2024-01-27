import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/core/models/message.dart';

class ChatService{

  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  User? user=FirebaseAuth.instance.currentUser;

  sendMessage(String receiverId, String content) async {
    Timestamp timestamp=Timestamp.now();
    String receiverUsername= await firestore.collection('users').doc(receiverId).get().then((snapshot) => snapshot.data()!['username']);
    String senderUsername=await firestore.collection('users').doc(user!.uid).get().then((snapshot) => snapshot.data()!['username']);
    Message  message=Message(
          timestamp: timestamp,
          senderId: user!.uid,
          receiverId: receiverId,
          content:content,
          receiverUsername: receiverUsername,
          senderUsername: senderUsername,
          
    );

    List<String> ids=[receiverId,user!.uid];
    ids.sort();
    String chatRoomId=ids.join('_');
    await firestore.collection('chats').doc(chatRoomId)
                                       .collection('messages')
                                       .add(message.toMap());
  }

  getMessges(String userId, String otherUserId){
    List<String> ids=[userId, otherUserId];
    ids.sort();
    String chatRoomId=ids.join("_");
    return firestore.collection('chats')
                    .doc(chatRoomId)
                    .collection('messages')
                    .orderBy('timestamp', descending: false)
                    .snapshots();
  }
}