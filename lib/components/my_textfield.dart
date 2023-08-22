import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEDA47) )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent.shade400)
          ),
          fillColor: Color(0xffFAE5D2),
          filled: true,
          hintText: hintText,
            hintStyle: TextStyle(color: Color(0xffEDA47E) , fontWeight: FontWeight.normal),
            //labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.normal)
        ),
      ),
    );
  }
}
