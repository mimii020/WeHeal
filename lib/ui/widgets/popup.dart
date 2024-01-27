import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/medication.dart';
import 'package:health_care_app/core/services/medication_service.dart';
import 'package:health_care_app/core/viewmodels/medication_view_model.dart';

class FormAlertDialog extends StatefulWidget {
    final MedicationVm medicationVm;
    const FormAlertDialog({super.key, required this.medicationVm});


  @override
  State<FormAlertDialog> createState() => _FormAlertDialogState();
}

class _FormAlertDialogState extends State<FormAlertDialog> {
    final _formkey=GlobalKey<FormState>();
    final FocusNode _focusNode = FocusNode();
    TextEditingController medNameController=TextEditingController();
    TextEditingController dosageController=TextEditingController();
    TextEditingController frequencyController=TextEditingController();
    late String notification;

    User? user=FirebaseAuth.instance.currentUser;
    List<String> dosageTypes=["pills", "injections","tablespoon","teaspoon"];
    String dosageType="pills";
    String groupVal="pills";
    TimeOfDay? pickedTime;
    MedicationService medicationService=MedicationService();

    
  
  pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      );
  }

  @override
  Widget build(BuildContext context) {


    return AlertDialog(
       alignment: Alignment.center,
       backgroundColor: Colors.white,
       content:SizedBox(
         height:340,
         width:400,
         child: Form(
                  key:_formkey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     SizedBox(height:25)
             ,       SizedBox(
                      width:273,
                      height:38,
                      child: TextFormField(
                      focusNode: _focusNode,
                      onTap: () {
                        Scrollable.ensureVisible(_focusNode.context!);
                      },
                        keyboardType: TextInputType.name,
                        controller: medNameController,
                        textAlign: TextAlign.start,
                        style: const TextStyle( fontSize: 17,),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          hintText:"Name" ,
                          hintStyle: const TextStyle( fontSize: 17,color: Colors.grey), 
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color:Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color(0xffABC3E6))),
                          suffixIcon: IconButton(
                            onPressed: ()=>medNameController.clear(),
                            icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                            )
                          ),
                        validator:(value) {
                          if (value==null||value.isEmpty){
                            return ("please, enter a non empty name");
                          }
                          else{
                            return null;
                          }
                              
                          
                        },
                              
                      ),
                    ),
                    const SizedBox(
                      height:25,
                    ),
                    SizedBox(
                      width:273,
                      height:38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          SizedBox(
                            width:100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: dosageController,
                              textAlign: TextAlign.start,
                              style: const TextStyle( fontSize: 17,),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                hintText:"Dosage" ,
                                hintStyle: const TextStyle( fontSize: 17,color: Colors.grey), 
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color(0xffABC3E6))),
                                suffixIcon: IconButton(
                                  onPressed: ()=>dosageController.clear(),
                                  icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                                  )
                                ),
                              validator:(value) {
                                if (value==null||value.isEmpty){
                                  return ("please, enter a valid dosage");
                                }
                                else{
                                  return null;
                                }
                                    
                                
                              },
                                    
                            ),
                          ),
                          DropdownButton(
                            value: groupVal,
                            items: dosageTypes.map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                               )
                                 ).toList(), 
                            onChanged: (String? value){
                              setState((){
                                if(value!=null){
                                  groupVal=value;
                                  dosageType=value;
                                }
                                    
                               }
                              );
                            }
                              
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height:25,
                    ),
                    SizedBox(
                      width:273,
                      height:38,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: frequencyController,
                        textAlign: TextAlign.start,
                        style: const TextStyle( fontSize: 17,),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          hintText:"Frequency" ,
                          hintStyle: const TextStyle( fontSize: 17,color: Colors.grey,), 
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color:Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color(0xffABC3E6))),
                          suffixIcon: IconButton(
                            onPressed: ()=>frequencyController.clear(),
                            icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF)),
                            )
                          ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator:(value) {
                          if (value==null||value.isEmpty){
                            return ("please, enter a valid frequency");
                          }
                          else{
                            return null;
                          }
                              
                          
                        },
                              
                      ),
                    ),

                SizedBox(height:10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Notifications"),
                    SizedBox(width:5),
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        minimumSize: const Size(30, 30),
                        backgroundColor: Color(0xffABC3E6),
                        shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),              
                        ),
                      onPressed: () async {
                          TimeOfDay? pickedTime=await pickTime(context);  

                          if(pickedTime!=null){
                            setState(() {
                              notification="${pickedTime.hour}:${pickedTime.minute}";;
                            });
                          }              
                            
                          
                      }, 
                      child: Text("Pick Time", style: TextStyle(color:Colors.black),),
                      ),
                    
                   
                  ]
                  ),

               
                    
                const SizedBox(
                      height:20,
                    ),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width:20),
                    GestureDetector(
                      onTap: () {
                        medNameController.clear();
                        dosageController.clear();
                        frequencyController.clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Discard",
                        textAlign:TextAlign.right, 
                        style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),
                        )
                      ),
                    SizedBox(width:50),
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        minimumSize: const Size(70, 38),
                        backgroundColor: Color(0xffABC3E6),
                        shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),              
                        ),
                      onPressed: (){
                        late String type;
                        if(_formkey.currentState!.validate()==true){
                          if(dosageType=="injections"){
                            type="https://openclipart.org/image/400px/314531";
                          }
                          else if(dosageType=="pills"){
                              type="https://cdn-icons-png.freepik.com/256/5224/5224935.png?ga=GA1.2.1122023173.1705934706&semt=ais";
                          }
                          else if(dosageType=="tablespoon"||dosageType=="teaspoon"){
                            type="https://openclipart.org/image/400px/189503";
                          }

                            
                          
                          String dosage="${dosageController.text.trim()} $dosageType";
                          Medication medication=Medication(
                          medicationName: medNameController.text.trim(),
                          dosage:dosage ,
                          frequency: frequencyController.text.trim(),
                          notification: notification,
                          type:type,
                          );
                          
                          
                        if(user!=null){
                            medicationService.addMedication(user!.uid, medication);

                         }
                        Navigator.pop(context);

                        }
                      
                        
                        
                      },
                      child: const Text(
                        "Add", 
                        style: TextStyle(fontSize: 17, color: Colors.black)
                        ), 
                    ),

                  ],
                ),
                
              
                
              
                
               ]
              ),
            ),
       ),
    );
  }
}