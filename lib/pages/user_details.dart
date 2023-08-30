import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/user_question_card.dart';

class UserDetailsPage extends StatefulWidget {

  final String userId ;

  UserDetailsPage({required this.userId });

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  Map<String, dynamic> userDetails = {};
  final CollectionReference questions = FirebaseFirestore.instance.collection('All Questions');
  final CollectionReference answers = FirebaseFirestore.instance.collection('All Answers');

  @override
  void initState() {

    _getDataFromDatabase();
    fetchUserDetails();
    super.initState();
  }

  Future<int> getCurrentUserQuestionCount() async {
    QuerySnapshot querySnapshot = await questions.where('UserId', isEqualTo: widget.userId).get();
    return querySnapshot.size;
  }

  Future<int> getCurrentUserAnswerCount() async {
    QuerySnapshot querySnapshot = await answers.where('UserId', isEqualTo: widget.userId).get();
    return querySnapshot.size;
  }

  Future<void> fetchUserDetails() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          userDetails = userSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        print('User not found');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  File? imageXFile;
  String? image ='';

  Future _getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists){
        setState(() {
          image =snapshot.data()!["userImage"];
        });
      }
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xff242424),
      ),
      body: Center(
        child: userDetails.isNotEmpty
            ? Column(
                children:[

                  SizedBox(height: 10,),
                  //user counter no. of Q & A
                  Container(
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
                  SizedBox(height: 5,),
                  Text( "${userDetails['fname']}" + ' '+ "${userDetails['lname']}" ,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff242424),
                    ),
                  ),
                  SizedBox(height: 5,),

                  //profile section
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
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
                                        "${userDetails['email']}",
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
                                                "${userDetails['bio']}",
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 14.0,color: Colors.grey,fontWeight: FontWeight.bold),
                                                maxLines: 5,
                                              ),
                                            )
                                        ),




                                      ],
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 5),
                                      child: Text("Age: ${userDetails['age']}" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 5),
                                      child: Text("YoB: ${userDetails['birth']}" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold )),
                                    ),
                                  ],
                                ),


                              ],
                            ),


                          ],
                        ),
                      ),

                    ),
                  ),


                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius:  BorderRadius.all(Radius.circular(10)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserQuestionCard(user_Id: widget.userId),
                        )),
                  ),






                ]
            )
            : CircularProgressIndicator(), // Display loading indicator
      ),
    );
  }
}



//
// body: Center(
// child: userDetails.isNotEmpty
// ? Column(
// children: [
// Text('Name: ${userDetails['fname']}'),
// Text('Email: ${userDetails['email']}'),
// Text('Name: ${userDetails['lname']}'),
// Text('Email: ${userDetails['byea']}'),
// // Display other user details
// ],
// )
//     : CircularProgressIndicator(), // Display loading indicator
// ),