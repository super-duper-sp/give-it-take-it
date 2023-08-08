import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out\
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
         ],),
      backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.black,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(Icons.home,
            size:50,
            color: Colors.grey
            ),
            Icon(Icons.favorite,
                size:50,
                color: Colors.grey
            ),
            Icon(Icons.settings ,
                size:50,
                color: Colors.grey
            ),
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
