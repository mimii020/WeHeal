import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/models/user.dart';
import 'package:health_care_app/core/services/user_service.dart';

class SignUp extends StatefulWidget {
  final GestureTapCallback? onClickedLogin;
  const SignUp({super.key, required this.onClickedLogin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey=GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final UserService userService=UserService();
  bool isChecked=false;
  
  TextEditingController usernameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  

  
  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color(0xFFD0E3FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height:600,
              width:MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(30)),
                     ),
              child: Form(
                key:_formkey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height:100,
                    child: Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold, ))
                  ),
                ),
                SizedBox(
                  width:273,
                  height:70,
                  child: TextFormField(
                  focusNode: _focusNode,
                  onTap: () {
                    Scrollable.ensureVisible(_focusNode.context!);
                  },
                    keyboardType: TextInputType.name,
                    controller: usernameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle( fontSize: 17,),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText:"please, enter your username" ,
                      hintStyle: const TextStyle( fontSize: 17,color: Color( 0xFF333333)), 
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(30), borderSide: const BorderSide(color:Color(0xff7E6BEF))),
                      suffixIcon: IconButton(
                        onPressed: ()=>usernameController.clear(),
                        icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                        )
                      ),
                    validator:(value) {
                      if (value==null||value.isEmpty){
                        return ("please, enter a non empty username");
                      }
                      else{
                        return null;
                      }
                          
                      
                    },
                          
                  ),
                ),
                const SizedBox(
                  height:1,
                ),
                SizedBox(
                  width:273,
                  //height:38,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    textAlign: TextAlign.center,
                    style: const TextStyle( fontSize: 17,),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText:"please, enter your email" ,
                      hintStyle: const TextStyle( fontSize: 17,color: Color(0xff333333)), 
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(30), borderSide: const BorderSide(color:Color(0xff7E6BEF))),
                      suffixIcon: IconButton(
                        onPressed: ()=>emailController.clear(),
                        icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                        )
                      ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    
                    validator:(value) {
                      if (EmailValidator.validate(value!)!=true){
                        return ("please, enter a valid email address");
                      }
                      else{
                        return null;
                      }
                          
                      
                    },
                          
                  ),
                ),
                const SizedBox(
                  height:10,
                ),
                SizedBox(
                  width:273,
                  
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    style: const TextStyle( fontSize: 17,),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText:"please, enter your password" ,
                      hintStyle: const TextStyle( fontSize: 17,color: Color(0xff333333)), 
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(30), borderSide: const BorderSide(color:Color(0xff7E6BEF))),
                      suffixIcon: IconButton(
                        onPressed: ()=>passwordController.clear(),
                        icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF)),
                        )
                      ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:(value) {
                      if (value==null||value.isEmpty||value.length<6){
                        return ("please, enter a valid password");
                      }
                      else{
                        return null;
                      }
                          
                      
                    },
                          
                  ),
                ),
                
            const SizedBox(
                  height:10,
                ),

              Row(
              children: [
                SizedBox(width:40),
                const Text("Are you A doctor?", style: TextStyle(fontSize: 18),),
                Checkbox(
                  value: isChecked, 
                  onChanged: (value){
                      setState(() {
                        if(value!=null){
                              isChecked=value;
                        }
                        
                      });
                  },
                  )
              ],
            ),

           
              SizedBox(height: 20,),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: const Size(187, 38),
                backgroundColor: const Color(0xFFABC3E6),
                 shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),              
                ),
              onPressed: () async {
                String username=(isChecked==true)? "Dr.${usernameController.text.trim()}": usernameController.text.trim();
                AppUser appUser=AppUser(username:username, email:emailController.text,isDoctor:isChecked);
                await userService.createUser(emailController.text.trim(), passwordController.text.trim());
                print(appUser.isDoctor);
                await userService.addUserDetails(appUser);
              },
              child: const Text(
                "Sign Up", 
                style: TextStyle(fontSize: 17, color: Colors.black)
                ), 
            ),
            
            const SizedBox(
              height:20,
            ),
            
            RichText(
              text: TextSpan(
                text:"You already have an account? ",
                style: TextStyle(fontSize: 17,color: Colors.black),
                children: [
                  TextSpan(
                    text: "Login",
                    style: TextStyle(color:Color(0xFFABC3E6), decoration: TextDecoration.underline ),
                    recognizer: TapGestureRecognizer()
                      ..onTap=widget.onClickedLogin,
                    )
                ]
                ),
            )
              ]
              ),
              ),
            ),
          )
        ],)
      

    );
  }
}