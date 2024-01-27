
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/medication.dart';
import 'package:health_care_app/core/services/medication_service.dart';
import 'package:health_care_app/core/viewmodels/medication_view_model.dart';
import 'package:health_care_app/ui/widgets/custom_drawer.dart';
import 'package:health_care_app/ui/widgets/medication_card.dart';
import 'package:health_care_app/ui/widgets/popup.dart';
import 'package:health_care_app/ui/widgets/nav_bar.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class MedicationScheduler extends StatefulWidget {
  const MedicationScheduler({super.key});

  @override
  State<MedicationScheduler> createState() => _MedicationSchedulerState();
}

class _MedicationSchedulerState extends State<MedicationScheduler> {
  late final MedicationVm medicationVm;
  User? user=FirebaseAuth.instance.currentUser;
  List<Medication> medicationList=[];
  MedicationService medicationService=MedicationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    medicationVm=context.read<MedicationVm>();
    //loadMedications();
    medicationList=medicationVm.medicationList;
    print(medicationList.length);
  }

  
  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        appBar: NavBar(),
        floatingActionButton: FloatingActionButton(
          shape:CircleBorder(),
          backgroundColor: Color(0xff122965),
          onPressed: ()=>showDialog(context: context,builder: (context) => FormAlertDialog(medicationVm:medicationVm,),),
          child:Icon(Icons.add, color: Colors.white,)
          ),
        body:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
          
            children:
             [
            ClipPath(
              clipper: WaveClipperOne(flip:false,reverse:false), // Replace with your desired clipper
              child: Container(
              height: MediaQuery.of(context).size.height*0.15,
              color: Color(0xffABC3E6)
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child:AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Your medication Schedule',
                    textStyle: TextStyle(
                      color:Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
              
              ],
              )
              ),
            
              
           
            StreamBuilder<Object>(
              stream: medicationService.getMedications(user!.uid),
              builder: (context, AsyncSnapshot snapshot) {
                var meds;
                if(snapshot.hasData){
                  meds=snapshot.data.docs;                    
                  return SizedBox(
                    height:MediaQuery.of(context).size.height,
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: meds.length,
                    itemBuilder:(context, index) {
                      DocumentSnapshot ds=meds[index];
                      var med=Medication.fromMap(ds);
                      return MedicationCard(
                        dosage: med.dosage, 
                        frequency: med.frequency, 
                        image: med.type, 
                        medicationName: med.medicationName,
                        notification: med.notification,
                        );
                      
                    },
                    
                    ),
                  );
                }
                else{
                  return CircularProgressIndicator();
                }
                
              }
            ),
          
          ],
          ),
        )
         
      ),
    );
  }
}