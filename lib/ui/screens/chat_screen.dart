import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/message.dart';
import 'package:health_care_app/core/services/chat_service.dart';
import 'package:health_care_app/ui/screens/connect_with_others_screen.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverUsername;
  const ChatScreen({super.key, required this.receiverId, required this.receiverUsername});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController=TextEditingController();
  final ChatService chatService=ChatService();
  User? user=FirebaseAuth.instance.currentUser;


  void sendMessage() async {
    if(messageController.text.isNotEmpty){
       await chatService.sendMessage(widget.receiverId, messageController.text);
       messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
                icon: Icon(Icons.arrow_back,color:Color(0xffABC3E6)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ConnectWithOthers())
                )
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(width:50),
            Center(
              child: Text(widget.receiverUsername,style: TextStyle(
                color:Color(0xffABC3E6), 
                fontSize: 20, 
                fontWeight: FontWeight.bold
                ),
                ),
            ),
            SizedBox(width:120)
            

            ]
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder(
                stream: chatService.getMessges(user!.uid, widget.receiverId), 
                builder: (context,AsyncSnapshot snapshot){
                  var messages;
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Text("Loading");
                  }
                  else if(snapshot.hasData){
                    messages=snapshot.data.docs;
                    return SizedBox(
                      height:MediaQuery.of(context).size.height*0.83,
                      child: ListView.builder(
                        itemCount:messages.length ,
                        itemBuilder: (context,index){
                          var document=messages[index];
                          return buildMessageItem(document);
                        }
                        ),
                    );
                  }
                  else{
                    return CircularProgressIndicator();
                  }
                }
                ),
              Container(
                color:Colors.white,
                width:MediaQuery.of(context).size.width,
                height: 50,
                child: TextField(
                  controller: messageController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Enter your message",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color:Color(0xffABC3E6)),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                                onPressed: () {
                                         sendMessage();
                                       }, 
                                icon: Icon(Icons.arrow_forward,color:Color(0xffABC3E6), size: 40,)
                          )
                  ),
                  
                ),
              ),
                
            ],
          ),
        ),
    )
    );
  }

 Widget buildMessageItem(DocumentSnapshot document){
     var message= Message.fromMap(document.data());
     DateTime timestamp=DateTime.fromMicrosecondsSinceEpoch(message.timestamp.microsecondsSinceEpoch);
          
                    String date="${timestamp.year}/${timestamp.month}/${timestamp.day}";
                    String time="${timestamp.hour}:${timestamp.minute}";
     String subText=(message.senderId==user!.uid)
         ? "You"
         : message.senderUsername;
     var alignment=(message.senderId==user!.uid) 
      ? Alignment.centerRight
      : Alignment.centerLeft;
      CrossAxisAlignment crossAxisAlignment=(message.senderId==user!.uid)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start;
      
      Color color=(message.senderId==user!.uid)
         ? Colors.white
         :Color(0xffABC3E6);
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
        crossAxisAlignment: crossAxisAlignment,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(subText, style: TextStyle(fontWeight: FontWeight.bold,color:Colors.deepPurple),),
           ),
           DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:  Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
           
                )
              ],
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            
            
            child: UnconstrainedBox(
             
              alignment:alignment,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(message.content),
              )
              ),
            ),

            Center(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("$date  $time",style: TextStyle(color:Colors.deepPurple),),
            )),
         ],
       ),
     );

  }
}