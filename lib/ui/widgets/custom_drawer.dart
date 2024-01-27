import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/services/user_service.dart';
import 'package:health_care_app/ui/screens/auth_screen.dart';
import 'package:health_care_app/ui/screens/first_aid_screen.dart';
import 'package:health_care_app/ui/screens/first_screen.dart';
import 'package:health_care_app/ui/screens/login.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final UserService userService=UserService();
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding:EdgeInsets.all(0),
        children: [
          ListTile(
            onTap: () async {
                await userService.signOut();
              setState(() {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>FirstScreen()), (route) => false);
              });
             
             },
            title:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text("Log Out", style: TextStyle(color:Colors.deepPurple),)),
            )
          ),
            ListTile(
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FirstAid())),
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text("First-Aid",style: TextStyle(color:Colors.deepPurple),),),
            ),
          )
        ],
      ),
    );
  }
}