import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/Question_detail_page.dart';


class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {

  final _auth = FirebaseAuth.instance.currentUser!.uid ;

  @override
  Widget build(BuildContext context) {


    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('All Questions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('No data available');
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;
              return
               // title: Text(data['Question']),
                //subtitle: Text(data['subtitle']),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuestionDetailPage(questionId: data['questionId']),
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
                            data['Question'],
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
        },
      ),

    );


  }
}
