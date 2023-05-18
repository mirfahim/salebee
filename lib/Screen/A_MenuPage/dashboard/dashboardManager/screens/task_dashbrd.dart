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
  List<String> yearList = <String>[DateTime.now().year.toString(), DateTime(DateTime.now().year-1).toString().substring(0,4), DateTime(DateTime.now().year-2).toString().substring(0,4) ];


  int yearSelection = int.parse(DateTime.now().toString().substring(0,4));



  int monthSelection = int.parse(DateTime.now().toString().substring(5, 7));
  int daySelection = int.parse(DateTime.now().toString().substring(8, 10));
  List<String> tabs = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<int> dayTab = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];
  String dropdownValue = DateTime.now().year.toString();
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
            DefaultTabController(
              initialIndex: monthSelection - 1,
              length: 12,
              child: Container(
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 70,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          icon: Icon(Icons
                              .arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors
                                  .deepPurple),
                          underline:
                          Container(
                            height: 2,
                            color: Colors
                                .transparent,
                          ),

                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                              yearSelection = int.parse(dropdownValue);
                            });
                          },
                          items: yearList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width - 150,

                      child: DefaultTabController(
                        initialIndex: monthSelection -1,
                        length: 12,
                        child: TabBar(


                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColorSecond.withOpacity(.5)),
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,


                          onTap: (index){
                            setState((){
                              monthSelection = index+1;
                            });

                          },
                          tabs: tabs
                              .map((tab) => Tab(
                            icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(tab,style: TextStyle(fontSize: 12),),
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: DefaultTabController(
                initialIndex: daySelection - 1,
                length: 31,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.black38,
                      labelColor: Colors.black,
                      onTap: (index) {
                        setState(() {
                          daySelection = index + 1;
                        });
                      },
                      tabs: dayTab
                          .map((tab) => Tab(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tab.toString(),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
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





