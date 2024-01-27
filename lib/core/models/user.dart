import 'package:health_care_app/core/models/medication.dart';

class AppUser {
  late String username;
  late String email;
  bool isDoctor=false;

  AppUser({required this.username, required this.email, required this.isDoctor});

  AppUser.fromMap(map){
    username=map["username"];
    email=map["email"];
    isDoctor=map["isDoctor"];
  }

  toMap(){
    return {
      "username":username,
      "email":email,
      "isDoctor":isDoctor,
    };
  }
}