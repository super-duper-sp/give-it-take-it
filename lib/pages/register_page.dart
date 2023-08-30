
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
            title: Text("Please choose an options",style: TextStyle(color: Color(0xff242424),fontWeight: FontWeight.bold,fontSize:20),),
            backgroundColor: Color(0xfff8e9c8),
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
                        Text("Camera",),
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
          backgroundColor: Color(0xffdeecec),
          title:Center(
            child:  Text(
              message ,
              style: const TextStyle(color: Color(0xff242424)),
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    confirmPasswordController.dispose();
    _first_nameController.dispose();
    _last_nameController.dispose();
    _ageController.dispose();
    _birth_soonController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [



                  const SizedBox(height: 25,),

                  Text('Lets create an account for you!',
                    style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w900 ,fontSize:20),
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
                              color: Color(0xfff8e9c8)),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.yellow.withOpacity(0.1),
                                offset: Offset(0, 30))
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

                 SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _ageController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade100)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.cyan.shade200)),
                                  fillColor: Color(0xffdeecec),
                                  filled: true,
                                  hintText: "Age",
                                  hintStyle: TextStyle(
                                      color: Color(0xff242424),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0), // Adding space between the text fields
                            Expanded(
                              child: TextField(
                                controller: _birth_soonController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade100)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.cyan.shade200)),
                                  fillColor: Color(0xffdeecec),
                                  filled: true,
                                  hintText: "Birth",
                                  hintStyle: TextStyle(
                                      color: Color(0xff242424),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  // MyTextField(controller: _ageController,
                  //   hintText: 'Age',
                  //   obscureText: false,),
                  //
                  // const SizedBox(height: 15,),
                  //
                  //
                  // MyTextField(controller: _birth_soonController,
                  //   hintText: 'Birth Year',
                  //   obscureText: false,),


                 SizedBox(height: 15,),

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
                            color: Colors.cyan
                          )),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.bold),
                        ),
                      ),

                      Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.cyan,
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
                          child: Text('Log In now', style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.bold),)),
                    ],
                  ),

                  SizedBox(height: 25,),

                ],

              ),
            ),
          ),
        )
    );

  }
}
