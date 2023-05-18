
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Screen/A_MenuPage/employee_list/employee_list.dart';
import 'package:salebee/Screen/A_MenuPage/file_storage/project.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/eye_front.dart';
import 'package:salebee/Screen/Attendence_report/attendence_report.dart';
import 'package:salebee/Screen/Prospect/prspect_front_tab.dart';
import 'package:salebee/Screen/expense/expense_list.dart';
import 'package:salebee/Screen/follow_up/follow_up_page.dart';
import 'package:salebee/Screen/lead/lead_view.dart';
import 'package:salebee/Screen/task/add_new_task.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/repository/add_task_repository.dart';

import 'package:salebee/utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _TeamFolderPageState();
}

class _TeamFolderPageState extends State<DashboardPage> {
  double availableScreenWidth = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    availableScreenWidth = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      backgroundColor: primaryColorLight,
      body: Column(children: [
        // Header Section
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          alignment: Alignment.bottomCenter,
          height: 170,
          decoration: BoxDecoration(color: Colors.blue.shade800),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  StaticData.name!,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  StaticData.designation,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(.1)),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(.1)),
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ]),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: (){
                  Get.to(Task());
                },
                child: RichText(
                    text:  TextSpan(
                        text: "Tasks ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        children: [

                          TextSpan(
                            text: "9/10Tasks",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          )
                        ])),
              ),
               GestureDetector(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => AddNewTask(),
                     ),
                   );
                 },
                 child: Text(
                  "Add Tasks",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
              ),
               ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              buildFileSizeChart("Completed", Colors.blue, .3),
              const SizedBox(
                width: 2,
              ),
              buildFileSizeChart("Pendings", Colors.red, .25),
              const SizedBox(
                width: 2,
              ),
              buildFileSizeChart("In Progress", Colors.yellow, .20),
              const SizedBox(
                width: 2,
              ),
              buildFileSizeChart("", Colors.grey[200], .23),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 20,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(25),
            children: [
              const Text(
                "CRM",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(ProspectFront());
    },
                      child: buildFileColumn('prospect', 'Prospect', '(4123)')),
                  SizedBox(
                    width: availableScreenWidth * .03,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(LeadView());
                    },
                 child:  buildFileColumn('lead', 'Leads', '(2122)'),),
                  SizedBox(
                    width: availableScreenWidth * .03,
                  ),
                  GestureDetector(
                    onTap: (){
                      //Get.to(FollowUpPage());
                    },
                  child : buildFileColumn('followup', 'Follow-Up', '(4)'),)
                ],
              ),
              const Divider(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Office ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   "Create new",
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.blue),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Folder List
              GestureDetector(
                onTap: (){
                  Get.to(AttendenceReport());
                },
                  child: buildProjectRow("Attendance", "prospect")),
          GestureDetector(
            onTap: (){
              Get.to(ExpenseList());
            },
            child: buildProjectRow("Expense","attendance"),),
          GestureDetector(
            onTap: (){
              Get.to(EmployeeList());
            },
            child:
            buildProjectRow("Employee","attendance"),),
          GestureDetector(
            onTap: (){
              Get.to(TheEyeFront());
            },
            child:
            buildProjectRow("The EYE","attendance"),)
            ],
          ),
        )
      ]),



    );
  }

  Widget buildProjectRow(String folderName, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 65,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Image.asset('images/Icons/$image.png',  fit: BoxFit.fill, height: 40,width: 40,),

            const SizedBox(
              width: 12,
            ),
            Text(
              folderName,
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
            color: Colors.grey,
          ),
        )
      ]),
    );
  }

  Column buildFileColumn(String image, String filename, String extension) {
    return Column(
      children: [
        Container(
          width: availableScreenWidth *.3,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(38),
          height:availableScreenWidth *.3,
          child: Image.asset('images/Icons/$image.png',  fit: BoxFit.fill, height: 40, width: 40,),
        ),
        const SizedBox(
          height: 15,
        ),
        RichText(
          text: TextSpan(
              text: filename,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: extension,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  Column buildFileSizeChart(
      String title, Color? color, double widthPercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: availableScreenWidth * widthPercentage,
          height: 4,
          color: color,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}