

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


  handleSearch(){

  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(

        home: Scaffold(
          backgroundColor: Color(0xffFCEFE3),
          body: Stack(
              children:[

                // SafeArea(
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 20 ,top: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //
                //         Container(
                //           height: 50,
                //             width: 55,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(15)
                //             ),
                //             child: Icon(Icons.notifications,size:35,
                //                 color: Colors.black),
                //         )// NOTIFICATION BAR
                //
                //       ],
                //     ),
                //   ),
                // ),



                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SafeArea(child: Text("Categories" , style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ),)),
                  ),




                //CATEGORY CARDS
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Container(
                    child: CategoryCards(),
                  ),
                ),




                    Padding(
                      padding: const EdgeInsets.only( left: 8 ,right:8 ,top: 440)
                      ,
                      child: Container(
                          width: 380,
                          height :490,
                           margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                             color: Color(0xffFAE5D2),
                            borderRadius:  BorderRadius.all(Radius.circular(10)
                                 ),
                                ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: QuestionCard(),
                                )
                      ),
                    ),



                Padding(
                  padding: const EdgeInsets.only( left: 10 ,right:10 ,top: 230),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [


                      SizedBox(height: 35,),



                      Container(
                          width: 380,
                          height :180,
                          decoration: BoxDecoration(
                            color: Color(0xffFAE5D2),
                            borderRadius:  BorderRadius.all(Radius.circular(10)
                            ),
                          ),
                          child: PostSearch()
                      ),

                      // Container(
                      //     width: 290.30,
                      //     height: 47.27,
                      //   child: SearchBar(
                      //
                      //           textStyle: MaterialStateProperty.all(
                      //           const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                      //           hintText: 'Search ',
                      //           hintStyle: MaterialStateProperty.all(const TextStyle(color: Color(0xffEDA47E))),
                      //           leading: const Icon(Icons.search,color: Color(0xffEDA47E), size: 30,),
                      //           backgroundColor: MaterialStateProperty.all(const Color(0xffFAE5D2)),
                      //           shadowColor: MaterialStateProperty.all(Colors.orange),
                      //           shape: MaterialStateProperty.all(const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)),))
                      //   ),
                      // ),
                      //SEARCH BAR



                    ],
                  ),


                ) ,//SEARCH & FILTER


                Padding(
                  padding: const EdgeInsets.only(left: 22,top: 375),
                  child: SafeArea(child: Text("All Questions" , style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ),)),
                ),

              ]

          ),



        )





    );


  }

  }

















