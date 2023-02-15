import 'package:flutter/material.dart';

import 'package:salebee/Model/getAllMyTaskModel.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/taskManager/theme/colors/light_colors.dart';
import 'package:salebee/Screen/A_MenuPage/Dashboard/taskManager/widgets/active_project_card.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/taskManager/widgets/task_column.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/taskManager/widgets/top_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/expense_graph.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/daily_work/calendar_page.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/utils.dart';


class DashBoard extends StatefulWidget {


  @override
  State<DashBoard> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<DashBoard> {
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
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          TopContainer(
                                            height: 70,
                                            width: width,

                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  TaskColumn(
                                                    icon: Icons.alarm,
                                                    iconBackgroundColor: LightColors.kRed,
                                                    title: 'Total Task',
                                                    subtitle: snapshot.data!.result!.length.toString() + " Tasks",
                                                  ),

                                                ]),
                                          ),


                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text("Completed Task Type"),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            children: [
                                              TaskColumn(

                                                icon: Icons.call,
                                                iconBackgroundColor: LightColors.kDarkYellow,
                                                title: 'Call',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 4 && element.taskType == "Call").length.toString() + " Tasks",
                                              ),
                                              SizedBox(width: 20.0),

                                              TaskColumn(
                                                icon: Icons.mail_outline,
                                                iconBackgroundColor: LightColors.kBlue,
                                                title: 'Mail',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 4 && element.taskType == "Mail").length.toString() + " Tasks",

                                              ),
                                              SizedBox(width: 20.0),

                                              TaskColumn(
                                                icon: Icons.location_on_outlined,
                                                iconBackgroundColor: LightColors.kBlue,
                                                title: 'Visit',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 4 && element.taskType == "Visit").length.toString() + " Tasks",

                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text("To-Do Task Type"),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            children: [
                                              TaskColumn(


                                                icon: Icons.phone,
                                                iconBackgroundColor: LightColors.kDarkYellow,
                                                title: 'Call',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 5 && element.taskType == "Call").length.toString() + " Tasks",

                                              ),
                                              SizedBox(width: 20.0),

                                              TaskColumn(
                                                icon: Icons.mail_outline,
                                                iconBackgroundColor: LightColors.kBlue,
                                                title: 'Mail',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 5 && element.taskType == "Mail").length.toString() + " Tasks",

                                              ),
                                              SizedBox(width: 20.0),

                                              TaskColumn(
                                                icon: Icons.location_on_outlined,
                                                iconBackgroundColor: LightColors.kBlue,
                                                title: 'Visit',
                                                subtitle: snapshot.data!.result!.where((element) =>  element.statusId == 5 && element.taskType == "Visit").length.toString() + " Tasks",

                                              ),
                                            ],
                                          ),



                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Week Wise Task Completion"),
                                    SizedBox(height: 10,),
                                    Card(child:  ExpenseGraphDesign(jan: snapshot.data!.result!.where((element) =>  element.statusId == 1).length,)),
                                    Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child:   Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          subheading('Work Status'),
                                          SizedBox(height: 5.0),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                height: 250,
                                                radiusss: 75,

                                                cardColor: LightColors.kGreen,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.statusId == 4).length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Completed Work',
                                                subtitle: snapshot.data!.result!.where((element) => element.statusId == 4).length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 75,
                                                cardColor: LightColors.kRed,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.statusId == 13 || element.statusId == 3 || element.statusId == 1).length * 100 / snapshot.data!.result!.length) / 100,
                                                height: 250,
                                                title: 'Should check',
                                                subtitle: snapshot.data!.result!.where((element) => element.statusId == 13 || element.statusId == 3 || element.statusId == 1).length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[

                                              ActiveProjectsCard(
                                                radiusss: 75,
                                                height: 250,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.statusId == 5).length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Pending work',
                                                subtitle: snapshot.data!.result!.where((element) => element.statusId == 5).length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 75,
                                                height: 250,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.statusId == 13 || element.statusId == 3 || element.statusId == 1 || element.statusId == 5).length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Work In Progress',
                                                subtitle:  snapshot.data!.result!.where((element) => element.statusId == 13 || element.statusId == 3 || element.statusId == 1 || element.statusId == 5).length.toString(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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





