import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/pages/user_details.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
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
                  String userId = questionData['UserId'];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(10),
                       boxShadow: [
                          BoxShadow(
                          color: Color(0xff242424),
                            spreadRadius: 2,
                           blurRadius: 3,
                           offset: Offset(0, 1),
                           ),
                             ],
                        ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                          color: Color(0xfff8e9c8),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffF8F8F8),
                                              spreadRadius: 3,
                                              blurRadius: 8,
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
                                                  style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Color(0xff242424)),
                                                  maxLines: 3,
                                                    ),
                                                  ),
                                             )
                                     ),
                                  ),
                                ),



                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserDetailsPage(userId: userId),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text("Querier",
                                    style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                      color: Colors.cyan
                                  ),),
                                )
                            ),
                            Center(
                              child: Card(
                                elevation: 5,

                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Color(0xffDFD8FB),
                                child: Column(
                                  children: [
                                    // Image.network(
                                    //   'https://example.com/car.jpg',
                                    //   width: double.infinity,
                                    //   height: 200,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        " ",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        userGivenAnswer,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )



                            // Center(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: Container(
                            //       //margin: EdgeInsets.only(left:10,right:10),
                            //         width: 400,
                            //         height: 70,
                            //         decoration: BoxDecoration(
                            //           color: Color(0xffFAE5D2),
                            //           borderRadius: BorderRadius.circular(10),
                            //           boxShadow: [
                            //             BoxShadow(
                            //               color: Colors.orange,
                            //               spreadRadius: 2,
                            //               blurRadius: 4,
                            //               offset: Offset(0, 2),
                            //             ),
                            //           ],
                            //         ),
                            //
                            //
                            //         child:Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Center(
                            //             child: Text(
                            //               userGivenAnswer ,
                            //               textAlign: TextAlign.justify,
                            //               overflow: TextOverflow.ellipsis,
                            //               style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
                            //               maxLines: 3,
                            //             ),
                            //           ),
                            //         )
                            //     ),
                            //   ),
                            // ),


                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Text('No question data.');
                }
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 10,top: 5,bottom: 5),
            child: Text("All Answers" , style: TextStyle( color: Colors.grey,fontSize: 22  ),),
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
                      String UserIdText = answerData['UserId'];
                      String  answerId =  answerData['answerId'];
                      var answerUpVote = answerData['answerUpVote'];
                      var upvotedBy = answerData['upvotedBy'];


                      User? user = FirebaseAuth.instance.currentUser;
                      String currentUserUid = user!.uid;



                     return Card(
                       elevation: 5,
                       margin: EdgeInsets.all(10),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       color: Colors.white,
                       child: Column(
                         children: [
                           // Image.network(
                           //   'https://example.com/car.jpg',
                           //   width: double.infinity,
                           //   height: 200,
                           //   fit: BoxFit.cover,
                           // ),
                           Padding(
                             padding: EdgeInsets.only(left: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) =>
                                             UserDetailsPage(userId: UserIdText),
                                       ),
                                     );
                                   },
                                   child: Text(
                                     'Respondent',
                                     style: TextStyle(
                                       fontSize: 14,
                                       color: Colors.grey,
                                     ),
                                   ),
                                 ),



                                 Row(
                                   children: [
                                     Text(
                                       'Upvotes: $answerUpVote',
                                       style: TextStyle(
                                         fontSize: 14,
                                         color: Colors.grey,
                                       ),
                                     ),


                                     IconButton(

                                       icon: Icon(upvotedBy.contains(currentUserUid) ? Icons.thumb_down : Icons.thumb_up),
                                       onPressed: () async {
                                         final answerRef = FirebaseFirestore.instance.collection('All Answers').doc(answerId);

                                         if (upvotedBy.contains(currentUserUid)) {
                                           // User has already upvoted, so remove upvote
                                           try {
                                             await answerRef.update({
                                               'answerUpVote': FieldValue.increment(-1), // Decrement upvote count
                                               'upvotedBy': FieldValue.arrayRemove([currentUserUid]), // Remove user ID
                                             });
                                           } catch (e) {
                                             print('Error removing upvote: $e');
                                           }
                                         } else {
                                           // User hasn't upvoted, so upvote
                                           try {
                                             await answerRef.update({
                                               'answerUpVote': FieldValue.increment(1), // Increment upvote count
                                               'upvotedBy': FieldValue.arrayUnion([currentUserUid]), // Add user ID
                                             });
                                           } catch (e) {
                                             print('Error upvoting answer: $e');
                                           }
                                         }
                                       },
                                     ),
                                   ],
                                 )


                               ],
                             ),

                             ),

                           Padding(
                             padding: EdgeInsets.all(10),
                             child: Text(
                               answerText,
                               style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.grey[800],
                               ),
                             ),
                           ),
                         ],
                       ),
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