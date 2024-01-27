

import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/post.dart';
import 'package:health_care_app/core/services/posts_service.dart';

class PostsVm extends ChangeNotifier{
  List<Post> postsList=[];
  PostsService postsService=PostsService();

  fetchPosts()  {
     postsService.getPosts();
      //postsList= await postsService.getPosts();
   // }
    
  //  notifyListeners();
  }

  addPost(String userId, Post post) async {
    await  postsService.addPost(userId, post);
      postsList.add(post);
      notifyListeners();
  }
}