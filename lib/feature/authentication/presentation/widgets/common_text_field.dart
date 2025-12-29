import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.obsureText,
    required this.controller,
  });

  final String hintText;
  final TextInputType textInputType;
  final bool? obsureText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsureText ?? false, // Yeh line add ki hai
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.normalTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Width 10 se 1.0 kiya
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Radius 3.0 se 30.0 kiya
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // Improved padding
      ),
    );
  }
}