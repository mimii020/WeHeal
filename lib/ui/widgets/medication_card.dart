import 'package:flutter/material.dart';

class MedicationCard extends StatefulWidget {
  final String medicationName;
  final String dosage;
  final String frequency;
  final String image;
  final String notification;
  const MedicationCard({super.key, required this.dosage, required this.frequency, required this.image, required this.medicationName, required this.notification});

  @override
  State<MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
           padding: const EdgeInsets.all(15.0),
           child: SizedBox(
             height:MediaQuery.of(context).size.height-500,
             width:MediaQuery.of(context).size.width,
             child: Row(
               children: [
                 Container(
                  padding: EdgeInsets.all(15),
                  height:MediaQuery.of(context).size.height-500,
                  width:MediaQuery.of(context).size.width-150,
                  decoration: BoxDecoration(
                        color:Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(12)
                   ),
                   child:Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(widget.medicationName,softWrap: true,textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(widget.dosage,softWrap: true,),
                        ],
                        ),
                      ),
                      SizedBox(height:50),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:30),
                          Checkbox(
                            value: isChecked, 
                            onChanged: (value){
                              setState(() {
                                if(value!=null){
                                  isChecked=value;
                                }
                              });
                            },
                            ),
                            Text(widget.notification),
                      ],)
                   ],)
                  ),
                  SizedBox(width:10),
                  SizedBox(
                    height:MediaQuery.of(context).size.height-500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height:MediaQuery.of(context).size.height-630,
                          width:MediaQuery.of(context).size.width-250,
                          decoration: BoxDecoration(
                          color:Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(12)
                         ),
                          child: Image.network(widget.image,fit: BoxFit.fill,),
                        ),
                       
                        Container(
                          height:MediaQuery.of(context).size.height-630,
                          width:MediaQuery.of(context).size.width-250,
                          decoration: BoxDecoration(
                          color:Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(12)
                         ),
                          child: Center(child: Text("frequency: ${widget.frequency}",textAlign: TextAlign.center,softWrap: true,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                        )
                    
                      ],
                    ),
                  )
               ],
             ),
           ),
         );
  }
}