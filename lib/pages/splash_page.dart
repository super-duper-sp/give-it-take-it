import 'dart:async';


import 'package:flutter/material.dart';

import 'package:giveit_takeit/pages/log_or_register_page.dart';


class SplashPage extends StatefulWidget
{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animator();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOrRegisterPage(),));
    });
  }
  double width=0;
  double height=0;
  void animator()
  {
    setState(() {
      width=250;
      height=250;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          height: height,
          width: width,
          child: Image( image: AssetImage('assets/images/ok.png'),

          ),
        ),
      ),
    );
  }
}