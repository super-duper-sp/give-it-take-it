import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_button.dart';
import 'package:giveit_takeit/components/my_textfield.dart';
import 'package:giveit_takeit/components/square_tile.dart';
import 'package:giveit_takeit/services/auth_service.dart';

import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _first_nameController = TextEditingController();
  // final _last_nameController= TextEditingController();
  // final _ageController = TextEditingController();
  // final _birth_soonController = TextEditingController();

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
          email: _emailController.text,
          password: _passwordController.text);

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
      backgroundColor: Color(0xffFCEFE3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 10,),

                Container(
                  height: 190,
                  width: 230,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/logo.png'),
                      fit: BoxFit.fill,
                    ),

                  ),
                ),
                const SizedBox(height: 20,),

                Text('Give it-Take it',style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,fontWeight: FontWeight.bold,
                ),),

                const SizedBox(height: 25,),

                MyTextField(controller: _emailController,
                hintText: 'Username',
                obscureText: false,),

                const SizedBox(height: 25,),

                MyTextField(controller: _passwordController,
                hintText: 'Password',
                obscureText: true,),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){

                            return ForgotPasswordPage();
                          },
                          ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xffEDA47E),fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10,),

                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),

                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row( children: [

                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                    )),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Color(0xffEDA47E), fontWeight: FontWeight.bold),
                      ),
                    ),

                    Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
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
                    Text('Not a member?', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                        child: Text('Register now', style: TextStyle(color: Color(0xffEDA47E), fontWeight: FontWeight.bold),)),
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
