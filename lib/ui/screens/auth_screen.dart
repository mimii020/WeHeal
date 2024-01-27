import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/login.dart';
import 'package:health_care_app/ui/screens/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin=true;
  void toggle()=>setState(() {
    isLogin=!isLogin;
  });
  @override
  Widget build(BuildContext context)=>isLogin? Login(onClickedSignUp: toggle): SignUp(onClickedLogin:toggle);
}