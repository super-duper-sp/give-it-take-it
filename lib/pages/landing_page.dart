

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/category_card.dart';
import 'package:giveit_takeit/components/my_question_list_view.dart';


import '../components/question_card.dart';
import '../components/search.dart';

class LandingPage extends StatefulWidget {

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {




  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
//0xffFCEFE3
    return   Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
              children: [
                SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 2),
                //CATEGORY CARDS
                Container(
                  child: CategoryCards(),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: PostSearch(),
                    ),
                  ),
                ), //SEARCH & FILTER

                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    "All Questions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(

                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QuestionCard(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



        );








  }

  }

















