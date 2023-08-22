import 'package:flutter/material.dart';


class CategoryCards extends StatelessWidget {

  List<String> categories = ["Fashion","Beauty","Travel","Lifestyle" ,"Personal" ,
    "Tech" ,
    "Health" ,
    "Fitness" ,
    "Wellness" ,
    "SaaS" ,
    "Business" ,
    "Education" ,
    "Food & Recipe" , "Love & Relationships" ,
    "Alternative topics" ,
    "Green living" ,
    "Music" ,
    "Automotive" ,
    "Marketing" ,
    "Internet services" ,
    "Finance" ,
    "Sports" ,
    "Entertainment" ,
    "Productivity" ,
    "Hobbies" ,
    "Parenting" ,
    "Pets",
    "Photography"
  ];

  CategoryCards({super.key });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((country){
            return Container(
              margin: EdgeInsets.all(10),
                height: 150, width:130,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(country ,style: TextStyle(color: Colors.white,fontSize: 20, fontWeight:FontWeight.bold),textAlign: TextAlign.center),
                ),
                decoration:  BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xffE9913F)),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                color: Colors.amber,
                image: DecorationImage(
                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/userImages%2Fcategories%2Ffashion.jpeg?alt=media&token=75e60351-2662-4048-8a13-0dd4ef4037fb'),
                fit: BoxFit.cover),
                 ),

            );
          }).toList(),

        )
    );

  }
}

