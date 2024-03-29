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

class CustomPersonCard extends StatelessWidget {
  const CustomPersonCard({
    Key? key,
    required this.image,
    required this.name,
    required this.course,
    required this.totalCourses,
    required this.totalStudents,
  }) : super(key: key);

  final String image;
  final String name;
  final String course;
  final String totalCourses;
  final String totalStudents;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      height: size.width * .3,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.width * .125,
            child: Row(
              children: [
                Container(
                  width: size.width * .125,
                  height: size.width * .125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 15.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: secondary,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        course,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalCourses + ' Courses',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
                Text(
                  totalStudents + ' Students',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
