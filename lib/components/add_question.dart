

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/my_button.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import 'package:uuid/uuid.dart';


class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final  FirebaseAuth _auth =FirebaseAuth.instance;
  final QuestionController = TextEditingController();
  final AnswerController = TextEditingController();
  final SeletedCategoryController= TextEditingController();






  //add user detail
  Future addall()
  async {

    if (selectedValues.isNotEmpty) {
      final User? user = _auth.currentUser;
      final _uid = user!.uid;
      String questionId = Uuid().v4();

      FirebaseFirestore.instance.collection('All Questions')
          .doc(questionId)
          .set({
        'questionId': questionId,
        'UserId': _uid,
        'Question': QuestionController.text.trim(),
        'Answer':AnswerController.text.trim(),
        'Category': selectedValues,
        //'email':SeletedCategoryController.text.trim(),
        'createAt': Timestamp.now(),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Question Added ')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Add your Question: $error')),
        );
      });
    }

    QuestionController.clear();
    AnswerController.clear();
    selectedValues.clear();

  }






  List<String> selectedValues = [];
  List<String> items = ["Fashion","Beauty","Travel","Lifestyle" ,"Personal" ,
    "Tech" ,
    "Health" ,
    "Fitness" ,
    "Wellness" ,
    "SaaS" ,
    "Business" ,
    "Education" ,
    "Food & Recipe" , "Love & Relationships" ,
    "Alternative topics" ,
    "Green living" ,
    "Music" ,
    "Automotive" ,
    "Marketing" ,
    "Internet services" ,
    "Finance" ,
    "Sports" ,
    "Entertainment" ,
    "Productivity" ,
    "Hobbies" ,
    "Parenting" ,
    "Pets",
    "Photography"
  ];



  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    QuestionController.dispose();
    AnswerController.dispose();
    SeletedCategoryController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(

            child: Column(

                children: [

                  Container(
                      padding: EdgeInsets.only(top:30,left: 10,right: 10,bottom: 10),


                    child: Center(
                      child: TextField(
                        controller: QuestionController,
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF8F8F8) )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)
                          ),
                          fillColor: Color(0xffDFD8FB),
                          filled: true,
                          hintText: "Enter your Question",
                          hintStyle: TextStyle(color: Color(0xff242424) , fontWeight: FontWeight.normal),
                          //labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.normal)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),


                  Padding(
                    padding: EdgeInsets.only(top:20,left: 10,right: 10),
                    child: Container(

                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           MultiSelectDialogField(
                             items: items
                                 .map((item) => MultiSelectItem(item, item))
                                 .toList(),
                             listType: MultiSelectListType.CHIP,
                             onConfirm: (selectedItems) {
                               selectedValues = selectedItems.map((e) => e.toString()).toList();
                             },
                           ),
                           SizedBox(height: 20),
                         ],
                       )

                    ),
                  ),



                  Container(
                    padding: EdgeInsets.only(top:30,left: 10,right: 10),


                    child: Center(
                      child: TextField(
                        controller: AnswerController,
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF8F8F8) )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)
                          ),
                          fillColor: Color(0xffDFD8FB),
                          filled: true,
                          hintText: "Asnwer your Question",
                          hintStyle: TextStyle(color: Color(0xff242424) , fontWeight: FontWeight.normal),
                          //labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.normal)
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 30,),

                MyButton(
                  text: 'Ask Question or Post',
                  onTap: addall,
                    ),

                  SizedBox(height: 300,),

                ],
            )

        ),
      ),

    );
  }
}
