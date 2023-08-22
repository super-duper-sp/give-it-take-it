import 'package:flutter/material.dart';

class MyQuestionListView extends StatelessWidget {


  final String child ;

  MyQuestionListView({required this.child });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(child ,style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),

                    Center(
                      child: Text("What should i do for getting placed in weblancer ?"
                        ,style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),

                  ],
                ),
              ),


      ),
    );

  }
}
