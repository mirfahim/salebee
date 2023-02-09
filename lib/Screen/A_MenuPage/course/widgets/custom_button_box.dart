import 'package:salebee/Screen/A_MenuPage/course/datas/category_json.dart';
import 'package:salebee/Screen/A_MenuPage/course/datas/courses_json.dart';
import 'package:salebee/Screen/A_MenuPage/course/datas/user_profile.dart';
import 'package:salebee/Screen/A_MenuPage/course/theme/colors.dart';
import 'package:salebee/Screen/A_MenuPage/course/theme/padding.dart';
import 'package:salebee/Screen/A_MenuPage/course/utils/contant.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/clipper.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_categories_button.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_category_card.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_course_card.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_heading.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_place_holder.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_promotion_card.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_search_field.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class CustomButtonBox extends StatelessWidget {
  const CustomButtonBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(17.5),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          color: textWhite,
        ),
      ),
    );
  }
}
