import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/pages/auth_page.dart';
import 'package:giveit_takeit/pages/log_or_register_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the login screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.gif'), // Use your GIF asset path
      ),
    );
  }
}