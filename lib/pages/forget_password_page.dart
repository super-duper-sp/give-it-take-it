import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage ({super.key});

  @override
  State<ForgotPasswordPage > createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage > {

  final _emailController = TextEditingController();

  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.blue,
            title:Center(
              child:  Text(
               'Password reset link send! Check your email.' ,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );


    }
    on FirebaseAuthException catch(e){
      print(e);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.blue,
            title:Center(
              child:  Text(
                e.message.toString() ,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,color: Color(0xffEDA47E),fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 10,),


          MyTextField(controller: _emailController,
            hintText: 'Email',
            obscureText: false,),

          SizedBox(height: 10,),

          MaterialButton(onPressed: passwordReset,
          child: Text('Reset Password', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            color: Colors.orangeAccent,
          )


        ],
      ),
    );
  }
}
