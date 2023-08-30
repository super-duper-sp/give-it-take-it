import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/Question_detail_page.dart';

class CategoryWiseQ extends StatelessWidget {
  final String category;
  final String image;

  CategoryWiseQ({required this.category, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Question Details'),
    ),
    backgroundColor: Colors.white,
    body:Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 150, width:130,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(category! ,style: TextStyle(color: Colors.white,fontSize: 20, fontWeight:FontWeight.bold),textAlign: TextAlign.center),
          ),
          decoration:  BoxDecoration(
            border: Border.all(width: 6, color: Colors.yellow),
            borderRadius: BorderRadius.all(Radius.circular(35)),
            color: Colors.amber,
            image: DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.cover),
          ),

        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('All Questions').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return Text('No data available');
                  }
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data = documents[index].data() as Map<String, dynamic>;

    if (data['Category'].contains(category)) {
      return
        // title: Text(data['Question']),
        //subtitle: Text(data['subtitle']),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionDetailPage(questionId: data['questionId']),
              ),
            );
          },

          child: Container(
              margin: EdgeInsets.all(4),
              width: 190,
              height: 70,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0xfff8e9c8),
                    blurRadius: 64,
                    offset: Offset(0, 14),
                    spreadRadius: 0,
                  )
                ],
              ),


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    data['Question'],
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    maxLines: 3,),
                ),
              )
          ),
        );
    }

    },


                  );

                },
              ),
            ),
          ),
        )
      ],
    )



    );
  }
}
