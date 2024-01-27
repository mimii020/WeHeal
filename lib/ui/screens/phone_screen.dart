import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/first_aid_screen.dart';
import 'package:health_care_app/ui/widgets/custom_drawer.dart';
import 'package:health_care_app/ui/widgets/nav_bar.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  Color phoneColor=Color(0xff122965);
  Color circcleColor=Colors.white;
  String messageWhenCalling="Calling the nearest emergency service, in the meantime do the first-aid";
  String message="tap to call the nearest emergency service";
  
  void toggle(){
    setState(() {
        Color auxColor=phoneColor;
        phoneColor=circcleColor;
        circcleColor=auxColor;
        String auxMsg=message;
        message=messageWhenCalling;
        messageWhenCalling=auxMsg;
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Color(0xffABC3E6),
        appBar: NavBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  toggle();
                },
                child: Container(
                  width:300,
                  height:300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: circcleColor,
                    ),
                  child: Icon(Icons.phone,size: 90, color: phoneColor,),
                ),
              ),
            ),
            SizedBox(height:50),
            Text(message,textAlign:TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextButton(
              onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FirstAid())), 
              child: Text("First Aid")
              )
          ],
        ),
        )
      );
  }
}