import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_textfield.dart';
import 'package:giveit_takeit/pages/user_profile.dart';
import 'package:image_picker/image_picker.dart';

import '../components/my_button.dart';
class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({super.key});

  @override
  State<UserProfileUpdate> createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {


  final  FirebaseAuth _auth =FirebaseAuth.instance;
  final  bioController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController= TextEditingController();
  final ageController = TextEditingController();
  final birthController = TextEditingController();
  bool _bioValid = true ;

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

  final currentUser = FirebaseFirestore.instance.collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  bool isUpdating = false; // Flag to track whether update is in progres


  // Future<void> updateUserProfile()  async {
  //
  //
  //     final ref = FirebaseStorage.instance.ref()
  //         .child('userProfileImages')
  //         .child(DateTime.now().toString() + '.jpg');
  //     await ref.putFile(imageFile!);
  //
  //     imageUrl = await ref.getDownloadURL();
  //     currentUser.update({
  //       'fname': fnameController.text.trim(),
  //       'lname': lnameController.text.trim(),
  //       'age': ageController.text.trim(),
  //       'birth': birthController.text.trim(),
  //       'bio': bioController.text.trim(),
  //     }).then((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Profile Updated')),
  //       );
  //     }).catchError((error) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed To Profile Update: $error')),
  //       );
  //     });
  //
  //
  //   }


  Future<void> updateUserProfile() async {
    User? user = _auth.currentUser;


    if (user != null) {


      Map<String, dynamic> updatedData = {};


      if (imageFile != null) {
        Reference imageRef = FirebaseStorage.instance.ref()
            .child('userProfileImages')
            .child(DateTime.now().toString() + '.jpg');
        await imageRef.putFile(imageFile!);
        imageUrl = await imageRef.getDownloadURL();
        updatedData['userImage'] = imageUrl;

      }

      if (fnameController.text.isNotEmpty) {
        updatedData['fname'] = fnameController.text;
      }

      if (lnameController.text.isNotEmpty) {
        updatedData['lname'] = lnameController.text;
      }
      if (ageController.text.isNotEmpty) {
        updatedData['age'] = ageController.text;
      }

      if (birthController.text.isNotEmpty) {
        updatedData['birth'] = birthController.text;
      }
      if (bioController.text.isNotEmpty) {
        updatedData['bio'] = bioController.text;
      }

      if (updatedData.isNotEmpty) {
        await currentUser.update(updatedData);


        setState(() {});
        // Update was successful, you can handle UI refresh here
      } else {
        // No fields to update
      }
    }
  }




  String fname = '';
  String lname = '';
  String age = '';
  String birth = '';
  String bio = '';
  String? image ='';

  Future _getFieldDataFromDatabase () async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists){
        setState(() {
          fname = snapshot.data()!["fname"];
          lname =snapshot.data()!["lname"];
          age   = snapshot.data()!["age"];
          birth  = snapshot.data()!["birth"];
          bio =snapshot.data()!["bio"];
          image =snapshot.data()!["userImage"];

        });
      }
    });

  }
  void initState(){
    _getFieldDataFromDatabase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCEFE3),

      body: SafeArea(
        child: Stack(
          children: [
            //profile
            Container(
                padding: EdgeInsets.only(right:5,bottom:5,top:5),
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius:  BorderRadius.all( Radius.circular(20),)
                  ,
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("EDIT PROFILE", style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff132D2F),
                    )
                    ),


                    SizedBox(width: 140,),

                    Container(
                      height: 60,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xffFAE5D2),
                        borderRadius:  BorderRadius.all(Radius.circular(20)
                        ),
                      ),


                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff132D2F),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon( // <-- Icon
                              Icons.arrow_back,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Back'), // <-- Text

                          ],
                        ),
                      ),
                      //child: IconButton(onPressed: signUserOut, icon: Icon(Icons.close,size:55.0)


                    ),





                  ],



                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 90),
              child:
                 SingleChildScrollView(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [



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
                              image:  NetworkImage( '$image' ) ,
                              )
                          ),
                        ),
                      ),

                      const SizedBox(height: 15,),
                      MyTextField(controller: fnameController,
                        hintText: '$fname',
                        obscureText: false,),

                      const SizedBox(height: 15,),

                      MyTextField(controller: lnameController,
                        hintText: '$lname',
                        obscureText: false,),

                      const SizedBox(height: 15,),

                      MyTextField(controller: ageController,
                        hintText: '$age',
                        obscureText: false,),

                      const SizedBox(height: 15,),

                      MyTextField(controller: birthController,
                        hintText: '$birth',
                        obscureText: false,),

                      const SizedBox(height: 25
                        ,),

                      MyTextField(controller: bioController,
                        hintText: 'Bio',
                        obscureText: false,),

                      const SizedBox(height: 25
                        ,),

                      MyButton(
                        text: 'Save',
                        onTap: updateUserProfile ,
                      ),



                        ],

                        ),
                 )
                 ),




                  ],

                ),
              ),



    );
  }
}
