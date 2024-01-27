import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/post.dart';
import 'package:health_care_app/core/services/posts_service.dart';
import 'package:health_care_app/core/services/user_service.dart';
import 'package:health_care_app/ui/widgets/like_button.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final String postId;
  const PostCard({super.key, required this.post,required this.postId});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late DateTime timestamp;
  late String date;
  late String time; 
  late bool isLiked;
  late User? user=FirebaseAuth.instance.currentUser;
  final PostsService postService=PostsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timestamp=DateTime.fromMicrosecondsSinceEpoch(widget.post.timestamp.microsecondsSinceEpoch);
    date="${timestamp.year}/${timestamp.month}/${timestamp.day}";
    time="${timestamp.hour}:${timestamp.minute}";
    isLiked=widget.post.likes.contains(user!.uid);
  }
  toggle() async{
    setState(() {
      isLiked=!isLiked;
      print("im like");
      print("serviiice");

    });
     await postService.handlePostLike(widget.postId,isLiked);
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
                          width:MediaQuery.of(context).size.width-50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          margin: EdgeInsets.only(bottom:5, top:5),
                          child: IntrinsicWidth(
                            child: ListTile(
                              title:Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.post.username,style: TextStyle(color: Color(0xffABC3E6),fontWeight: FontWeight.bold,fontSize: 17)),
                                    Text("${date}   ${time}", style: TextStyle(fontSize: 12,color:Colors.deepPurple),)
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.post.content, textAlign: TextAlign.start,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        LikeButton(isLiked: isLiked, onTap: () async {await toggle();}),
                                        Text("${widget.post.likes.length}"),
                                        SizedBox(width:20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
  }
}