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

import 'custom_button_box.dart';

class CustomCourseFooter extends StatelessWidget {
  const CustomCourseFooter({
    Key? key,
    this.coursePrice = '',
    this.enrolled = false,
  }) : super(key: key);

  final String coursePrice;
  final bool enrolled;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return (enrolled)
        ? Container(
            width: size.width,
            height: 100.0,
            padding:  EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              color: textWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: CustomButtonBox(title: 'Continue Class'),
          )
        : Container(
            width: size.width,
            height: 100.0,
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding,
              top: appPadding,
            ),
            decoration: BoxDecoration(
              color: textWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Price',
                        style: TextStyle(fontSize: 12.0, color: grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        coursePrice,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: miniSpacer + 5),
                Flexible(child: CustomButtonBox(title: 'Enroll Now')),
              ],
            ),
          );
  }
}
