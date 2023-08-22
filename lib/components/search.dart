import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giveit_takeit/components/user_question_card.dart';

class PostSearch extends StatefulWidget {
  @override
  _PostSearchState createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Post> _searchResults = [];

  void _performSearch(String searchText) {
    _firestore
        .collection('All Questions')
        .where('Question', isGreaterThanOrEqualTo: searchText )
        .get()
        .then((QuerySnapshot snapshot) {

      setState(() {
        _searchResults = snapshot.docs.map((doc) => Post(Question: doc['Question'], CreateAt: doc['Answer'])).toList();
      });
    }).catchError((error) {
      print("Error searching posts: $error");
    });
  }

  // List<Post> _searchResults = [];
  //
  // Future<List<Post>> searchPosts(String query) async {
  //   List<Post> results = [];
  //
  //   // Fetch posts from Firestore based on category
  //   QuerySnapshot categoryQuery = await _firestore.collection('All Questions')
  //       .where('Category', isEqualTo: query)
  //       .get();
  //   categoryQuery.docs.forEach((doc) {
  //     var data = doc.data() as Map<String, dynamic>;
  //     results.add(Post(Question: data['Question'], CreateAt: data['Answer']));
  //   });
  //
  //   // Fetch posts from Firestore based on title
  //   QuerySnapshot titleQuery = await _firestore.collection('All Questions')
  //       .where('Question', isEqualTo: query)
  //       .get();
  //   titleQuery.docs.forEach((doc) {
  //     var data = doc.data() as Map<String, dynamic>;
  //     results.add(Post(Question: data['Question'], CreateAt: data['Answer']));
  //   });
  //
  //   return results;
  // }
  //
  // void _performSearch(String query) async {
  //   if (query.isNotEmpty) {
  //     List<Post> searchResults = await searchPosts(query);
  //     setState(() {
  //       _searchResults = searchResults;
  //     });
  //   }
  // }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
              controller: _searchController,
              onChanged: _performSearch,
                    textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                    hintText: 'Search ',
                    hintStyle: MaterialStateProperty.all(const TextStyle(color: Color(0xffEDA47E))),
                    leading: const Icon(Icons.search,color: Color(0xffEDA47E), size: 30,),
                    backgroundColor: MaterialStateProperty.all(const Color(0xffFAE5D2)),
                    shadowColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all(const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)),))
            ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return
                  // title: Text(_searchResults[index].Question),
                  // subtitle: Text(_searchResults[index].CreateAt),
                Container(
                    margin: EdgeInsets.all(4),
                    width: 100,
                    height: 70,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x194C4844),
                          blurRadius: 64,
                          offset: Offset(0, 14),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child:Center(
                      child: Text(
                        _searchResults[index].Question,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                        maxLines: 3,),
                    )
                );
            },
          ),
        ),
      ],
    );
  }
}