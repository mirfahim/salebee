import 'package:flutter/material.dart';

import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Model/prospect/get_prospectList_by_id_model.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/theme/colors/light_colors.dart';
import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/active_project_card.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/task_column.dart';

import 'package:salebee/Screen/A_MenuPage/Dashboard/dashboardManager/widgets/top_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/expense_graph.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/daily_work/calendar_page.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/utils.dart';


class ProspectDashBoard extends StatefulWidget {


  @override
  State<ProspectDashBoard> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<ProspectDashBoard > {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TaskRepository taskRepository = TaskRepository();
  ProspectRepository prospectRepository = ProspectRepository();
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

            SizedBox(
              height: 10,
            ),
            FutureBuilder<GetAllProspectByIdtModel>(
              future: prospectRepository.getAllProspectListByUserIdController(),
              builder: (BuildContext context,
                  AsyncSnapshot<GetAllProspectByIdtModel> snapshot) {
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
                        height: MediaQuery.of(context).size.height * 1.8,
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
                                                    title: 'Total Prospect',
                                                    subtitle: snapshot.data!.result!.length.toString() + " Prospects",
                                                  ),

                                                ]),
                                          ),





                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Week Wise Task Completion"),
                                    SizedBox(height: 10,),
                                    Card(child:  ExpenseGraphDesign(jan: snapshot.data!.result!.where((element) =>  element.stage == 1).length,)),
                                    Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          subheading('Prospect Status'),
                                          SizedBox(height: 5.0),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kGreen,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "New prospect").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'New Propsect',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "New prospect").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kRed,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Invalid Number").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Invalid Number',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "Invalid Number").length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Couldn't Reach").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Could not reach',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "Couldn't Reach").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Initial Contact").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Initial Contact',
                                                subtitle:  snapshot.data!.result!.where((element) => element.stage == "Initial Contact").length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "On followup").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'On followup',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "On followup").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Visited").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Visited',
                                                subtitle:  snapshot.data!.result!.where((element) => element.stage == "Visited").length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Demo done").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Demo done',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "Demo done").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Lead Created").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Lead Created',
                                                subtitle:  snapshot.data!.result!.where((element) => element.stage == "Lead Created").length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Demo Account").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Demo Account',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "Demo Account").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Hot Leads").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Hot Leads',
                                                subtitle:  snapshot.data!.result!.where((element) => element.stage == "Hot Leads").length.toString(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kDarkYellow,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Already Client").length * 100 / snapshot.data!.result!.length) / 100,
                                                title: 'Already Client',
                                                subtitle: snapshot.data!.result!.where((element) => element.stage == "Already Client").length.toString(),
                                              ),
                                              SizedBox(width: 20.0),
                                              ActiveProjectsCard(
                                                radiusss: 40,
                                                height: 150,
                                                cardColor: LightColors.kBlue,
                                                loadingPercent: (snapshot.data!.result!.where((element) => element.stage == "Future prospect").length * 100 / snapshot.data!.result!.length) / 100,

                                                title: 'Future prospect',
                                                subtitle:  snapshot.data!.result!.where((element) => element.stage == "Future prospect").length.toString(),
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





