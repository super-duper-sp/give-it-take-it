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

class UserQuestionCard extends StatelessWidget {
   UserQuestionCard({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('All Questions').where('UserId', isEqualTo: _auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = [];
          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            posts.add(Post(Question: data['Question'], CreateAt: data['Answer'] ,questionId: data['questionId']));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return
                //title: Text(posts[index].CreateAt),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuestionDetailPage(questionId: posts[index].questionId),
                      ),
                    );
                  },

                  child: Container(
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
                            posts[index].Question,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                            maxLines: 3,),
                        ),
                      )
                  ),
                );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        }
        return Text('No data available'); // Handle no data scenario
      },
    );
  }
}





