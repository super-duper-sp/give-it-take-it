
import 'package:giveit_takeit/pages/auth_page.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


// void main() {
//   runApp( MyApp());
// }

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}


// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   Platform.isAndroid?
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//         apiKey: "AIzaSyCq1aoTH_yEduSHH_7g9xgFAiYQP_jk3Tk",
//         appId: "1:1025732640895:android:993ed9dae212e555343f4a" ,
//         messagingSenderId: "1025732640895",
//         projectId: "giveit-takeit"
//     ),
//   )
//       :await Firebase.initializeApp();
//
//   runApp( MyApp());
// }
