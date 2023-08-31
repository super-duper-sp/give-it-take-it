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

  final CollectionReference questions = FirebaseFirestore.instance.collection(
      'All Questions');
  List<dynamic> questionList = [];
  String selectedQuestion = '';
  TextEditingController answerController = TextEditingController();
  bool isSubmitting = false; // Flag to track submission status
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

      body: Container(

        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xffDFD8FB),
                  //background color of dropdown button
                  border: Border.all(color: Colors.black38, width: 1),
                  //border of dropdown button
                  borderRadius: BorderRadius.circular(
                      8), //border raiuds of dropdown button
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 4),
                  child: DropdownButton<String>(
                    hint: Center(child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text('Select a question', style: TextStyle(
                          color: Color(0xff242424))),
                    )),
                    value: selectedQuestion.isNotEmpty &&
                        questionList.contains(selectedQuestion)
                        ? selectedQuestion
                        : null,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    dropdownColor: Colors.white,

                    borderRadius: BorderRadius.circular(8),
                    //dropdown background color
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedQuestion = newValue;
                        });
                      }
                    },
                    items: questionList.map<DropdownMenuItem<String>>((
                        dynamic question) {
                      return DropdownMenuItem<String>(
                        value: question['Question'],
                        child: Text(question['Question'], style: TextStyle( //te
                          color: Color(0xff242424), //Font color
                          fontSize: 20,
                          //font size on dropdown button
                        ),),

                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                child: SafeArea(child: Text("Selected Question:",
                  style: TextStyle(color: Colors.grey, fontSize: 20),)),
              ),
              Center(
                child: Text(
                  '$selectedQuestion?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextField(
                  controller: answerController,
                  keyboardType: TextInputType.multiline,
                  maxLength: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF8F8F8))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)
                    ),
                    fillColor: Color(0xffDFD8FB),
                    filled: true,
                    hintText: "Answer the Selected Question",
                    hintStyle: TextStyle(color: Color(0xff242424),
                        fontWeight: FontWeight.normal),
                    //labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.normal)
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: isSubmitting
                    ? null // Disable the button while submitting
                    : () {
                  submitAnswer();
                },
                child: isSubmitting
                    ? CircularProgressIndicator() // Show loader while submitting
                    : Text('Submit Answer'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff242424),
                  padding: EdgeInsets.all(20),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),

              SizedBox(height: 300,),

            ],
          ),
        ),
      ),
    );
  }


  void submitAnswer() async {
    if (selectedQuestion.isNotEmpty) {
      setState(() {
        isSubmitting = true; // Show loader while submitting
      });


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
            final FirebaseAuth _auth = FirebaseAuth.instance;
            final User? user = _auth.currentUser;
            final _uid = user!.uid;
            String answerId = Uuid().v4();

            FirebaseFirestore.instance.collection('All Answers')
                .doc(answerId)
                .set({
              'answerId': answerId,
              'answerUpVote': 0,
              'upvotedBy': Set<String>(),
              'UserId': _uid,
              'questionId': questionId,
              'Answer': answerController.text.trim(),
              'createAt': Timestamp.now(),
            }).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Answer submitted to selected question')),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    'Failed to submit to selected question: $error')),
              );
            });
          }
        }
      }


      setState(() {
        isSubmitting = false; // Hide the loader
      });
    }
  }

}
