import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/add_question.dart';
import 'package:giveit_takeit/read%20data/get_user_name.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/add_answer.dart';

class AnswerQuestion extends StatefulWidget {
  const AnswerQuestion({super.key});

  @override
  State<AnswerQuestion> createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> with TickerProviderStateMixin {



  //toggle between
  int my_index=0;
  var PagesAll =[ AddQuestion(),AddAnswer()];



  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController( vsync: this ,length: 2);
    return  Scaffold(
      backgroundColor: Color(0xff242424),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                  children : [
                    Container(
                      child: TabBar(

                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                        controller: _tabController,
                          tabs: [
                                 Tab(
                                  child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                                  child: Align(
                                   alignment: Alignment.center,
                                   child: Text("Question",style: TextStyle( color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),
                                   ),
                                  ),
                                  ),
                                 ),

                                 Tab(
                                 child: Container(
                                 decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(50),
                                 border: Border.all(color: Colors.white, width: 1)),
                                 child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Answer",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                                 ),
                                 ),
                                 ),
                                 )
                              ]
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                           height: 750,
                           child:  TabBarView(
                             controller: _tabController,
                             children:  [

                               Container(child: AddQuestion()),
                               Container(child: AddAnswer())

                             ],

                           )
                      ),
                    )
    ]
      ),
            ),
          ),
    );

  }
}





// Padding(
// padding: const EdgeInsets.only(top: 100),
// child: Container(
//
// height: 150,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius:  BorderRadius.all(Radius.circular(25)
// ),
// ),
//
// child: Row(
// children: [
//
// Expanded(
// child: FutureBuilder(
// future: getDocID(),
// builder: (context , snapshot){
// return ListView.builder(
// itemCount: docIDs.length,
// itemBuilder: (context,index){
// return ListTile(
// //title: Text(docIDs[index]),
// title: GetUserName(documentId: docIDs[index],),
// );
// },
// );
// },),
// )
//
// ],
// ),
// ),
// ),







// '''
// Scaffold(
//       backgroundColor:  Color(0xFFEEEFEF),
//       body: Column(
//         children: [
//
//
//           Row(
//
//             children: [
//
//               const SizedBox(height: 150,),
//
//               Container(
//                 height: 100,width: 100,color: Colors.amber,
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 80),
//                 child: IconButton(onPressed: signUserOut,iconSize: 35.0, icon: Icon(Icons.close)),
//               ),
//
//
//             ],
//           ),
//
//
//
//
//           const SizedBox(height: 150,),
//
// //question
//           Expanded(
//
//             child: ListView.builder(
//                 itemCount: _user_questions.length,
//                 itemBuilder: (context, index){
//                 return MyQuestionListView(
//                     child: _user_questions[index],
//                 );
//             }),
//           ),
//
//
//         ],
//       ),
//
//
//     );
//'''