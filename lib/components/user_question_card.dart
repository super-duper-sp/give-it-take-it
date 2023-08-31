import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/Question_detail_page.dart';


class Post {
  final String Question;
  final String CreateAt;
  final String questionId;

  Post({required this.Question, required this.CreateAt, required this.questionId});
}
class UserQuestionCard extends StatefulWidget {
  final String user_Id;

  UserQuestionCard({required this.user_Id});

  @override
  _UserQuestionCardState createState() => _UserQuestionCardState();
}

class _UserQuestionCardState extends State<UserQuestionCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteQuestion(String questionId) async {
    try {
      await _firestore.collection('All Questions').doc(questionId).delete();
      // You might also want to update the state of your widget or reload the data here
    } catch (error) {
      // Handle error
      print('Error deleting question: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('All Questions')
          .where('UserId', isEqualTo: widget.user_Id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = [];
          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            posts.add(Post(
                Question: data['Question'],
                CreateAt: data['Answer'],
                questionId: data['questionId']));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailPage(
                        questionId: posts[index].questionId,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0xffdeecec),
                        blurRadius: 64,
                        offset: Offset(0, 14),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            posts[index].Question,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,

                        bottom: -1,
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          primary: Color(0xffdeecec), // Set the background color for the button
                        ),
                          onPressed: () {
                // Show a confirmation dialog
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Question'),
                    content: Text('Are you sure you want to delete this question that you asked?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Delete the question and close the dialog
                          await _deleteQuestion(posts[index].questionId);
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
              child: Text('Delete',style: TextStyle(color: Color(0xff242424)),),
              ),


                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     padding: EdgeInsets.symmetric(horizontal: 12),
                        //     primary: Color(0xffdeecec), // Set the background color for the button
                        //   ),
                        //   onPressed: () async {
                        //     await _deleteQuestion(posts[index].questionId);
                        //   },
                        //   child: Text('Delete',style: TextStyle(color: Color(0xff242424)),),
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return Text('No data available');
      },
    );
  }
}





