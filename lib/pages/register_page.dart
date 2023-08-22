
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_button.dart';
import 'package:giveit_takeit/components/my_textfield.dart';
import 'package:giveit_takeit/components/square_tile.dart';
import 'package:giveit_takeit/services/auth_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}


class _RegisterPage extends State<RegisterPage> {



  File? imageFile;
  String? imageUrl;

  void _showImageDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Please choose an options"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    _getFromCamera();
                    },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(Icons.camera,color:Colors.black),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    _getFromGallery();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(Icons.browse_gallery,color:Colors.black),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                )
              ],

            ),
          );
        }
    );
  }

   void _getFromCamera() async
   {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    // _cropImage(pickedFile!.path);
    Navigator.pop(context);
   }

  void _getFromGallery() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
         imageFile = File(pickedFile!.path);
          });
    //_cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  // void _cropImage(filePath) async {
  //   CroppedFile? croppedImage  = await ImageCropper().cropImage(
  //     sourcePath: filePath, maxHeight:1080, maxWidth: 1080);
  //   if(croppedImage != null){
  //     setState(() {
  //       imageFile = File(croppedImage.path);
  //     });
  //   }
  // }

  final  FirebaseAuth _auth =FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _first_nameController = TextEditingController();
  final _last_nameController= TextEditingController();
  final _ageController = TextEditingController();
  final _birth_soonController = TextEditingController();



  //sign up  user method
  Future signUserUp() async {


    //try to create user

    
      if(imageFile == null) {
        showErrorMessage("Please select an Image");
        return;
      }
      try {
      if (passwordConfirmed()) {
         
        final ref =FirebaseStorage.instance.ref().child('userProfileImages').child(DateTime.now().toString()+'.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'userImage': imageUrl,
          'fname':_first_nameController.text.trim(),
          'lname':_last_nameController.text.trim(),
          'email':_emailController.text.trim(),
          'age':_ageController.text.trim(),
          'birth':_birth_soonController.text.trim(),
          'createAt': Timestamp.now(),
          'bio': 'Write Your Bio Here.',
          'quesCount': 0 ,
          'ansCount' : 0
        });

        //pop the loading circle
        Navigator.canPop(context) ? Navigator.pop(context): null;


      }
    }
      on FirebaseAuthException catch(e){

      //pop the loading circle
      Navigator.pop(context);

      //show error message

      showErrorMessage(e.code);
    }


  }

  bool passwordConfirmed(){
    if(_passwordController.text.trim() == confirmPasswordController.text.trim() ){
      return true;
    }
    else{
      return false;
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



                  const SizedBox(height: 15,),

                  Text('Lets create an account for you!',
                    style: TextStyle(color: Color(0xffEDA47E), fontWeight: FontWeight.w900 ,fontSize:20),
                  ),

                  const SizedBox(height: 15,),

                  GestureDetector(
                    onTap: (){

                      _showImageDialog();

                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          borderRadius: BorderRadius.circular(10),

                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (imageFile == null ? const AssetImage('assets/images/profile.heic') : Image.file(imageFile!).image) ,
                          )
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),
//email
                  MyTextField(controller: _emailController,
                    hintText: 'Username',
                    obscureText: false,),


                  const SizedBox(height: 15,),

                  MyTextField(controller: _first_nameController,
                    hintText: 'First Name',
                    obscureText: false,),

                  const SizedBox(height: 15,),

                  MyTextField(controller: _last_nameController,
                    hintText: 'Last Name',
                    obscureText: false,),

                  const SizedBox(height: 15,),

                  MyTextField(controller: _ageController,
                    hintText: 'Age',
                    obscureText: false,),

                  const SizedBox(height: 15,),


                  MyTextField(controller: _birth_soonController,
                    hintText: 'Birth Year',
                    obscureText: false,),

                  const SizedBox(height: 15,),

                  //password
                  MyTextField(controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,),

                  const SizedBox(height: 5,),

                  //confirm password
                  MyTextField(controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,),


                  // const SizedBox(height: 10,),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         'Forgot Password?',
                  //         style: TextStyle(color: Colors.grey[600]),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 25
                    ,),

                  MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,
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

                  // mot a member

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4,),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text('Log In now', style: TextStyle(color: Color(0xffEDA47E), fontWeight: FontWeight.bold),)),
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
