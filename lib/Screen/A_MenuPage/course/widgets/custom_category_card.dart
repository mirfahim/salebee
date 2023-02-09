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
import 'package:flutter_svg/svg.dart';

class CustomCategoryCard extends StatelessWidget {
  const CustomCategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(HomePageCategoryJson.length, (index) {
          
         
          return GestureDetector(
            onTap: () {
            
            },
            child: Container(
              height: size.width * .25,
              width: size.width * .25,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: textBlack.withOpacity(0.05),
                    blurRadius: 15.0,
                    offset: Offset(0, 7),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Container(
                      child: SvgPicture.asset(
                        HomePageCategoryJson[index]['icon'],
                        color: textWhite,
                        width: 15.0,
                      ),
                    ),
                  ),
                  Text(
                    HomePageCategoryJson[index]['title'],
                    style: TextStyle(
                      color: secondary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 0.0),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
