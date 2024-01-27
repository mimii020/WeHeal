import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/user.dart';
import 'package:health_care_app/core/services/user_service.dart';
import 'package:health_care_app/ui/widgets/custom_drawer.dart';
import 'package:health_care_app/ui/widgets/nav_bar.dart';
import 'package:health_care_app/ui/widgets/user_card.dart';

class ConnectWithOthers extends StatefulWidget {
  const ConnectWithOthers({super.key});

  @override
  State<ConnectWithOthers> createState() => _ConnectWithOthersState();
}

class _ConnectWithOthersState extends State<ConnectWithOthers> {
  UserService userService=UserService();
  User? currentUser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        appBar: NavBar(),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(0)),
                  color:Color(0xffABC3E6),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Connect with \n our doctors \n and other patients!",
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                          )
                        ]
                        )
                       
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network("https://cdn-icons-png.freepik.com/256/5112/5112800.png?ga=GA1.2.1122023173.1705934706&semt=ais",fit:BoxFit.contain,height: 100,),
                    ),
                  ],
                )
              ),
          
              SizedBox(height:50),
              StreamBuilder(
                stream: userService.getAllUsers(), 
                builder: (context,AsyncSnapshot snapshot){
                  var users;
                  if(snapshot.hasData){
                    users=snapshot.data.docs;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.5,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: ((context, index) {
                          String chatName;
                          DocumentSnapshot ds=users[index];
                          AppUser user=AppUser.fromMap(ds);
                          if(ds.id==currentUser!.uid){
                            chatName="You";
                          }
                          else{
                            chatName=user.username;
                          }
                          return UserCard(receiver:user,receiverId: ds.id,chatName:chatName);
                        })
                        ),
                    );
                  }
                  else{
                    return CircularProgressIndicator();
                  }
                }
                ),
            ],
          ),
        )
       
        )
      );
  }
}