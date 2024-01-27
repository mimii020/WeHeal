import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/viewmodels/medication_view_model.dart';
import 'package:health_care_app/core/viewmodels/posts_view_model.dart';
import 'package:health_care_app/ui/screens/auth_screen.dart';
import 'package:health_care_app/ui/screens/chat_screen.dart';
import 'package:health_care_app/ui/screens/connect_with_others_screen.dart';
import 'package:health_care_app/ui/screens/emergency_screen.dart';
import 'package:health_care_app/ui/screens/first_aid_screen.dart';
import 'package:health_care_app/ui/screens/first_screen.dart';
import 'package:health_care_app/ui/screens/login.dart';
import 'package:health_care_app/ui/screens/medication_scheduler.dart';
import 'package:health_care_app/ui/screens/phone_screen.dart';
import 'package:health_care_app/ui/screens/posts_screen.dart';
import 'package:health_care_app/ui/screens/request_screen.dart';
import 'package:health_care_app/ui/screens/signup.dart';
import 'package:health_care_app/ui/screens/solash_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:"AIzaSyDLXyqpF9iRB2QibbsYFKrRu20Pee9bmU0",
      appId:"com.example.health_care_app",
      messagingSenderId:"374724735621",
      projectId:"health-care-app-16ba8"
      )
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MedicationVm>(create: (_)=>MedicationVm()),
        ChangeNotifierProvider<PostsVm>(create: (_)=>PostsVm()),


        ],
      
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        routes: {
          '/medication_scheduler':(context)=>MedicationScheduler(),
          '/posts_screen':(context)=>PostsScreen(),
          '/connect_with_others':(context) => ConnectWithOthers(),
          '/emergency_screen':(context)=>EmergencyScreen(),
          '/first_aid':(context)=>FirstAid(),
          '/first_screen':(context) => FirstScreen(),
          'medication_scheduler':(context) => MedicationScheduler(),
          '/phone_screen':(context)=>PhoneScreen(),
          'request_screen':(context)=>RequestScreen()

        },
      ),
    );
  }
}

