import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:giveit_takeit/pages/home_page.dart';
import 'package:giveit_takeit/pages/splash_page.dart';
import 'package:giveit_takeit/pages/user_profile.dart';

import 'log_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){

              //user logged in
              if(snapshot.hasData){
                return HomePage();
              }
              // user is NOT logged in
              else{
               return LoginOrRegisterPage();
               // return SplashPage();
              }
         },
      )
    );
  }
}
