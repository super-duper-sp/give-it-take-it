import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_button.dart';
import 'package:giveit_takeit/components/my_textfield.dart';
import 'package:giveit_takeit/components/square_tile.dart';
import 'package:giveit_takeit/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in user method
  void signUserIn() async {

        //show loading  circle

    showDialog (
            context: context ,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
    );


        //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

      //pop the loading circle
      Navigator.pop(context);

    }
    on FirebaseAuthException catch(e){

      //pop the loading circle
      Navigator.pop(context);

      //show error message

      showErrorMessage(e.code);
    }

  }

  //error message to user 
  showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context){
          return AlertDialog(
            backgroundColor: Colors.blue,
            title:Center(
              child:  Text(
                 message ,
                 style: const TextStyle(color: Colors.white),
               ),
            ),
           );
                         },
    );
  }

// ''''
//   //wrong email message popup
//   void wrongEmailMessage(){
//     showDialog(context: context, builder: (context){
//       return const AlertDialog(
//         title: Text('Incorrect Email'),
//       );
//     },
//     );
//
//   }
//
//
//   //wrong password message popup
//   void wrongPasswordMessage() {
//     showDialog(context: context, builder: (context) {
//       return const AlertDialog(
//         title: Text('Incorrect Password'),
//       );
//     },
//     );
//   }
// '''

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 25,),
                Icon(Icons.lock,
                size: 100,),
                const SizedBox(height: 10,),
                Text('welcome',style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),),

                const SizedBox(height: 25,),

                MyTextField(controller: emailController,
                hintText: 'Username',
                obscureText: false,),

                const SizedBox(height: 25,),

                MyTextField(controller: passwordController,
                hintText: 'Password',
                obscureText: true,),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10,),

                MyButton(
                  text: 'Sign Up',
                  onTap: signUserIn,
                ),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row( children: [

                    Expanded(
                      child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),

                    Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),

                  ],

                  ),
                ),

                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'assets/images/google.png' ,
                    ),
                  ]
                ),

                const SizedBox(height:10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                        child: Text('Register now', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                  ],
                )
              ],

            ),
          ),
        ),
      )
    );

  }
}
