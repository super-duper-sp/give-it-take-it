import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:giveit_takeit/pages/Profile_Update_page.dart';

import '../components/user_question_card.dart';




class UserProfile extends StatefulWidget {

   UserProfile({super.key });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void gotoUpdateProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileUpdate()),);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference questions = FirebaseFirestore.instance.collection('All Questions');
  final CollectionReference answers = FirebaseFirestore.instance.collection('All Answers');

  Future<int> getCurrentUserQuestionCount() async {
    if (user == null) return 0;
    QuerySnapshot querySnapshot = await questions.where('UserId', isEqualTo: user?.uid).get();
    return querySnapshot.size;
  }

  Future<int> getCurrentUserAnswerCount() async {
    if (user == null) return 0;
    QuerySnapshot querySnapshot = await answers.where('UserId', isEqualTo: user?.uid).get();
    return querySnapshot.size;
  }

  String? fname = '';
  String? lname = '';
  String? email = '';
  String? byear = '';
  String? age   = '';
  String? bio   = '';
  File? imageXFile;
  String? image ='';

  Future _getDataFromDatabase () async{
      await FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async
          {
             if(snapshot.exists){
               setState(() {
                 fname = snapshot.data()!["fname"];
                 lname =snapshot.data()!["lname"];
                 email =snapshot.data()!["email"];
                 byear =snapshot.data()!["birth"];
                 age   = snapshot.data()!["age"];
                 image =snapshot.data()!["userImage"];
                 bio =snapshot.data()!["bio"];

               });
             }
          });
      setState(() {});
  }

    @override
    void initState(){
      _getDataFromDatabase();
      getCurrentUserAnswerCount();
      getCurrentUserQuestionCount();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(

          home: Scaffold(
            backgroundColor: Color(0xffffffff),
            body: SafeArea(
              child: Stack(
                  children:[


                    Padding(
                        padding: const EdgeInsets.only(top:370,left: 5,right: 5,bottom: 5),

                       child: Container(
                         margin: EdgeInsets.all(10),
                         decoration: BoxDecoration(
                                 color: Color(0xffF8F8F8),
                                 borderRadius:  BorderRadius.all(Radius.circular(10)
                                 ),
                               ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: UserQuestionCard(user_Id: user!.uid),
                           )),

                        // child: Container(
                        //
                        //     decoration: BoxDecoration(
                        //       color: Colors.white60,
                        //       borderRadius:  BorderRadius.all(Radius.circular(10)
                        //       ),
                        //     ),
                        //     child:Column(
                        //
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //
                        //           child: Container(
                        //             height: 80,
                        //             width: 390,
                        //             decoration: BoxDecoration(
                        //               color: Color(0xffFAE5D2),
                        //               borderRadius:  BorderRadius.all(Radius.circular(10)
                        //               ),
                        //             ),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Center(child: Text("What is ur name?",style: TextStyle(fontSize: 20),)),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //
                        //     )
                        // )
                    ),


                    //user counter no. of Q & A
                    Padding(
                      padding: const EdgeInsets.only(top:300,left: 10),
                      child: Container(
                        height: 60,
                        width: 270,
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius:  BorderRadius.all(Radius.circular(20)
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xffdeecec),
                                  borderRadius:  BorderRadius.all(Radius.circular(10)
                                  ),
                                ),
                                child:FutureBuilder<int>(
                                  future: getCurrentUserQuestionCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      int questionCount = snapshot.data ?? 0;
                                      return Center(
                                        child:Text("Q: $questionCount" ,style: TextStyle(color: Color(0xff242424),fontSize: 25,fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                // Center(
                                //     child: Text("Q:150",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                                //     )
                                // ),
                              ),


                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xffdeecec),
                                  borderRadius:  BorderRadius.all(Radius.circular(10)
                                  ),
                                ),
                                child: FutureBuilder<int>(
                                  future: getCurrentUserAnswerCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      int answerCount = snapshot.data ?? 0;
                                      return Center(
                                        child:Text("A: $answerCount" ,style: TextStyle(color: Color(0xff242424),fontSize: 25,fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    //profile edit
                    Padding(
                      padding: const EdgeInsets.only(top:300,left:295),
                      child: Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Color(0xff242424),
                            borderRadius:  BorderRadius.all(Radius.circular(20)
                            ),
                          ),
                          child: Container(
                            height: 50,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff242424),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              onPressed: gotoUpdateProfile,

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  
                                 Container(
                                   child: Icon(
                                     Icons.edit,
                                     size: 30.0,
                                   ),
                                 )


                                ],
                              ),
                            ),
                          )//edit


                      ),
                    ),




                    //profile section
                    Padding(
                      padding: const EdgeInsets.only(top: 80 ,left: 8,right: 8),
                      child: Container(

                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffdeecec),
                          borderRadius:  BorderRadius.all( Radius.circular(10)
                          ),
                        ),


                        //profile picture and name
                        child: Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(

                                children: [

                                  Container(
                                    height: 150.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              color: Color(0xff242424),
                                              offset: Offset(0, 2))
                                        ],
                                        borderRadius: BorderRadius.circular(10),

                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageXFile == null ? NetworkImage(image!) : Image.file( imageXFile! ).image,
                                          ),
                                        )


                                  ),


                                  SizedBox(height: 4,),

                                  Text( fname! + ' '+ lname! ,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff242424),
                                    ),
                                  ),




                                ],
                              ),


                              //profile details
                              Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(

                                      width: 190,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "$email",
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold ),
                                        maxLines: 2,),
                                    )
                                  ),



                                 Padding(
                                   padding: const EdgeInsets.only(left: 10),
                                   child: Text("BIO" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 11 ,fontWeight: FontWeight.bold )),
                                 ),




                                  Container(

                                    width: 200.0,

                                    child: Center(
                                      child: Row(
                                        children: [


                                          // Text( age! ,
                                          //   style: TextStyle(
                                          //     fontSize: 10,
                                          //     fontWeight: FontWeight.bold,
                                          //     color: Color(0xff1e0d2d),
                                          //   ),
                                          // ),

                                      Container(
                                      width: 190,

                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0xff242424),
                                            blurRadius: 1,
                                            offset: Offset(0, 2),
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            bio!,
                                            //textAlign: TextAlign.justify,
                                           // overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12.0,color: Colors.grey,fontWeight: FontWeight.bold),
                                            maxLines: 7,
                                            ),
                                        )
                                    ),




                                        ],
                                      ),
                                    ),
                                  ),

                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,top: 5),
                                          child: Text("Age: $age" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,top: 5),
                                          child: Text("YoB: $byear" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold )),
                                        ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),


                            ],
                          ),
                        ),

                      ),
                    ),


                    //profile
                    Container(
                        padding: EdgeInsets.only(right:5,bottom:5,top:5),
                        height: 70,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0xffdeecec),
                              blurRadius: 1,
                              offset: Offset(0, 2),
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("PROFILE", style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff242424),
                            )
                            ),


                            SizedBox(width: 150,),

                            Container(
                              height: 60,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Color(0xff242424),
                                borderRadius:  BorderRadius.all(Radius.circular(20)
                                ),
                              ),


                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff242424),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                onPressed: signUserOut ,


                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon( // <-- Icon
                                      Icons.logout_rounded,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('LogOut'), // <-- Text

                                  ],
                                ),
                              ),
                              //child: IconButton(onPressed: signUserOut, icon: Icon(Icons.close,size:55.0)


                            ),





                          ],



                        )
                    ), //app bar




                  ]
              ),
            ),



          )





      );
    }

}

