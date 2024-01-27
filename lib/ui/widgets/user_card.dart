import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/user.dart';
import 'package:health_care_app/ui/screens/chat_screen.dart';

class UserCard extends StatefulWidget {
  final String receiverId;
  final AppUser receiver;
  final String chatName;
  const UserCard({super.key, required this.receiverId, required this.receiver, required this.chatName});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                   minimumSize: Size(190, 40),
                   shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                           ),
                  ),
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ChatScreen(receiverId:widget.receiverId,
          receiverUsername: widget.receiver.username,)
          )
          );
      
        },
        child: Text(widget.chatName,style: TextStyle(
          color:Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
          ),
          ),
      ),
    );
  }
}