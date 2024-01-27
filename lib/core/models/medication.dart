import 'package:cloud_firestore/cloud_firestore.dart';

class Medication{
  late String medicationId;
  late String medicationName;
  //late String startDate;
 // late String endDate;
  late String dosage;
  late String frequency;
  late String notification;
  late String type; //image
  late DocumentReference userRef;

  Medication({required this.dosage,/* required this.endDate,*/ required this.frequency, required this.medicationName, required this.type /*required this.type*/, required this.notification/* required this.startDate}*/});

  Medication.fromMap(map){
    dosage=map["dosage"];
    medicationName=map["medicationName"];
    //startDate=map["startDate"];
    //endDate=map["endDate"];
    frequency=map["frequency"];
    userRef=map["userRef"];
    type=map["type"];
    notification=map["notification"];

  }

  toMap(){
    return{
      "medicationName":medicationName,
      //"startDate":startDate,
      //"endDate":endDate,
      "dosage":dosage,
      "frequency":frequency,
      "userRef":userRef,
      "type":type,
      "notification":notification,
      
    };
  }
}