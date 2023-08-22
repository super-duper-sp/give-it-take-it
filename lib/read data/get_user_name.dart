import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GetUserName extends StatelessWidget {

  final String documentId;

  GetUserName({required this.documentId});


  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
    future: user.doc(documentId).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        return Text('First Name: ${data['email name ']}');
      }
      return Text('loading');
    }),
    );
  }
}

