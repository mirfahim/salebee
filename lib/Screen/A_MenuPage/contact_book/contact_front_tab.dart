// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:salebee/Data/static_data.dart';
// import 'package:salebee/Screen/A_MenuPage/contact_book/contact_book.dart';
// import 'package:salebee/Screen/A_MenuPage/contact_book/contact_controller.dart';
// import 'package:salebee/Screen/A_MenuPage/contact_book/employee_contact.dart';
// import 'package:salebee/Screen/A_MenuPage/contact_book/prospect_conatct.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/daily_work/calendar_page.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/live_tracking_location_by_emp.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/follow_up_activity.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/map_for_all/map_view.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/markrting_activity.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/visit/person_visit_log_tab.dart';
// import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/live_tracking_screen.dart';
// import 'package:salebee/Screen/Prospect/individual_prospect.dart';
// import 'package:salebee/Screen/Prospect/organization_prospect.dart';
// import 'package:salebee/utils.dart';
// import 'package:salebee/Screen/leave/granted.dart';
// import 'package:salebee/Screen/leave/applied.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:ui' as ui;
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:salebee/utils.dart';
//
//
//
// class ConatctBookFrontTab extends GetView<MobileRechargeController> {
//   const ConatctBookFrontTab({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//
//
//           title:  Text('Contact Book',style: TextStyle(
//               color: appBarHeader,fontSize: 24
//           ),),
//           leading: IconButton(
//             onPressed: (){
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
//           ),
//           backgroundColor: primaryColorLight,
//           elevation: 0,
//           centerTitle: true,
//
//         ),
//         body: Container(
//           color: primaryColorLight,
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 12,
//                         child: TabBar(
//                           indicatorColor: darkBlue,
//                           labelColor: darkBlue,
//                           unselectedLabelColor: tabBarUnSelectedColor,
//                           unselectedLabelStyle: const TextStyle(
//                               fontSize: 12
//                           ),
//                           labelStyle: const TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.w600
//                           ),
//                           isScrollable: true,
//                           tabs: const [
//                             Tab(
//                               text: 'Phone Contact',
//                             ),
//                             Tab(
//                               text: 'Employee',
//                             ),
//                             Tab(
//                               text: 'Prospect',
//                             ),
//
//
//                           ],
//                         ),
//                       ),
//                       Expanded(child: Container(
//
//                       ))
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           child: MobileRechargeView(),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           child: EmployeeListConatct(),
//                         ),
//
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           child: ProspectContact(),
//                         ),
//
//                       ]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
