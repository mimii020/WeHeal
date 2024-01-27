import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/post.dart';
import 'package:health_care_app/core/services/posts_service.dart';
import 'package:health_care_app/core/viewmodels/posts_view_model.dart';
import 'package:health_care_app/ui/widgets/custom_drawer.dart';
import 'package:health_care_app/ui/widgets/like_button.dart';
import 'package:health_care_app/ui/widgets/nav_bar.dart';
import 'package:health_care_app/ui/widgets/post_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _formkey=GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  TextEditingController contentController=TextEditingController();
  PostsService postsService=PostsService();
  User? user=FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //postsVm=context.read<PostsVm>();
    //loadPosts();
    print("THE LENGTH ISSSS");
    //print(postsVm.postsList.length);
  }
    
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          shape:CircleBorder(),
          backgroundColor: Colors.white,
          onPressed: ()=>
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  height:300,
                  width:300,
                  child: Form(
                    key:_formkey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: TextFormField(
                        
                          focusNode: _focusNode,
                          onTap: () {
                            Scrollable.ensureVisible(_focusNode.context!);
                          },
                            keyboardType: TextInputType.name,
                            maxLines:10,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: contentController,
                            textAlign: TextAlign.start,
                            style: const TextStyle( fontSize: 17,),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              hintText:"What's on your mind?" ,
                              hintStyle: const TextStyle( fontSize: 17,color: Colors.grey), 
                              border: UnderlineInputBorder(
                                     borderSide: BorderSide.none,
                          ),
                              suffixIcon: IconButton(
                                onPressed: ()=>contentController.clear(),
                                icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                                )
                              ),
                            validator:(value) {
                              if (value==null||value.isEmpty){
                                return ("pou can't add an empty post");
                              }
                              else{
                                return null;
                              }
                                  
                              
                            },
                                  
                          ),
                        ),
                        Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                contentController.clear();
                                Navigator.pop(context);
                              },
                              child:Text("cancel",style: TextStyle(color:Color(0xff7096D1), fontSize: 17, fontWeight: FontWeight.bold))
                            ),
                            GestureDetector(
                          onTap: () async {
                             if (_formkey.currentState!.validate()==true&&user!=null){
                                  Timestamp timestamp=Timestamp.now();
                                  Post post=Post(content: contentController.text,timestamp: timestamp);
                                  await postsService.addPost(user!.uid, post);
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=> PostsScreen()));
                                  contentController.clear();
                             }
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(color:Color(0xff7096D1), fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )
                          ],

                        )      
                        
                                
                      ]
                      ),
                  ),
                ),
              )
            ),
          
          child:Icon(Icons.add, color: Color(0xffABC3E6))
          ),
        backgroundColor:Color(0xffF5F5F5),
        appBar: NavBar(),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.25,
                decoration:BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Color(0xffABC3E6),
                    Colors.deepPurple
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
                  ),
                ),
                child:Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("You have something on your mind? Write a post!",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(color:Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width:150,
                      height:MediaQuery.of(context).size.height*0.25,
                      child: LottieBuilder.network("https://lottie.host/9cc22db7-b2fb-4ee0-9ec4-405d995544b3/oQMDAfELWt.json")
                      )
                  ],
                )
              ),
              SizedBox(height:20),
              StreamBuilder<Object>(
                stream: postsService.getPosts(),
                builder: (context, AsyncSnapshot snapshot) {
                  var posts;
                  if(snapshot.hasData){
                     posts=snapshot.data.docs;
                    return SizedBox(
                      width:MediaQuery.of(context).size.width-30,
                      child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:posts.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot ds=posts[index];
                        
                        var post=Post.fromMap(ds);
                        return PostCard(post:post,postId: ds.id,);
                      })
                      ),
                    );
                  }
                  else {
                    return CircularProgressIndicator();
                  }
                  
                }
              ),
            ],
          ),
        ),
       
      )
      );
  }
}