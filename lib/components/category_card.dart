import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/categorywise_question_page.dart';


class CategoryCards extends StatelessWidget {

  List<String> categoryImageUrls = [
    'food_image_url',  // Replace with actual URLs from Firebase Storage
    'nature_image_url',
    'travel_image_url',
  ];

  List<Map<String, String>> categories = [
    {'name': 'Pets', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fpets.jpg?alt=media&token=07ac85c6-5beb-4537-acbd-14a742d934b3'},
    {'name': 'Automotive', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fautomotive.jpg?alt=media&token=cbe9d51b-5259-4a62-b597-3e213ff0aca4'},
    {'name': 'Tech', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ftech.jpg?alt=media&token=637ebaf9-dc02-4fba-9ded-54737cd8eccc'},

    {'name': 'Fashion', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fbeauty.jpeg?alt=media&token=8d99e9e0-4402-4a93-8654-ed00243adb5d'},
    {'name': 'Beauty', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ffashion.jpeg?alt=media&token=b5f033ef-52ca-4ae0-b2a5-2d18ccd624f6'},
    {'name': 'Travel', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ftravel.jpeg?alt=media&token=0a74f7eb-ff88-450a-9add-e32578ad987c'},
    {'name': 'Lifestyle', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Flifestyle.jpeg?alt=media&token=025cb16c-fa09-4bdb-b485-9c52c8583d5f'},
    {'name': 'Personal', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fpersonal.jpeg?alt=media&token=e47d583f-02b3-432a-8d4b-f2845104d3a5'},
    {'name': 'Health', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fhealth.jpg?alt=media&token=49e45b5a-86af-4e99-81c0-b2f0dc412437'},
    {'name': 'Fitness', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ffitness.jpg?alt=media&token=3172f4cc-655e-4ddc-8858-2ccddb4afd2c'},
    {'name': 'Wellness', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fwellness.jpg?alt=media&token=3662f8b3-4e18-4e1b-8c84-02b3741772e0'},
    {'name': 'SaaS', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fsaas.jpg?alt=media&token=a8ef3fbe-578f-4d98-89d5-71788ef1238f'},
    {'name': 'Business', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fbusiness.jpg?alt=media&token=3a7a88a0-3548-4b98-b99b-dacc7ed0ff93'},
    {'name': 'Education', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Feducation.jpg?alt=media&token=a6ec3e5a-725c-4f8b-9d04-82d76dae8dd2'},
    {'name': 'Food & Recipe', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ff%26r.jpg?alt=media&token=f9317d33-5b8e-4990-a14f-1ae9332629ad'},
    {'name': 'Love & Relationships', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fl%26r.jpg?alt=media&token=3d686465-12be-4ff3-8e8a-aac7c1a1abd8'},
     {'name': 'Alternative topics', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Falter.jpg?alt=media&token=4cbdb20f-a5a6-4c9d-8e9b-bf36c6d10e80'},
    {'name': 'Green living', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fgreenliving.jpg?alt=media&token=dca90b67-1e0e-40ce-b9cc-3d56d2b9a3b5'},
    {'name': 'Music', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fmusic.jpg?alt=media&token=b4ea0e23-d4ac-41df-ae0d-7c09872922eb'},
    {'name': 'Marketing', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fmarketing.jpg?alt=media&token=3ad20b5f-38d7-4209-9c7f-3dbc98f7fd84'},
    {'name': 'Internet services', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fis.jpg?alt=media&token=6f5d621d-484f-4b38-af09-28ee0a0ba772'},
    {'name': 'Finance', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Ffinance.jpg?alt=media&token=833b7d34-768d-4f75-948d-f55d4f4dbc2c'},
    {'name': 'Sports', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fsports.jpg?alt=media&token=b1d9b173-57d6-455f-948b-d540b234f917'},
    {'name': 'Entertainment', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fenter.jpg?alt=media&token=2a23bf31-717c-4e3f-b9fe-9d7f7ac99c3f'},
    {'name': 'Productivity', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fproductivity.jpg?alt=media&token=6d747515-7eb7-42a0-9d49-38c840cb4d33'},
    {'name': 'Hobbies', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fhobbies.jpg?alt=media&token=3771862c-d95d-4fe3-83d1-ba9f6ad5e750'},
    {'name': 'Parenting', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fparenting.jpg?alt=media&token=d4565ae6-2f5c-4b1b-b62a-269d9b22d059'},
    {'name': 'Photography', 'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/giveit-takeit.appspot.com/o/categories%2Fphotography.jpg?alt=media&token=2bd03432-fbba-4c8b-a2e7-dd280a9ee427'},
  ];

  CategoryCards({super.key });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category){
            final categoryName = category['name'];
            final imageUrl = category['imageUrl'];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryWiseQ(category: categoryName,image: imageUrl),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                  height: 150, width:130,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                  //   child: Text(categoryName! ,style: TextStyle(color: Colors.white,fontSize: 20, fontWeight:FontWeight.bold),textAlign: TextAlign.center),
                    child: Text(
                      categoryName!,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 60, // Adjust the blur radius to control the intensity of the shadow
                            color: Colors.black,
                          ),
                        ],

                      ),
                    ),
                  ),
                  decoration:  BoxDecoration(
                    border: Border.all(width: 6, color: Colors.yellow),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  color: Colors.amber,
                  image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover),
                   ),

              ),
            );
          }).toList(),

        )
    );

  }
}

