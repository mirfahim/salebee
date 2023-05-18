import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Provider/language_provider/language_provider.dart';
import 'package:salebee/Screen/A_MenuPage/chat/core_chat/main.dart';
import 'package:badges/badges.dart' as badges;
import 'package:salebee/Screen/A_MenuPage/chat/notification.dart';
import 'package:salebee/Screen/A_MenuPage/contact_book/contact_book.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/home_page.dart';
import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/screens/task_dashbrd.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/dashboardManager/screens/dashbrd_front.dart';
import 'package:salebee/Screen/A_MenuPage/facebook/facebook_app_event.dart';
import 'package:salebee/Screen/A_MenuPage/file_storage/team_folder.dart';
import 'package:salebee/Screen/A_MenuPage/menupage_controller.dart';
import 'package:salebee/Screen/A_MenuPage/quize_app/quize_screen.dart';
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


class MenusScreen extends GetView<MenuPageController> {

  const MenusScreen({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Consumer<LangProvider>(
      builder: (context, provider, widget) {
        return Scaffold(
            backgroundColor: primaryColorLight,
            appBar: AppBar(
              backgroundColor: primaryColorLight,
              title:provider.bangLang == true ?  Text(
                "মেনু",
                style: TextStyle(color: Colors.black54),
              ) : Obx(
                () {
                  return Text(
                        controller.appbarName.value,
                        style: TextStyle(color: Colors.black54),
                      );
                }
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
                              Center(child: provider.bangLang ==true ? Text("ড্যাশবোর্ড"): Text("Dashboard")),
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
                              Center(child:  provider.bangLang ==true ? Text('চোখ'): Text('The Eye')),
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
                            Center(child:  provider.bangLang ==true ? Text('প্রসপেক্ট তালিকা'): Text('Prospect List')),
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
                              Center(child: provider.bangLang ==true ? Text('কলিগ তালিকা'):
                              Text('Employee List')),
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
                              Center(child: provider.bangLang ==true ?Text('লিভ') :
                              Text('Leave')),
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
                              Center(child: provider.bangLang ==true ?Text('রিমাইন্ডার') :
                              Text('Reminder', style: TextStyle(color: Colors.black),)),
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
                              Center(child: provider.bangLang ==true ? Text('আমার করণীয়'):
                              Text('My To-Do')),
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
                              Center(child: provider.bangLang ==true ?Text('ওয়ালেট') :
                              Text('Wallet')),
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
                              Center(child: provider.bangLang ==true ?Text('শিক্ষা') :
                              Text('Learning')),
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
                              Center(child: provider.bangLang ==true ? Text('ট্র্যাক অর্ডার'):
                              Text('Track Order')),
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
                              Center(child: provider.bangLang ==true ?Text('মার্কেটিং') :
                              Text('Marketing')),
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
                              Center(child: provider.bangLang ==true ?
                              Text('ইমেইল'): Text('Send Email')),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(MyAppChat());
                        },
                        child: Card(
                          elevation: 10,
                          color: Colors.teal[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              badges.Badge(
                                 badgeContent: Text("${StaticData.todaysTask}"),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: Colors.greenAccent,
                                ),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(  'images/Icons/chat.png',)

                                    ),
                                  ),

                                ),
                              ),
                              Center(child: provider.bangLang ==true ? Text('চ্যাট'): Text('Chat')),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                         // Get.toNamed(Routes.ContactFrontTab);
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
                              Center(child: provider.bangLang ==true ?
                              Text(' কন্টাক্ট বুক') : Text('Contact Book')),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(FacebookAppEvent());
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
                                      image: AssetImage(  'images/Icons/facebook.png',)

                                  ),
                                ),

                              ),
                              Center(child: provider.bangLang ==true ?
                              Text('ফেসবুক'): Text('Facebook')),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(QuizScreen());
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
                                      image: AssetImage(  'images/Icons/questions.png',)

                                  ),
                                ),

                              ),
                              Center(child: provider.bangLang ==true ?
                              Text('ক্যুইজ'): Text('Quiz')),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(TeamFolderPage());
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
                                      image: AssetImage(  'images/Icons/questions.png',)

                                  ),
                                ),

                              ),
                              Center(child: provider.bangLang ==true ?
                              Text('ফাইল স্টোরেজ'): Text('File Storage')),
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
    );
  }
}
