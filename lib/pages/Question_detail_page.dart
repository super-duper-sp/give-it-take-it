import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionDetailPage extends StatelessWidget {

  final String questionId;

  QuestionDetailPage({required this.questionId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
        title: Text('Question Details'),
      ),
      backgroundColor: Color(0xffFCEFE3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('All Questions').doc(questionId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error fetching question.');
              } else if (snapshot.hasData) {
                var questionData = snapshot.data as DocumentSnapshot;
                String questionText = questionData['Question'];
                String userGivenAnswer = questionData['Answer'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                  //margin: EdgeInsets.only(left:10,right:10),
                                  width: 400,
                                  height: 70,
                                decoration: BoxDecoration(
                                  color: Color(0xffFAE5D2),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),


                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                          questionText ,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
                                          maxLines: 3,
                                            ),
                                          ),
                                     )
                             ),
                          ),
                        ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          //margin: EdgeInsets.only(left:10,right:10),
                            width: 400,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xffFAE5D2),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange,
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),


                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  userGivenAnswer ,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                              ),
                            )
                        ),
                      ),
                    ),


                  ],
                );
              } else {
                return Text('No question data.');
              }
            },
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SafeArea(child: Text("All Answers" , style: TextStyle( color: Colors.grey,fontSize: 20  ),)),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('All Answers')
                  .where('questionId', isEqualTo: questionId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error fetching answers.');
                } else if (snapshot.hasData) {
                  var answersData = snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: answersData.docs.length,
                    itemBuilder: (context, index) {
                      var answerData = answersData.docs[index];
                      String answerText = answerData['Answer'];

                     return Container(
                          margin: EdgeInsets.all(4),
                          width: 190,
                          height: 70,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x194C4844),
                                blurRadius: 64,
                                offset: Offset(0, 14),
                                spreadRadius: 0,
                              )
                            ],
                          ),


                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                answerText,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                maxLines: 1000,),
                            ),
                          )
                      );
                    },
                  );
                } else {
                  return Text('No answers available.');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}