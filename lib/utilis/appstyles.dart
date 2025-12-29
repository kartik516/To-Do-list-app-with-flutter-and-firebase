import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';

class AppStyles {
  static final headingTextStyle = GoogleFonts.mcLaren(
    fontSize: SizeConfig.getProportionateHeight(24),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final titleTextStyle = GoogleFonts.mcLaren(
    fontSize: SizeConfig.getProportionateHeight(18),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final normalTextStyle = GoogleFonts.mcLaren(
    fontSize: SizeConfig.getProportionateHeight(12),
    fontWeight: FontWeight.w100,
    color: Colors.black,
  );
}