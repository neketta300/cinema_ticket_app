import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:flutter/material.dart';

class MyLogRegTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscurreText;
  const MyLogRegTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscurreText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white60),
        controller: controller,
        obscureText: obscurreText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 106, 106, 106)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white60),
        ),
      ),
    );
  }
}
