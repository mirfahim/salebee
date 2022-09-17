import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salebee/Screen/Attendence_report/attendence_report.dart';
import 'package:salebee/Screen/Authentication/login_page.dart';
import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Screen/expense/expense_list.dart';
import 'package:salebee/Screen/leave/leave_front.dart';
import 'package:salebee/Screen/task/add_new_task.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/utils.dart';

Future drawer(BuildContext context){
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    builder: (context){
      //k
      return SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: size.height < 300 ? 2 : 0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [

                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: size.height < 300 ? 3 : 3,
                  child: Container(
                    // height: size.height,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          InkWell(
                            onTap: () {

                              Get.to(AttendenceReport());
                            },
                            child: Container(
                              decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.present_to_all,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Attendance Report',
                                      style: TextStyle(
                                          color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {

                              Get.to(ExpenseList());
                            },
                            child: Container(
                              decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.money,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Expense List',
                                      style: TextStyle(
                                          color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {

                              Get.to(Task());
                            },
                            child: Container(
                              decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.money,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Tasks',
                                      style: TextStyle(
                                          color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {

                              Get.to(LeaveFront());
                            },
                            child: Container(
                              decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.money,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Leave',
                                      style: TextStyle(
                                          color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 20,
                left: 15,
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      middleText: '',
                      title: 'Are you sure want to logout?',
                      confirm: InkWell(
                        onTap: () {
SharedPreff.to.prefss.remove("token");
SharedPreff.to.prefss.remove("loggedIN");
SharedPreff.to.prefss.remove("employeeID");
SharedPreff.to.prefss.remove("userNAME");
SharedPreff.to.prefss.remove("proLink");
Get.to(LoginPage());

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      cancel: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'cancel'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: primaryColor,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'logout'.tr,
                        style:
                        TextStyle(color: primaryColor, fontSize: 18),
                      )
                    ],
                  ),
                ))
          ],
        ),
      );
    },
  );
}