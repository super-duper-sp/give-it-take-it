import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({super.key,
    required this.imagePath,
    required this.onTap,
  });



  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellowAccent),
          borderRadius: BorderRadius.circular(16),
          color:  Color(0xfff8e9c8),
        ),
        child:Image.asset(imagePath),
          height: 90,

      ),
    );
  }
}
