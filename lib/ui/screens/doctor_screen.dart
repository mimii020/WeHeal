import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/user.dart';
import 'package:health_care_app/core/services/user_service.dart';

class DoctorScreen extends StatelessWidget {
  final String categoryName;
  const DoctorScreen({super.key, required this.categoryName,});

  @override
  Widget build(BuildContext context) {
    UserService userService=UserService();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          ),
        title: Text(categoryName),
      ),
      body: StreamBuilder(
        stream:userService.getDoctorsByCategory(categoryName),
        builder:(context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
          var doctors=snapshot.data.docs;
        return ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context,index){
            DocumentSnapshot ds=doctors[index];
           var doctor=AppUser.fromMap(ds);
            return Card(
              child: ListTile(
                title:Text(doctor.username) ,
              ),
            );
          }
          );}
          else{
            return Center(child:CircularProgressIndicator());
          }
        }
      ),

    );
  }
}