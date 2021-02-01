import 'package:flutter/material.dart';
import 'package:yog_arogyam/adminpage.dart';
import 'package:yog_arogyam/consultation.dart';
import 'package:yog_arogyam/homepage.dart';
import 'package:yog_arogyam/login.dart';
import 'package:yog_arogyam/profile.dart';
import 'package:yog_arogyam/reports.dart';
import 'package:yog_arogyam/editProfile.dart';
import 'package:yog_arogyam/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yog Arogyam',
      initialRoute: 'SignIn',
      routes: {
        'SignIn': (context) => SignInScreen(),
        'HomePage': (context) => HomePageScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Profile': (context) => ProfileScreen(),
        'ProfileEdit': (context) => Editor(),
        'Consultation': (context) => BookConsultation(),
        'Reports': (content) => MedicalReports(),
        'AdminPage': (content) => Adminpage()
      },
    );
  }
}
