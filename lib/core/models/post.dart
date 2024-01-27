
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late DocumentReference userRef;
  late String content;
  List<dynamic> likes=[];
  String username="";
  late Timestamp timestamp;

  Post({ required this.content, required this.timestamp,});

  Post.fromMap(map){
    content=map["content"];
    username=map["username"];
    userRef=map["userRef"];
    timestamp=map["timestamp"];
    likes=map["likes"];
  }

  toMap(){
    return {
      "content":content,
      "username":username,
      "userRef":userRef,
      "timestamp":timestamp,
      "likes":likes,

    };
  }


}