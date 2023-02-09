
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.prefixIcon,
    required this.labelText,
    this.controller,
    this.readOnlyField = false,
    this.isPassword = false,
    this.iconHeight = 17.0,
    this.maxLine = 1,
    this.height = 50.0,
    this.keyboardType,
    this.iconColor,
  }) : super(key: key);
  final String prefixIcon;
  final double iconHeight;
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnlyField;
  final int maxLine;
  final double height;
  final TextInputType? keyboardType;
  final Color? iconColor;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondary.withOpacity(0.25), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            // color: grey,
            alignment: Alignment.center,
            child: Container(
                child: SvgPicture.asset(
              assetImg + widget.prefixIcon,
              height: widget.iconHeight,
              color: widget.iconColor,
            )),
          ),
          SizedBox(width: miniSpacer),
          Flexible(
              child: TextField(
            onTap: () {},
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnlyField,
            obscureText: widget.isPassword,
            controller: widget.controller,
            maxLines: widget.maxLine,
            style: TextStyle(
              fontSize: 15.0,
              color: secondary,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: secondary,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: secondary.withOpacity(0.5),
                fontSize: 15.0,
                height: 1,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
