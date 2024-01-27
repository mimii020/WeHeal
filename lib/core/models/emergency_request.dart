import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmergencyRequest{
  late String type;
  late String severity;
  late String number;
  late DocumentReference userRef;
  List<dynamic> volunteersNumber=[];
  String username="";
  String status="waiting";

  EmergencyRequest({required this.type,required this.number, required this.severity});

  EmergencyRequest.fromMap(map){
    type=map["type"];
    severity=map["severity"];
    number=map["number"];
    status=map["status"];
    username=map["username"];
    userRef=map["userRef"];
    volunteersNumber=map["volunteersNumber"];
    
  }

  toMap(){
    return {
      "type":type,
      "number":number,
      "severity":severity,
      "status":status,
      "username":username,
      "userRef":userRef,
     "volunteersNumber":volunteersNumber,

    };
  }

}