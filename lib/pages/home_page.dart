import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/add_question.dart';
import 'package:giveit_takeit/pages/landing_page.dart';
import 'package:giveit_takeit/pages/login_page.dart';
import 'package:giveit_takeit/pages/user_profile.dart';
import 'package:giveit_takeit/pages/question_&_answer_page.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;


  var PagesAll =[ LandingPage(),AnswerQuestion(),UserProfile()];
  var my_index=0;
  // sign user out\
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [
        //   IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
        //  ],),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xffFCEFE3),
          buttonBackgroundColor: Colors.white,
          color: Color(0xffFC8E12),

          animationDuration: Duration(milliseconds: 300),
          onTap: (index){
            setState(() {
              my_index = index;
            });
          },
          items: [
            Icon(Icons.home,
            size:50,
            color: Colors.black,
            ),
            Icon(Icons.arrow_upward_rounded,
                size:50,
                color: Colors.black
            ),
            Icon(Icons.settings ,
                size:50,
                color: Colors.black
            ),
          ],
        ),


      body: PagesAll[my_index],


    );
  }
}




// class HomePage extends StatelessWidget {
//
//   final user = FirebaseAuth.instance.currentUser!;
//   // sign user out\
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(actions: [
//           IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
//         ],),
//
//         body: Center(
//             child: Text(
//               "LOGGED IN AS: " + user.email!,
//             )
//         )
//
//     );
//   }
//
//
// }
