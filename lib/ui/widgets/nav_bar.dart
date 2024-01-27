import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/connect_with_others_screen.dart';
import 'package:health_care_app/ui/screens/emergency_screen.dart';
import 'package:health_care_app/ui/screens/medication_scheduler.dart';
import 'package:health_care_app/ui/screens/phone_screen.dart';
import 'package:health_care_app/ui/screens/posts_screen.dart';

class NavBar extends AppBar {
   NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
     return AppBar(
         leading: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed:(){
                      Scaffold.of(context).openDrawer();
                    } , 
                    icon: Icon(Icons.menu,color:Color(0xFFABC3E6))
                  ),     
              
         title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  IconButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFFABC3E6),
                    icon:Icon(Icons.home_filled) ,
                    onPressed: ()=>(Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PostsScreen()))), 
                    
                    ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFFABC3E6),
                    onPressed: ()=>(Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MedicationScheduler()))), 
                    icon: Icon(Icons.medication)
                    ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFFABC3E6),
                    onPressed: ()=>(Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>EmergencyScreen()))), 
                    icon: Icon(Icons.emergency_outlined),
                    ),   
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed:()=>(Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PhoneScreen()))) , 
                    icon: Icon(Icons.phone,color: Color(0xFFABC3E6))
                    ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ConnectWithOthers())), 
                    icon: Icon(Icons.message_outlined, color: Color(0xFFABC3E6))
                    ),
              ]
              )
     
         
       );
  }
}