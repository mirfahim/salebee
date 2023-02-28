import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:salebee/Model/getAllMyTaskModel.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/theme/colors/light_colors.dart';
import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/active_project_card.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/task_column.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/top_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/dashboardManager/widgets/fl_chart_screen.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/expense_graph.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/daily_work/calendar_page.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/utils.dart';


class SaleDashBoard extends StatefulWidget {


  @override
  State<SaleDashBoard> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<SaleDashBoard> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TaskRepository taskRepository = TaskRepository();
  TextEditingController searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColorLight,


      body:

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [

            SizedBox(
              height: 10,
            ),
            FutureBuilder<GetAllMyTaskModel>(
              future: taskRepository.getMyTaskController(),
              builder: (BuildContext context,
                  AsyncSnapshot<GetAllMyTaskModel> snapshot) {
                if (snapshot.data == null) {
                  print("no data found");
                } else {}

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("waiting");
                  default:
                    if (snapshot.hasError)
                      return Center(child: Text('No Data Found'));
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 1.3,
                        child:  Column(
                          children: <Widget>[

                            Expanded(
                              child: SingleChildScrollView(
                                child: LineChartSample1(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                }
              },
            ),
          ]),
        ),
      ),



    );
  }




}





