//auth, signup and login

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/core/models/user.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  User? user=FirebaseAuth.instance.currentUser;

  getCurrentUser() async {
   var userDoc= firestore.collection('users').doc(user!.uid);
   String username=await userDoc.get().then((snapshot) => snapshot.data()!['username']);
   return username;
  }  
  getAllUsers(){
      return firestore.collection('users').snapshots();
                                                    
  }
  createUser(email,password) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    } on FirebaseAuthException catch(e){
      print(e);
    }
   }
  
    signOut()async  {
      await FirebaseAuth.instance.signOut();
      
  }
   addUserDetails(AppUser appUser) async {
    User? user= FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(appUser.toMap());
    var prefs=await SharedPreferences.getInstance();
    prefs.setString('username', appUser.username);
          

   }

   loadUsername() async {
    var prefs=await SharedPreferences.getInstance();
    return prefs.getString('username');

   }

   getDoctorsByCategory(String categoryName){
     firestore.collection('users')
              .where('isDoctor.true',isEqualTo:categoryName )
              .snapshots();
   }
}