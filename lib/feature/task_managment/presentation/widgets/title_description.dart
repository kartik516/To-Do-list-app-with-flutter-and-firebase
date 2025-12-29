import 'package:flutter/material.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';

class TitleDescription extends StatelessWidget {

  

  const TitleDescription({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.hintText,
    this.maxLines = 1,
    required this.controller,
  });

  final String title;
  final IconData prefixIcon;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.headingTextStyle.copyWith(fontSize: 18)),
        SizedBox(height: SizeConfig.getProportionateHeight(10)),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: Icon(prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}


