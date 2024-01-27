import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  late String content;
  late String senderId;
  late String receiverId;
  late String receiverUsername;
  late String senderUsername;
  late Timestamp timestamp;


  Message({required this.content, required this.receiverId, required this.senderId, required this.timestamp, required this.receiverUsername,required this.senderUsername});

  Message.fromMap(map){
    content=map["content"];
    senderId=map["senderId"];
    receiverId=map["receiverId"];
    receiverUsername=map["receiverUsername"];
    timestamp=map["timestamp"];
    senderUsername=map["senderUsername"];
    
  }

  toMap(){
    return {
      "content":content,
      "senderId":senderId,
      "receiverId":receiverId,
      "timestamp":timestamp,
      "receiverUsername":receiverUsername,
      "senderUsername":senderUsername,
      
    };
  }
}