import 'package:flutter/material.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Screen/edit_profile.dart';
import 'package:salebee/Screen/expense/aproved.dart';
import 'package:salebee/Screen/expense/expense_list.dart';
import 'package:salebee/Screen/expense/other_expense.dart';
import 'package:salebee/Screen/expense/transport.dart';
import 'package:salebee/Screen/notification/notification.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/Screen/test_screen.dart';
import 'package:salebee/Service/sharedPref_service.dart';

import '../../Utils/StringsConst.dart';
import '../../utils.dart';
import 'package:get/get.dart';

import '../Attendence_report/attendence_report.dart';
import '../leave/leave_front.dart';
import '../test.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget circleRow(size, option, top, left) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: primaryColor),
            // transform: Matrix4.translationValues(x, y, 0.0),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
              // transform: Matrix4.translationValues(x, y, 0.0),
              child: Text(
            '$option',
            style: const TextStyle(color: Colors.grey),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("sub domain is ${SharedPreff.to.prefss.get("subDomain")} and my url is ${StringsConst.BASEURL}");
    Size size = MediaQuery.of(context).size;
    print(size.height);
    if (size.height < 650) {
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        StaticData.name != null ?    Text(
                          StaticData.name!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ) : Text(
                          "No name",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                       StaticData.employeeID != null ? Text(
                          'ID: ${ StaticData.employeeID}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ) :  Text(
                         'ID: ',
                         style: TextStyle(fontSize: 16, color: Colors.grey),
                       )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(EditProfile());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150)),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: darkBlue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(
                            -(size.width / 2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        transform: Matrix4.translationValues(
                            -(size.width / 3.8), (size.height / 5.5), 0.0),
                        child:  StaticData.proLink!.startsWith(".", 0)
                            ? CircleAvatar(
                          radius: 140,
                          backgroundImage:NetworkImage("${StringsConst.MAINURL}" + "${StaticData.proLink!.replaceAll("../..", "")}"),
                        ) :  CircleAvatar(
                          radius: 140,
                          backgroundImage:  NetworkImage(StaticData.proLink!),
                        ),
                      ),
                      Positioned(
                        top: (size.height / 13),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(LeaveFront());
                            },
                            child: circleRow(size, 'Leave', 20.0, 50.0)),
                      ),

                      Positioned(
                          top: (size.height / 6.0),
                          left: (size.width / 2.5),
                          child: InkWell(
                              onTap: () {
                                Get.to(AttendenceReport());
                              },
                              child: circleRow(size, 'Attendance',
                                  (size.width / 2.7), (size.height / 8)))),
                      Positioned(
                        top: (size.height / 3.1),
                        left: (size.width / 1.9),
                        child: InkWell(
                          onTap: () {
                            Get.to(Task());
                          },
                          child: circleRow(size, 'Tasks', 240.0, 210.0),
                        ),
                      ),

                      Positioned(
                          top: (size.height / 2.1),
                          left: (size.width / 2.3),
                          child: InkWell(
                              onTap: () {
                                Get.to(ExpenseList());
                              },
                              child: circleRow(size, 'Expenses',
                                  (size.width / 2.5), (size.height / 2)))),

                      Positioned(
                        top: (size.height / 1.74),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(NotificationPage());
                            },
                            child: circleRow(size, 'Notice', (size.width / 12),
                                (size.height / 1.74))),
                      ),
                      // circleRow(size,'E', (size.width /12), (size.height /24),),
                      //
                      // circleRow(size,'D',(size.width /2.5),(size.height /8)),
                      //
                      // circleRow(size,'C',(size.width /1.9),(size.height /3.3)),
                      //
                      // circleRow(size,'B',(size.width /2.5),(size.height /2)),
                      //
                      // circleRow(size,'A',(size.width /12),(size.height /1.7)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: darkBlue,
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(color: darkBlue),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdsPage());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: darkBlue,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(color: darkBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else if (size.height < 800) {
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        StaticData.name != null ?    Text(
                          StaticData.name!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ) : Text(
                          "No name",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        StaticData.employeeID != null ? Text(
                          'ID: ${ StaticData.employeeID}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ) :  Text(
                          'ID: ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(EditProfile());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150)),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: darkBlue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(
                            -(size.width / 2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        transform: Matrix4.translationValues(
                            -(size.width / 3.8), (size.height / 5.5), 0.0),
                        child:  StaticData.proLink!.startsWith(".", 0)
                            ? CircleAvatar(
                          radius: 140,
                          backgroundImage:NetworkImage("${StringsConst.MAINURL}" + "${StaticData.proLink!.replaceAll("../..", "")}"),
                        ) :  CircleAvatar(
                          radius: 140,
                          backgroundImage:  NetworkImage(StaticData.proLink!),
                        ),
                      ),
                      //https://app.salebee.net/UploadedFiles/app/Employee/79/Image/637990290881445074_Kamal%20Photo.jpg -- working
                      //https://app.salebee.net/UploadedFiles/app/Employee/79/Image/637990290881445074_Kamal%20Photo.jpg
                      Positioned(
                        top: (size.height / 11),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(LeaveFront());
                            },
                            child: circleRow(size, 'Leave', 20.0, 50.0)),
                      ),
                      Positioned(
                          top: (size.height / 6.0),
                          left: (size.width / 2.5),
                          child: InkWell(
                              onTap: () {
                                Get.to(AttendenceReport());
                              },
                              child: circleRow(size, 'Attendance',
                                  (size.width / 2.7), (size.height / 8)))),
                      Positioned(
                        top: (size.height / 3.1),
                        left: (size.width / 1.9),
                        child: InkWell(
                          onTap: () {
                            Get.to(Task());
                          },
                          child: circleRow(size, 'Tasks', 240.0, 210.0),
                        ),
                      ),
                      Positioned(
                          top: (size.height / 2.1),
                          left: (size.width / 2.3),
                          child: InkWell(
                              onTap: () {
                                Get.to(ExpenseList());
                              },
                              child: circleRow(size, 'Expenses',
                                  (size.width / 2.5), (size.height / 2)))),
                      Positioned(
                        top: (size.height / 1.74),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(NotificationPage());
                            },
                            child: circleRow(size, 'Notice', (size.width / 12),
                                (size.height / 1.74))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: darkBlue,
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(color: darkBlue),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdsPage());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: darkBlue,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(color: darkBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else if (size.height < 850) {
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        StaticData.name != null ?    Text(
                          StaticData.name!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ) : Text(
                          "No name",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        StaticData.employeeID != null ? Text(
                          'ID: ${ StaticData.employeeID}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ) :  Text(
                          'ID: ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(EditProfile());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150)),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: darkBlue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(
                            -(size.width / 2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        transform: Matrix4.translationValues(
                            -(size.width / 3.8), (size.height / 5.5), 0.0),
                        child:  StaticData.proLink!.startsWith(".", 0)
                            ? CircleAvatar(
                          radius: 140,
                          backgroundImage:NetworkImage("${StringsConst.MAINURL}" + "${StaticData.proLink!.replaceAll("../..", "")}"),
                        ) :  CircleAvatar(
                          radius: 140,
                          backgroundImage:  NetworkImage(StaticData.proLink!),
                        ),
                      ),
                      Positioned(
                        top: (size.height / 9.5),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to( LeaveFront());
                            },
                            child: circleRow(size, 'Leave', 20.0, 50.0)),
                      ),
                      Positioned(
                          top: (size.height / 5.0),
                          left: (size.width / 2.3),
                          child: InkWell(
                              onTap: () {
                                Get.to(AttendenceReport());
                              },
                              child: circleRow(size, 'Attendance',
                                  (size.width / 2.7), (size.height / 8)))),
                      Positioned(
                        top: (size.height / 2.8),
                        left: (size.width / 1.8),
                        child: InkWell(
                          onTap: () {
                            Get.to(Task());
                          },
                          child: circleRow(size, 'Tasks', 240.0, 210.0),
                        ),
                      ),
                      Positioned(
                          top: (size.height / 2.05),
                          left: (size.width / 2.34),
                          child: InkWell(
                              onTap: () {
                                Get.to(ExpenseList());
                              },
                              child: circleRow(size, 'Expenses',
                                  (size.width / 2.5), (size.height / 2)))),
                      Positioned(
                        top: (size.height / 1.80),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(NotificationPage());
                            },
                            child: circleRow(size, 'Notice', (size.width / 12),
                                (size.height / 1.74))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: darkBlue,
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(color: darkBlue),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdsPage());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: darkBlue,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(color: darkBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );



    } else if (size.height < 900) {
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        StaticData.name != null ?    Text(
                          StaticData.name!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ) : Text(
                          "No name",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        StaticData.employeeID != null ? Text(
                          'ID: ${ StaticData.employeeID}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ) :  Text(
                          'ID: ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(EditProfile());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150)),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: darkBlue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(
                            -(size.width / 2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        transform: Matrix4.translationValues(
                            -(size.width / 3.8), (size.height / 5.5), 0.0),
                        child:  StaticData.proLink!.startsWith(".", 0)
                            ? CircleAvatar(
                          radius: 140,
                          backgroundImage:NetworkImage("${StringsConst.MAINURL}" + "${StaticData.proLink!.replaceAll("../..", "")}"),
                        ) :  CircleAvatar(
                          radius: 140,
                          backgroundImage:  NetworkImage(StaticData.proLink!),
                        ),
                      ),
                      Positioned(
                        top: (size.height / 9.5),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(LeaveFront());
                            },
                            child: circleRow(size, 'Leave', 20.0, 50.0)),
                      ),
                      Positioned(
                          top: (size.height / 5.0),
                          left: (size.width / 2.3),
                          child: InkWell(
                              onTap: () {
                                Get.to(AttendenceReport());
                              },
                              child: circleRow(size, 'Attendance',
                                  (size.width / 2.7), (size.height / 8)))),
                      Positioned(
                        top: (size.height / 2.8),
                        left: (size.width / 1.8),
                        child: InkWell(
                          onTap: () {
                            Get.to(Task());
                          },
                          child: circleRow(size, 'Tasks', 240.0, 210.0),
                        ),
                      ),
                      Positioned(
                          top: (size.height / 1.9),
                          left: (size.width / 2.34),
                          child: InkWell(
                              onTap: () {
                                Get.to(ExpenseList());
                              },
                              child: circleRow(size, 'Expenses',
                                  (size.width / 2.5), (size.height / 2)))),
                      Positioned(
                        top: (size.height / 1.65),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(NotificationPage());
                            },
                            child: circleRow(size, 'Notice', (size.width / 12),
                                (size.height / 1.74))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: darkBlue,
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(color: darkBlue),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdsPage());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: darkBlue,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(color: darkBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );



    } else if (size.height >= 1200) {
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rayhan Uddin12',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '01502020222',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150)),
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: darkBlue,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(
                            -(size.width / 2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        transform: Matrix4.translationValues(
                            -(size.width / 3.8), (size.height / 5.5), 0.0),
                        child:  StaticData.proLink!.startsWith(".", 0)
                            ? CircleAvatar(
                          radius: 140,
                          backgroundImage:NetworkImage("${StringsConst.MAINURL}" + "${StaticData.proLink!.replaceAll("../..", "")}"),
                        ) :  CircleAvatar(
                          radius: 140,
                          backgroundImage:  NetworkImage(StaticData.proLink!),
                        ),
                      ),
                      Positioned(
                        top: (size.height / 22),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(LeaveFront());
                            },
                            child: circleRow(size, 'Leave', (size.width / 4),
                                (size.height / 6))),
                      ),
                      Positioned(
                          top: (size.height / 6),
                          left: (size.width / 2.2),
                          child: circleRow(size, 'Attendance',
                              (size.width / 2.7), (size.height / 8))),
                      Positioned(
                        top: (size.height / 2.6),
                        left: (size.width / 1.75),
                        child: InkWell(
                          onTap: () {
                            Get.to(OtherExpense());
                          },
                          child: circleRow(size, 'Tasks', 240.0, 210.0),
                        ),
                      ),
                      Positioned(
                          top: (size.height / 1.7),
                          left: (size.width / 2.3),
                          child: InkWell(
                              onTap: () {
                                Get.to(NotificationPage());
                              },
                              child: circleRow(size, 'Expenses',
                                  (size.width / 2.5), (size.height / 2)))),
                      Positioned(
                        top: (size.height / 1.45),
                        left: (size.width / 8),
                        child: InkWell(
                            onTap: () {
                              Get.to(AttendenceReport());
                            },
                            child: circleRow(size, 'Notice', (size.width / 12),
                                (size.height / 1.74))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: darkBlue,
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(color: darkBlue),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(AdsPage());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: darkBlue,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(color: darkBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
