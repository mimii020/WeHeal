import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  final GestureTapCallback? onClickedSignUp;

  const Login({super.key, required this.onClickedSignUp});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final _formkey=GlobalKey<FormState>();
    TextEditingController passwordController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    Future login() async {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email:emailController.text,
        password: passwordController.text
      );
}
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
              height:502,
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
                    height:155,
                    child: Text("Log In",style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold, ))
                  ),
                ),
                
                
                const SizedBox(
                  height:25,
                ),
                SizedBox(
                  width:273,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    textAlign: TextAlign.center,
                    style: const TextStyle( fontSize: 17,),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText:"please, enter your email" ,
                      hintStyle: const TextStyle( fontSize: 17,color: Color(0xff333333)), 
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(30), borderSide: const BorderSide(color:Color(0xff7E6BEF))),
                      suffixIcon: IconButton(
                        onPressed: ()=>emailController.clear(),
                        icon: const Icon(Icons.clear, color: Color(0xFFD0E3FF),),
                        )
                      ),
                    validator:(value) {
                      if (value==null||value.isEmpty||!EmailValidator.validate(value)){
                        return ("please, enter a valid email address");
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
                  height:30,
                ),
              
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: const Size(187, 38),
                backgroundColor: const Color(0xFFABC3E6),
                 shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),              
                ),
              onPressed: login,
              child: const Text(
                "Log In", 
                style: TextStyle(fontSize: 17, color: Colors.black)
                ), 
            ),
            
            const SizedBox(
              height:30,
            ),
            
            RichText(
              text: TextSpan(
                text:"You don't have an account? ",
                style: TextStyle(fontSize: 17,color: Colors.black),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(color:Color(0xFFABC3E6), decoration: TextDecoration.underline ),
                    recognizer: TapGestureRecognizer()
                      ..onTap=widget.onClickedSignUp,
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

