import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/core/models/emergency_request.dart';

class RequestsService{
    final FirebaseFirestore firestore=FirebaseFirestore.instance;
    final User? user=FirebaseAuth.instance.currentUser;

    getRequests(userId){
      DocumentReference userDoc=firestore.collection("users").doc(userId); 
      return firestore.collection('requests')
                            .where('userRef',isNotEqualTo: userDoc)
                            .snapshots();
    }

    getUserRequests(userId){
       return firestore.collection('requests')
                      .where('userRef', isEqualTo: firestore.collection('users').doc(userId))
                      .snapshots();

    }

    addRequests(String userId,EmergencyRequest request) async{
      var userDoc= firestore.collection('users').doc(userId);
      request.userRef=userDoc;
      print("done with the usereeeef");
      print(userDoc);
      var username=await userDoc.get().then((snapshot) => snapshot.data()!['username']);
      request.username=username;
      var requestDoc=await firestore.collection('requests').add(request.toMap());
      print("addeeeed");
      //await firestore.collection('requests').doc(requestDoc.id).update({"requestId":requestDoc.id});
      
    }

    volunteer(String requestId,bool isVolunteer) async {
      DocumentReference requestRef=await firestore.collection('requests').doc(requestId);
     await firestore.collection('requests').doc(requestId).update({"status":"served"});
      isVolunteer? 
        await  requestRef.update({'volunteersNumber':FieldValue.arrayUnion([user!.uid])})
          :await requestRef.update({'volunteersNulber':FieldValue.arrayRemove([user!.uid])});

    }

    deleteRequest(String requestId) async {
      await firestore.collection('requests').doc(requestId).delete();
    }

}