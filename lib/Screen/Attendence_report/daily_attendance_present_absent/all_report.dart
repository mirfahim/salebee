import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/attendance/getAllEmployeeAttendance.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/Attendence_report/map_for_attendance.dart';
import 'package:salebee/Utils/StringsConst.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/static_data.dart';
import '../../../Model/get_attendance_model.dart';
import '../../../repository/attendance_repository.dart';
import '../../../utils.dart';
import '../check_in_out.dart';

///import 'package:my_app/globals.dart' as globals;

class AllReport extends StatefulWidget {
  @override
  State<AllReport> createState() => _ReportState();
}

class _ReportState extends State<AllReport> {
  final summaryOpen = false.obs;
  AttendanceRepository attendanceRepository = AttendanceRepository();
  GetAttendanceDataModel getAttendanceDataModel = GetAttendanceDataModel();
  //TabController _tabController;
  List listData = [];
  String totalPresent = "";
  String totalAbesent = "";
  int workingDays = 0;
  int onTime = 0;
  int late = 0;
  int leftEarly = 0;
  int onLeave = 0;
  int absent = 0;
  int monthSelection = int.parse(DateTime.now().toString().substring(5, 7));
  int daySelection = int.parse(DateTime.now().toString().substring(8, 10));
  int yearSelection = int.parse(DateTime.now().toString().substring(0,4));
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
  bool todayPresent = true;
  late AbsentModel absentModel ;
  List<AbsentModel> employeeID = [];
  List<AbsentModel> absentList = [];
  List<AbsentModel> presentID = [];

  //AttendanceRepository attendanceRepository = AttendanceRepository();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    absentList.clear();
    presentID.clear();
    employeeID.clear();
   // getting attendance of a employee bty date and adding emp name and id in presentID list
    // So I have a list where I have data of a employee present of a day.
    try {
      try {
        attendanceRepository
            .getAllEmployeeAttendanceController(StaticData.employeeID!, DateTime(DateTime.now().year,  monthSelection,   daySelection,))
            .then((value) {
          value.result!.forEach((element) {
            presentID.add(AbsentModel(name: element.employeeName!, id: element.employeeId!));
          });
          // getting all employee list
          // making a list of employeeID where I have data of all employee
          // So now I have two list of presentID and employeeID where I have to compare for getting a absent list.
          attendanceRepository.getAllEmployeeList().then((value) {
            value.results!.forEach((element) {
              employeeID.add(AbsentModel(name: element.employeeName!, id: element.employeeId!,
                designation: element.designationObj!.designationName!,
                num: element.phoneNumbers,
              imagePath:  element.profilePicturePath));
            });
            // _tabController = new TabController(vsync: this, length: tabs.length);
          }).then((value) {
            print("my total employee list is ${employeeID.length} and my total present employee today os ${presentID.length}");

            absentList =  employeeID.where((item) => !presentID.contains(item)).toList();
          });


        });
      } catch (e, s) {
        print(s);
      }
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: primaryColorLight,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DefaultTabController(
                initialIndex: monthSelection - 1,
                length: 12,
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      child: TabBar(
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColorSecond.withOpacity(.5)),
                        isScrollable: true,
                        indicatorColor: Colors.orangeAccent,
                        labelColor: Colors.black54,
                        onTap: (index) {
                          setState(() {
                            monthSelection = index + 1;
                          });
                        },
                        tabs: tabs
                            .map((tab) => Tab(
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(tab),
                                  ),
                                ))
                            .toList(),
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
                      height: 20,
                    ),
                    Container(
                      width: 310,
                      child: ToggleSwitch(
                        minHeight: 30,
                        minWidth: 150,
                        initialLabelIndex: todayPresent == true ? 0 : 1,
                        activeBgColor: [Colors.lightBlue],
                        totalSwitches: 2,
                        inactiveBgColor: Colors.white,
                        labels: ['Present($totalPresent)', 'Absent($totalAbesent)'],
                        onToggle: (index) {
                          print('switched to: $index');
                          if (index == 0) {
                            setState(() {
                              todayPresent = true;
                            });
                          } else {
                            setState(() {
                              todayPresent = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    todayPresent == true
                        ? Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Check IN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'Check Out',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'Working Hour',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )),
                                ),
                                FutureBuilder<GetAllEmployeeAttendance>(
                                    future: attendanceRepository
                                        .getAllEmployeeAttendanceController(
                                            StaticData.employeeID!, DateTime(2023,  monthSelection,   daySelection,)),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<GetAllEmployeeAttendance>
                                            snapshot) {
                                      if (snapshot.data == null) {
                                        print("my data is eror ");
                                      } else {

                                          totalPresent = snapshot.data!.result!.length.toString();





                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return Center(
                                              child: LoadingAnimationWidget
                                                  .twistingDots(
                                            leftDotColor:
                                                const Color(0xFF8686E3),
                                            rightDotColor:
                                                const Color(0xFFEA3799),
                                            size: 100,
                                          ));
                                        default:
                                          if (snapshot.hasError)
                                            return Center(
                                                child: Text('No Data Found'));
                                          if (snapshot.data == null) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  350,
                                              child: ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.result!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot
                                                        .data!.result![index];
                                                    print(
                                                        "my month selection is length ++ ${snapshot.data!.result!.length} and month ${data.logTimeIn.toString().substring(5, 7)}");
                                                    final hours = DateTime.parse(
                                                            data.logTimeOut ??
                                                                "2035-09-13T21:06:40.32")
                                                        .difference(
                                                            data.logTimeIn!)
                                                        .inHours;
                                                    final minutes =
                                                        DateTime.parse(data
                                                                    .logTimeOut ??
                                                                "2035-09-13T21:06:40.32")
                                                            .difference(
                                                                data.logTimeIn!)
                                                            .inMinutes;
                                                    final totalWorkingHours =
                                                        '$hours.${(minutes - (hours * 60))}';
                                                    if (monthSelection ==
                                                            int.parse(data
                                                                .logTimeIn
                                                                .toString()
                                                                .substring(
                                                                    5, 7)) &&
                                                        daySelection ==
                                                            int.parse(data
                                                                .logTimeIn
                                                                .toString()
                                                                .substring(
                                                                    8, 10)) && yearSelection ==  int.parse(data.logTimeIn.toString().substring(0, 4))) {
                                                      return Card(
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          primaryColorSecond,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  width: 100,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          data.employeeName!,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  )),
                                                              Container(
                                                                  width: 80,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.logTimeIn!),
                                                                        style: TextStyle(
                                                                            color: 10 > int.parse(DateFormat('HH:mm:ss').format(data.logTimeIn!).substring(0, 2))
                                                                                ? Colors.grey
                                                                                : Colors.red,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      InkWell(
                                                                        onTap: (){
                                                                          Get.to(AttendanceMapScreen(lat: data.latitude, lon: data.longitude, location: data.locationDescription, time: data.logTimeIn,));
                                                                        },

                                                                        child: Text(
                                                                          data.locationDescription
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color:
                                                                                  primaryColor,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 8),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                  width: 80,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      data.logTimeOut ==
                                                                              null
                                                                          ? Text(
                                                                              "",
                                                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                                            )
                                                                          : Text(
                                                                              DateFormat.jm().format(DateTime.parse(data.logTimeOut)) ?? "",
                                                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                                            ),
                                                                      data.locationDescriptionOut ==
                                                                              null
                                                                          ? Text(
                                                                              "No Data",
                                                                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 8),
                                                                            )
                                                                          : InkWell(
                                                                        onTap:(){
                                                                          Get.to(AttendanceMapScreen(lat:  data.latitudeOut, lon: data.longitudeOut, location: data.locationDescriptionOut, time: DateTime.parse(data.logTimeOut) ,));

                                                                        },
                                                                            child: Text(
                                                                                data.locationDescriptionOut.toString(),
                                                                                style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 8),
                                                                              ),
                                                                          )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                width: 80,
                                                                child: totalWorkingHours ==
                                                                        null
                                                                    ? Text(
                                                                        "No Data",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w600),
                                                                      )
                                                                    : double.parse(totalWorkingHours) >
                                                                            18.00
                                                                        ? Text(
                                                                            "Did not check out",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                                          )
                                                                        : Text(
                                                                            totalWorkingHours.toString() +
                                                                                " hrs",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                                          ),
                                                              ),
                                                            ]),
                                                      );
                                                    }

                                                    return Container();
                                                  }),
                                            );
                                          }
                                      }
                                    }),
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Designation',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'On Leave',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        'Contact',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )),
                                ),
                                FutureBuilder<AllEmployeeListModel>(
                                    future: attendanceRepository
                                        .getAllEmployeeList(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<AllEmployeeListModel>
                                            snapshot) {
                                      if (snapshot.data == null) {
                                        print("my data is eror ");
                                      } else {
                                        print("present list in future builder ${presentID.length} ");
                                        print("employee list in future builder ${employeeID.length} ");
                                        print("absent list in future builder ${absentList.length} ");
                                        totalAbesent = absentList.length.toString();

                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return Center(
                                              child: LoadingAnimationWidget
                                                  .twistingDots(
                                            leftDotColor:
                                                const Color(0xFF8686E3),
                                            rightDotColor:
                                                const Color(0xFFEA3799),
                                            size: 100,
                                          ));
                                        default:
                                          if (snapshot.hasError)
                                            return Center(
                                                child: Text('No Data Found'));
                                          if (snapshot.data == null) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {

                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  350,
                                              child: ListView.builder(
                                                  itemCount: absentList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = absentList[index];



                                                    if (monthSelection ==
                                                            int.parse(
                                                                DateTime.now()
                                                                    .toString()
                                                                    .substring(
                                                                        5,
                                                                        7)) &&
                                                        daySelection ==
                                                            int.parse(
                                                                DateTime.now()
                                                                    .toString()
                                                                    .substring(
                                                                        8,
                                                                        10)))


                                                    {



                                                      return Card(
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .redAccent
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),

                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius: 30,
                                                                          backgroundImage: NetworkImage(
                                                                            StringsConst.MAINURL + data.imagePath!,
                                                                          ),),
                                                                        Text(
                                                                          data!.name.toString(),
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  )),
                                                              Container(
                                                                  width: 80,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        data.designation!
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 14),
                                                                      )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                  width: 80,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      index == 3 ||
                                                                              index == 5
                                                                          ? Icon(
                                                                              Icons.check,
                                                                              color: Colors.greenAccent,
                                                                            )
                                                                          : Icon(
                                                                              Icons.cancel_outlined,
                                                                              color: Colors.black54,
                                                                            ),
                                                                    ],
                                                                  )),
                                                              Container(
                                                                  width: 80,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      data.num.toString() ==
                                                                              ""
                                                                          ? Icon(
                                                                              Icons.call,
                                                                              color: Colors.black54,
                                                                            )
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                launchPhoneDialer(data!.num!);
                                                                              },
                                                                              child: Icon(
                                                                                Icons.call,
                                                                                color: Colors.greenAccent,
                                                                              )),
                                                                      data.toString() ==
                                                                              ""
                                                                          ? Icon(
                                                                              Icons.mail,
                                                                              color: Colors.black54,
                                                                            )
                                                                          : Icon(
                                                                              Icons.mail,
                                                                              color: Colors.lightGreen,
                                                                            ),
                                                                    ],
                                                                  )),
                                                            ]),
                                                      );
                                                    }

                                                    return Container();
                                                  }),
                                            );
                                          }
                                      }
                                    }),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(color, name, days) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(color: color),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$name',
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        Text(
          '$days Days',
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
  }
}

class AbsentModel extends Equatable {
  String name;
  int id ;
  String? designation;
  String? num;
  DateTime? date;
  String? imagePath;

  AbsentModel({required this.name, required this.id,  this.designation, this.num, this.date, this.imagePath});
  @override
  List<Object> get props => [name, id];
}


