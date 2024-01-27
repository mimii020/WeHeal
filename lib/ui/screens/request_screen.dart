import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:health_care_app/core/models/emergency_request.dart';
import 'package:health_care_app/core/services/emergency_request_service.dart';
import 'package:health_care_app/ui/widgets/request_card.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  TextEditingController severityController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  RequestsService requestsService=RequestsService();
  User? user=FirebaseAuth.instance.currentUser;
  List<dynamic> items=["food","blood donation","clothes", "therapist"];
  String groupVal="blood donation";
  String type="blood donation";
  String typeImage="";

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         floatingActionButton: FloatingActionButton(
          shape:CircleBorder(),
          backgroundColor: Color(0xff122965),
          onPressed: ()=>showDialog(context: context,builder: (context) =>StatefulBuilder(
            builder:(context,setState)=> AlertDialog(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) ,
              title:Image.network("https://cdn-icons-png.freepik.com/256/4957/4957161.png?ga=GA1.1.1122023173.1705934706&semt=ais", height:40),
              content:SizedBox(
                height:350,
                width:600,
                child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      DropdownButton(
                        value: groupVal,
                        onChanged: (String? value) async {
                          setState(() {
                            groupVal=value!;
                            type=value;
                            
                            
                            
                          });
                          
            
                        },
                        items: items.map((e) => DropdownMenuItem<String>( 
                          value:e,
                          child: Text(e),
                        )).toList(), 
                        ),
                      
                       Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                     child: TextField(
                      controller: severityController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'severity',
                        prefixIcon: Icon(Icons.dangerous),
                        
                      ),
                     ),
                   ),
                   Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                     child: TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'number',
                        prefixIcon: Icon(Icons.person),
                        
                      ),
                     ),
                   ),
                   
                   SizedBox(height:10),
                   Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          severityController.clear();
                          numberController.clear();
                          
                          Navigator.pop(context);
                        }, 
                        child:Text("Cancel",style: TextStyle(fontSize: 20),)
                        ),
                        SizedBox(width:20),
                      ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFFDDEE),
                                minimumSize: Size(100, 30),
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                              ),
                              onPressed: () async {
                                  
                                  EmergencyRequest request=EmergencyRequest(type: type, number: numberController.text.trim(), severity: severityController.text.trim(),);
                                  await  requestsService.addRequests(user!.uid, request);
            
                                  
                                  Navigator.pop(context);
                              }, 
                              child: Text('Add',style: TextStyle(fontSize: 20),)
                              )
                    ],
                   )
                   
                     ],
                   ),
                          
                   
                 ),
              ),
            ),
          ),),
          child:Icon(Icons.add, color: Colors.white,)
          ), 
        body:SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(flip:false,reverse:false), // Replace with your desired clipper
                child: Container(
                width:MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height*0.3,
                color: Color(0xffABC3E6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.deepPurple,)),
                    Center(child: Image.network("https://cdn-icons-png.freepik.com/256/6454/6454381.png?ga=GA1.1.1122023173.1705934706&semt=ais",fit: BoxFit.contain,height: 170,)),
                  ],
                ),
                ),
              ),
              SizedBox(height:50),
              Padding(
                padding: EdgeInsets.all(10),
                child:Text("Your volunteer service requests", style:TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 20)),
              ),
              StreamBuilder<Object>(
                stream: requestsService.getUserRequests(user!.uid),
                builder: (context, AsyncSnapshot snapshot) {
                  var requests;
                  if(snapshot.hasData){
                     requests=snapshot.data.docs;
                   return SizedBox(
                     width:MediaQuery.of(context).size.width-25,
                     child: GridView.builder(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           scrollDirection: Axis.vertical,
                           itemCount: requests.length,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, 
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                           itemBuilder: (context, index) {
                                print('hrlooooo');
                                 DocumentSnapshot ds=requests[index];
                                 var request=EmergencyRequest.fromMap(ds);
                                 print("IM HEREEE");
                                 print(request.type);
                                 return GestureDetector(
                                  onTap: (){
                                     showDialog(
                    context: context, 
                    builder: (context)=>AlertDialog(
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delete",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(width:5),
                            IconButton(
                              onPressed: ()=>Navigator.pop(context), 
                              icon: Icon(Icons.clear,color: Colors.deepPurple,)
                              )
                          ],
                        ),
                        content: Container(
                          height:100,
                          width:300,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                 const Text("Are you sure, you want to delete this request?",softWrap: true,),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Flexible(
                                       child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                               backgroundColor: Color(0xffFFDDEE),
                                               textStyle: TextStyle(color:Colors.deepPurple),
                                               minimumSize: Size(120, 40),
                                               shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(12)
                                                      ),
                                               side: BorderSide(color:Colors.deepPurple )
                                               ),
                                          
                                          onPressed: (){
                                            Navigator.pop(context);                                     }, 
                                          child: Text("No")
                                          ),
                                     ),
                                     SizedBox(width:20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                             backgroundColor: Colors.deepPurple,
                                             minimumSize: Size(90, 40),
                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(12)
                                                    ),
                                        ),
                                        onPressed: () async {
                                          await requestsService.deleteRequest(ds.id);
                                          Navigator.pop(context);
                                        }, 
                                        child: Text("Yes", style: TextStyle(color:Color(0xffFFDDEE) ),)
                                        )
                                 ],
                                 )
                          ],
                          )
                          
                        ),
                    )
                    );
                                  },
                                  child: RequestCard(request: request)
                                  ); 
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