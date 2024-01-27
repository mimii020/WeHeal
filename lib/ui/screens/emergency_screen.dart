import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/emergency_request.dart';
import 'package:health_care_app/core/services/emergency_request_service.dart';
import 'package:health_care_app/core/services/user_service.dart';
import 'package:health_care_app/ui/screens/request_screen.dart';
import 'package:health_care_app/ui/widgets/category_card.dart';
import 'package:health_care_app/ui/widgets/custom_drawer.dart';
import 'package:health_care_app/ui/widgets/nav_bar.dart';
import 'package:health_care_app/ui/widgets/others_request_card.dart';
import 'package:lottie/lottie.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  RequestsService requestsService=RequestsService();
  User? user=FirebaseAuth.instance.currentUser;
  UserService userService=UserService();
  String username="";
 
  void initState(){
    super.initState();
    getUsername();
  }
  getUsername() async {
    username=await userService.getCurrentUser();
    setState(() {
      
    });
    
    print("THE USERNAME ISSS $username");
    
    }

  @override
  Widget build(BuildContext context) {
      
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Color(0xffD0E3FF),
        appBar: NavBar(),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:100,
                      height:100,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LottieBuilder.network("https://lottie.host/f2bec9b8-781e-4ac0-bcaa-364bd7dfd9d5/Ldv6ugDgI6.json"),
                      )
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(height:20),
                          
                              Text(
                                'Hello, ${username}', 
                                style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color:Colors.black),
                                textAlign: TextAlign.left,
                                
                              ),
                              SizedBox(height:5),
                           
                         AnimatedTextKit(
                          totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                'Do you need help?',textStyle: TextStyle(fontSize: 24),
                                speed: Duration(milliseconds: 100)
                              )
                            ]
                          )
                    
                    ]
                    ),
                  ],
                ),
               
                
                ),
               SizedBox(height:30),
               Center(
                 child: Container(
                  padding: EdgeInsets.all(15),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:Color(0xffABC3E6),
                  ),
                  width: MediaQuery.of(context).size.width-20,
                  child: Row(
                    children: [
                        Image.network("https://cdn-icons-png.freepik.com/256/3456/3456824.png?ga=GA1.1.1122023173.1705934706&semt=ais",width:100,fit: BoxFit.cover,),
                        SizedBox(width:15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("How do you feel?", style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            Text('We are ready to help you! '),
                            SizedBox(height: 10,),
          
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFFDDEE),
                                minimumSize: Size(190, 40),
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                              ),
                              onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestScreen()));
                              }, 
                              child: Text('Request',style: TextStyle(fontSize: 18),)
                              )
                           
                          ],
                        )
                    ]
                    ),
                 ),
               ),
          
               SizedBox(height:25,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10),
                 child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                   child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'How can we help you?',
                      prefixIcon: Icon(Icons.search),
                      
                    ),
                   ),
                 ),
               ),
               SizedBox(height:25),
               Container(
                  height:90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                           CategoryWidget(icon:"https://cdn-icons-png.freepik.com/128/8700/8700612.png?ga=GA1.1.1122023173.1705934706&semt=ais", categoryName: "Dentist",),
                           CategoryWidget(categoryName: "Surgeon", icon: "https://cdn-icons-png.freepik.com/128/3105/3105950.png?ga=GA1.1.1122023173.1705934706&semt=ais"),
                           CategoryWidget(categoryName: "Pharmacist", icon: "https://cdn-icons-png.freepik.com/128/2180/2180189.png?ga=GA1.1.1122023173.1705934706&semt=ais"),
                           CategoryWidget(categoryName: "Therapist", icon: "https://cdn-icons-png.freepik.com/128/11472/11472774.png?ga=GA1.1.1122023173.1705934706&semt=ais"),
                           CategoryWidget(categoryName: "Cardiologist", icon: "https://cdn-icons-png.freepik.com/256/833/833472.png?ga=GA1.2.1122023173.1705934706&semt=ais",),
                           CategoryWidget(categoryName: "Pediatrician", icon: "https://cdn-icons-png.freepik.com/256/4417/4417023.png?ga=GA1.2.1122023173.1705934706&semt=ais"),
                           CategoryWidget(categoryName: "Gastrologist", icon: "https://cdn-icons-png.freepik.com/256/5877/5877894.png?ga=GA1.2.1122023173.1705934706&semt=ais")
                          ],
                        ),
                      )
                    ],
                  ),
               ),
          
               SizedBox(height:25),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Check others requests ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      
                ]
                ),
                ),
          
                StreamBuilder<Object>(
                      stream: requestsService.getRequests(user!.uid),
                      builder: (context, AsyncSnapshot snapshot) {
                        var requests;
                        if(snapshot.hasData){
                           requests=snapshot.data.docs;
                         return SizedBox(
                        //  height:MediaQuery.of(context).size.height*0.6,
                           width:MediaQuery.of(context).size.width-50,
                           child:ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 scrollDirection: Axis.vertical,
                                 itemCount: requests.length,
                                 itemBuilder: (context, index) {
                                      print('hrlooooo');
                                       DocumentSnapshot ds=requests[index];
                                       var request=EmergencyRequest.fromMap(ds);
                                       print("IM HEREEE");
                                       print(request.type);
                                       return OthersRequestCard(request: request,requestId: ds.id,); 
                                        },
                                    ),
                         );
                        }
                        else if(snapshot.hasError){
                          return Text("OOPS Error");
                        }
                        else {
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