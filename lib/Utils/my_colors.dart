import 'package:flutter/material.dart';

class MyColors {
  static Color? primary = Colors.grey[900]; //Color(0xFF1976D2);
  static Color? primaryDark = Colors.grey[900]; //Color(0xFF1565C0);
  static Color? primaryLight = Colors.grey[900]; //Color(0xFF1E88E5);
  static const Color primaryVeryLight = Color(0xFFD5E4F1);
  static const Color accent = Color(0xfff7892b);
  static const Color accentDark = Color(0xfff7892b);
  static const Color accentLight = Color(0xfff7892b);
  static const Color lightBlue = Color(0x00000007);
  static const Color darkBlue = Color(0x00000008);
  static  Color shadeBlue =HexColor("#ebf9ff");
  static  Color appColor =HexColor("#77CBD2");
  static  Color brown =HexColor("#FBCD59");
  static  Color brownLight =HexColor("#FCE0A2");
  static  Color grey01 =HexColor("#b8b8b8");
  static  Color appBlue =HexColor("#009ee5");
  static  Color shadeBlack =HexColor("#484848");
  static  Color lightgreen =HexColor("#D5FCEB");
  static  Color lightwhite =HexColor("#f8f9fd");
  static  Color greenLight =HexColor("#54c492");
  static  Color paste =HexColor("#99FEFF");
  static  Color greenPaste =HexColor("#D5FCEB");
  static  Color deepBlue =HexColor("#3866BB");
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xff1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);

  // customcolor

  static  Color customRed =HexColor("#EE3E54");


}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}