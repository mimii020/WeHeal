import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care_app/core/models/emergency_request.dart';

class RequestCard extends StatefulWidget {
  final  EmergencyRequest request;
   
  const RequestCard({super.key, required this.request,});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  Widget typeImage(){
    Color color=Colors.deepPurple;
    if (widget.request.type=="food"){
      return Icon(FontAwesomeIcons.bowlFood, color: color,);
    }
    else if(widget.request.type=="therapist"){
      return Icon(FontAwesomeIcons.userNurse,color: color,);
    }
    else if(widget.request.type=="blood donation"){
      return Icon(FontAwesomeIcons.droplet,color: color,);
    }
    else {
      return Icon(FontAwesomeIcons.shirt,color: color,);
    }
   }
  
 
  @override
  Widget build(BuildContext context) {
    return Container(
                height:160,
                width:202,
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(12)
                ),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          typeImage(),
                          Expanded(child: Center(child: Text(widget.request.type, softWrap:true,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),))),
                        ],
                      ),
                      Text("severity: ${widget.request.severity}/10 \n ${widget.request.number} people ",textAlign: TextAlign.center,softWrap:true,style: TextStyle(color:Colors.black),),
                      Column(
                        children: [
                          Text("${widget.request.volunteersNumber.length} volunteers"),
                          RichText(text: TextSpan(
                             text: "Status: ",
                             style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                             children: [
                              TextSpan(
                                text: widget.request.status,
                                style: TextStyle(color: Colors.black)
                              )
                             ]
                          )
                                    
                          ),
                        ],
                      ),
                      
                      
                      
                      ]
                    ),
                  ),
                )
                 
                
              );
  }
}