import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF00E51);
  static const Color secondary = Color(0xFFFF9E1B);
  static const Color primaryLigthBackground = Color.fromARGB(255, 247, 236, 232);
  static const Color secondaryLigthBackground = Color.fromARGB(255, 247, 213, 198);
  static const Color darkBackground = Color(0xff1f1f1f);
  static const Color titleColor = Color(0xfffa6a6a6);
  static const Color selectedColor = Color(0xfff666666);

  //priority colors
static const Color low = Color(0xffFFCFE7A5);
static const Color medium = Color(0xffF99233);
static const Color edit = Color(0xff57B7DD);
static const Color other = Color(0xFFFFBE0A);

  static const primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static const backgroundGradient = LinearGradient(
    colors: [primaryLigthBackground, secondaryLigthBackground],
    begin: AlignmentDirectional.bottomStart,
    end: AlignmentDirectional.topEnd,
  );
}
