import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
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


  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int my_index = 1;



  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: my_index);
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Color(0xfff8e9c8)),
          Icon(Icons.keyboard_double_arrow_up_outlined, color: Colors.white),
          Icon(Icons.person, color: Color(0xffdeecec)),
        ],
        inactiveIcons: const [
          Text("Home",style: TextStyle(fontSize: 15,color: Color(0xfff8e9c8),fontWeight: FontWeight.bold),),
          Text("Q/A",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
          Text("Me",style: TextStyle(fontSize: 15,color: Color(0xffdeecec), fontWeight: FontWeight.bold),),
        ],
        color: Color(0xff242424),
        height: 60,
        circleWidth: 60,
        activeIndex: my_index,
        onTap: (index) {
         setState(() {
         my_index = index;
       });
        },
        padding: const EdgeInsets.only(left: 7, right: 7, bottom: 5),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor:  Color(0xffF8F8F8),
        elevation: 10,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          my_index = v;
        },
        children: [
          PagesAll[my_index]
        ],
      ),
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




// Scaffold(
// // appBar: AppBar(actions: [
// //   IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
// //  ],),
// bottomNavigationBar: CurvedNavigationBar(
// backgroundColor: Color(0xffFCEFE3),
// buttonBackgroundColor: Colors.white,
// color: Color(0xffFC8E12),
//
// animationDuration: Duration(milliseconds: 300),
// onTap: (index){
// setState(() {
// my_index = index;
// });
// },
// items: [
// Icon(Icons.home,
// size:50,
// color: Colors.black,
// ),
// Icon(Icons.arrow_upward_rounded,
// size:50,
// color: Colors.black
// ),
// Icon(Icons.settings ,
// size:50,
// color: Colors.black
// ),
// ],
// ),
//
//
// body: PagesAll[my_index],
//
//
// );