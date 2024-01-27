import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/medication.dart';

class MedicationService {
    final FirebaseFirestore firestore=FirebaseFirestore.instance;

     getMedications(userId){
      return firestore.collection('medications')
                      .where('userRef', isEqualTo: firestore.collection('users').doc(userId))
                      .snapshots();
                      //.map((e) => e.docs.map((doc)=> Medication.fromMap(doc.data()))).toList();
    }

    deleteMedication(medicationId){
      firestore.collection('medications')
              .doc(medicationId)
              .delete();
    }

    updateMedication(medicationId,Map<Object,Object?> data){
      firestore.collection('medication')
                .doc(medicationId)
                .update(data);
    }

    addMedication(String userId, Medication medication) async {
      var userDoc= firestore.collection('users').doc(userId);
      medication.userRef=userDoc;
      var medicationRef=await firestore.collection('medications').add(medication.toMap());
      medication.medicationId=medicationRef.id;
    }

}