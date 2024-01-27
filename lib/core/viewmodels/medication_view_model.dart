import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/medication.dart';
import 'package:health_care_app/core/services/medication_service.dart';

class MedicationVm extends ChangeNotifier{
    List<Medication> medicationList=[]; 
    MedicationService medicationService=MedicationService();
    

  //load medication list
    fetchMedications(userId) {
       medicationService.getMedications(userId);
      notifyListeners();
    }
  //add medication 
    addMedication(String userId, Medication medication) async {
      
      await medicationService.addMedication(userId, medication);
      medicationList.add(medication);
      notifyListeners();
    }
  //delete medication
    deleteMedication(medicationId) async {
      await medicationService.deleteMedication(medicationId);
      medicationList.removeWhere(((element) => element.medicationId==medicationId));
      notifyListeners();
    }
 
 //update medication
  updateMedication(Medication medication,data) async {
    await medicationService.updateMedication(medication.medicationId,data);
    notifyListeners();
  }
}