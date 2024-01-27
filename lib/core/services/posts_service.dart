

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/core/models/post.dart';

class PostsService {
    final FirebaseFirestore firestore=FirebaseFirestore.instance;
    final User? user=FirebaseAuth.instance.currentUser;

  
    
    getPosts() {
        var collectionRef=firestore.collection('posts')
                                   .orderBy('timestamp',descending: true)
                                   .snapshots();
        return collectionRef;
       /* print('IM HEREEE ${collectionRef}');*/
        
    }

    addPost(String userId,Post post) async {
      var userDoc= firestore.collection('users').doc(userId);
      post.userRef=userDoc;
      var username=await userDoc.get().then((snapshot) => snapshot.data()!['username']);
      post.username=username;
      await firestore.collection('posts').add(post.toMap());
      
    }

    handlePostLike(String postId,bool isLiked) async {
        DocumentReference postRef=await firestore.collection('posts').doc(postId);
        isLiked? 
        await  postRef.update({'likes':FieldValue.arrayUnion([user!.uid])})
          :await postRef.update({'likes':FieldValue.arrayRemove([user!.uid])});

    }

}