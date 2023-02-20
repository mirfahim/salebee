import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/A_MenuPage/contact_book/contact_book.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/home_page.dart';
import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/screens/task_dashbrd.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/dashboardManager/screens/dashbrd_front.dart';
import 'package:salebee/Screen/Charts/funnel_chart.dart';
import 'package:salebee/Screen/A_MenuPage/SendEmail/send_email_pagr.dart';
import 'package:salebee/Screen/A_MenuPage/chat/chat_screen.dart';
import 'package:salebee/Screen/A_MenuPage/course/root_app.dart';
import 'package:salebee/Screen/A_MenuPage/employee_list/employee_list.dart';
import 'package:salebee/Screen/A_MenuPage/marketing/marketing_page.dart';
import 'package:salebee/Screen/A_MenuPage/reminder/reminder.dart';
import 'package:salebee/Screen/A_MenuPage/route_planner/route_plan.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/eye_front.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/live_tracking_screen.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/wallet/wallet_view.dart';
import 'package:salebee/Screen/A_MenuPage/track_order/track_order_page.dart';
import 'package:salebee/Screen/A_MenuPage/web_view_test.dart';
import 'package:salebee/Screen/calendar/calendar.dart';

import 'package:salebee/Screen/follow_up/follow_up_page.dart';
import 'package:salebee/Screen/lead/lead_view.dart';
import 'package:salebee/Screen/leave/leave_front.dart';
import 'package:salebee/Screen/schedule/schedule_home.dart';
import 'package:salebee/Utils/ROute/app_pages.dart';
import 'package:salebee/bottomNav.dart';
import 'package:salebee/utils.dart';

import '../../Utils/my_colors.dart';
import '../notification/local_notification.dart';


class MenusScreen extends StatefulWidget {
  const MenusScreen({Key? key}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColorLight,
        appBar: AppBar(
          backgroundColor: primaryColorLight,
          title: Text(
            "All Menu",
            style: TextStyle(color: Colors.black54),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(DashBrdFront());
                    // Get.to(WebViewClass());
                     // Get.to(DashBoardPage());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(

                                  image: AssetImage(

                                    'images/Icons/dash2.png',
                                  )),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Center(child: const Text("Dashboard")),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(TheEyeFront());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/Icons/eye1.png',
                                  )),
                            ),
                          ),
                          Center(child: const Text('The Eye')),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                              'images/Icons/list1.png',
                            )),
                          ),
                        ),
                        Center(child: const Text('Prospect List')),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(EmployeeList());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                'images/Icons/list3.png',
                              )),
                            ),
                          ),
                          Center(child: const Text('Employee List')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(LeaveFront());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/holiday.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Leave')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(ReminderList());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/belluser.png', )

                              ),
                            ),

                          ),
                          Center(child:  Text('Reminder', style: TextStyle(color: Colors.black),)),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Get.to(ScheduleHomePage());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/todo1.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('To Do')),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Get.to(Ewallet());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/wallet.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Wallet')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                     Get.to(CourseApp());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/course.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Learning')),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Get.to(TrackOrderPage());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/track.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Track Order')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(MarketingPage());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/marketing.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Marketing')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(EmailSender());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/mail.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Send Email')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(ChatPage());
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/chat.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Chat')),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.ContactFrontTab);
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(  'images/Icons/contact.png',)

                              ),
                            ),

                          ),
                          Center(child: const Text('Contact Book')),
                        ],
                      ),
                    ),
                  ),


                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Setting')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //
                  //   color: Colors.teal[100],
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 12,
                  //         backgroundImage:
                  //         AssetImage(
                  //           'images/dash.png',
                  //         ),
                  //       ),
                  //       Center(child: const Text('Monthly Report')),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}
