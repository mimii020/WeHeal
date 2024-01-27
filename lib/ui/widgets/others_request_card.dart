import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/emergency_request.dart';
import 'package:health_care_app/core/services/emergency_request_service.dart';
import 'package:health_care_app/ui/widgets/request_card.dart';

class OthersRequestCard extends StatefulWidget {
  final EmergencyRequest request;
  final String requestId;

  const OthersRequestCard({super.key, required this.request, required this.requestId});

  @override
  State<OthersRequestCard> createState() => _OthersRequestCardState();
}

class _OthersRequestCardState extends State<OthersRequestCard> {
  late bool isVolunteer;
  late User? user=FirebaseAuth.instance.currentUser;
  late String message;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVolunteer=widget.request.volunteersNumber.contains(user!.uid);
    message=(widget.request.volunteersNumber.contains(user!.uid))? "Served":"Volunteer";
  }

  @override
  Widget build(BuildContext context) {
    RequestsService requestsService=RequestsService();
    
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffF5F5F5),

      ),
      height:240,
      width: 300,
      child: Column(
        children: [
          RequestCard(request: widget.request,),
          Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context)=>AlertDialog(
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Volunteer Now!",style: TextStyle(fontWeight: FontWeight.bold),),
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
                                 const Text("Are you sure, you want to volunteer?",softWrap: true,),
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
                                            setState(() {
                                            isVolunteer=false;
                                              
                                            });
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
                                        onPressed: (){
                                          setState(() {
                                          isVolunteer=true;
                                          requestsService.volunteer(widget.requestId,isVolunteer);
                                          });
                                          print("IM volunteeer");
                                          setState(() {
                                            message="Served";
                                          });
                                          print(message);
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
                child: Text(message,style: TextStyle(fontSize: 18),)
                       ),
            ],
          )
        ],
      ),
    );
  }
}