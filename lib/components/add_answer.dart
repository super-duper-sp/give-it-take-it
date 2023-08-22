import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'my_button.dart';
class AddAnswer extends StatefulWidget {
  const AddAnswer({super.key});

  @override
  State<AddAnswer> createState() => _AddAnswerState();
}

class _AddAnswerState extends State<AddAnswer> {

  final CollectionReference questions = FirebaseFirestore.instance.collection('All Questions');
  List<dynamic> questionList = [];
  String selectedQuestion = '';
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    QuerySnapshot querySnapshot = await questions.get();
    setState(() {
      questionList = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question and Answer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('Select a question'),
              value: selectedQuestion.isNotEmpty && questionList.contains(selectedQuestion)
                  ? selectedQuestion
                  : null,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedQuestion = newValue;
                  });
                }
              },
              items: questionList.map<DropdownMenuItem<String>>((dynamic question) {
                return DropdownMenuItem<String>(
                  value: question['Question'],
                  child: Text(question['Question']),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Question: $selectedQuestion',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: answerController,
              decoration: InputDecoration(labelText: 'Your Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                submitAnswer();
              },
              child: Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }

  void submitAnswer() async {
    if (selectedQuestion.isNotEmpty) {
      QuerySnapshot querySnapshot =
      await questions.where('Question', isEqualTo: selectedQuestion).get();
      String questionId = '';
      if (querySnapshot.size > 0) {
        setState(() {
          questionId = querySnapshot.docs.first.id;
        });


        String answer = answerController.text.trim();

        if (answer.isNotEmpty) {
          final  FirebaseAuth _auth =FirebaseAuth.instance;
            final User? user = _auth.currentUser;
            final _uid = user!.uid;
            String answerId = Uuid().v4();

            FirebaseFirestore.instance.collection('All Answers')
                .doc(answerId)
                .set({
              'answerId': answerId,
              'UserId': _uid,
              'questionId':questionId,
              'Answer': answerController.text.trim(),
              'createAt': Timestamp.now(),
            }).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Answer submitted to selected question')),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to submit to selected question: $error')),
              );
            });
          }

        }
      }
    }

}