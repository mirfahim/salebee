import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/prospect/get_prospectList_by_id_model.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/activity_log_history.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';

import '../../../Model/employee/employee_list_model.dart';
import '../../../Model/followUp/followUP_by_prospectID_model.dart';
import '../../../Model/followUp/follow_up_by_date_model.dart';
import '../../../utils.dart';

class FollowUpActivity extends StatefulWidget {
  @override
  State<FollowUpActivity> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<FollowUpActivity> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  ProspectRepository prospectRepository = ProspectRepository();
  String? newEmployee;
  List<StageModel> stageList = [
    StageModel(
        "Follow up",
        primaryColorLight,
        1,
        Icon(
          Icons.email,
          size: 8,
        ),
        2),
    StageModel(
        "Visit",
        primaryColorLight,
        2,
        Icon(
          Icons.email,
          size: 8,
        ),
        3),
    StageModel(
        "Call",
        primaryColorLight,
        3,
        Icon(
          Icons.email,
          size: 8,
        ),
        1),
    StageModel(
        "Mail",
        primaryColorLight,
        4,
        Icon(
          Icons.email,
          size: 8,
        ),
        5),
    StageModel(
        "Meeting",
        primaryColorLight,
        5,
        Icon(
          Icons.email,
          size: 8,
        ),
        8),
    StageModel(
        "Stage",
        primaryColorLight,
        6,
        Icon(
          Icons.email,
          size: 8,
        ),
        4),
  ];
  int typeIndex = 0;
  int taskType = 0;
  int monthSelection = int.parse(DateTime.now().toString().substring(5, 7));
  int daySelection = int.parse(DateTime.now().toString().substring(8, 10));
  List<String> yearList = <String>[
    DateTime.now().year.toString(),
    DateTime(DateTime.now().year - 1).toString().substring(0, 4),
    DateTime(DateTime.now().year - 2).toString().substring(0, 4)
  ];
  String dropdownValue = DateTime.now().year.toString();

  int yearSelection = int.parse(DateTime.now().toString().substring(0, 4));
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
  List<TrackModel> trackingList = [
    TrackModel("Mirpur,DOHS, road 7", DateTime.now(), "33%"),
    TrackModel("Dhanmondi,kolabon, road 27", DateTime.now(), "34%"),
    TrackModel("Banani,K block, road 5", DateTime.now(), "65%"),
    TrackModel("Gulshan,DOHS, road 7", DateTime.now(), "53%"),
    TrackModel("Rampura,DOHS, road 7", DateTime.now(), "24%"),
    TrackModel("Banasree,DOHS, road 7", DateTime.now(), "76%"),
    TrackModel("AftabNagar,DOHS, road 7", DateTime.now(), "89%"),
    TrackModel("Malibag,DOHS, road 7", DateTime.now(), "34%"),
    TrackModel("Badda,DOHS, road 7", DateTime.now(), "78%"),
    TrackModel("Hatirjheel,lake road, road 7", DateTime.now(), "29%"),
    TrackModel("Shahbag,4rastar mor, road 7", DateTime.now(), "93%"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AllEmployeeListModel>(
        future: attendanceRepository.getAllEmployeeList(),
        builder: (BuildContext context,
            AsyncSnapshot<AllEmployeeListModel> snapshot) {
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
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        DefaultTabController(
                          initialIndex: monthSelection - 1,
                          length: 12,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  width: 70,
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    isExpanded: true,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                        yearSelection =
                                            int.parse(dropdownValue);
                                      });
                                    },
                                    items: yearList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
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
                                  initialIndex: monthSelection - 1,
                                  length: 12,
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            primaryColorSecond.withOpacity(.5)),
                                    isScrollable: true,
                                    indicatorColor: Colors.black,
                                    labelColor: Colors.black,
                                    onTap: (index) {
                                      setState(() {
                                        monthSelection = index + 1;
                                      });
                                    },
                                    tabs: tabs
                                        .map((tab) => Tab(
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  tab,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: DefaultTabController(
                            initialIndex: daySelection - 1,
                            length: 31,
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: TabBar(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  tab.toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: borderColor, width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: DropdownButton<String>(
                              hint: Text("All Employee"),
                              isExpanded: true,
                              value: newEmployee,
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? value) {
// This is called when the user selects an item.
                                setState(() {
                                  newEmployee = value!;
                                  snapshot.data!.results!.forEach((element) {
                                    print("${element.employeeName}" +
                                        "$newEmployee");
                                  });
// assignToID = snapshot
//     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                });
                              },
                              items: snapshot.data!.results!.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.employeeName.toString(),
                                  child: Text(value.employeeName.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 80,
                                      childAspectRatio: 6 / 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: StaticData.taskType.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      typeIndex = index;
                                      taskType = typeIndex;
                                      //cat = incomeList[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: taskType == index
                                          ? Colors.orangeAccent[100]
                                          : primaryColorSecond,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                StaticData.taskType[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: typeIndex == index
                                                      ? Colors.white
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<GetFollowupListModelByDate>(
                          future: prospectRepository
                              .getProspectFollowupByDateController(),
                          builder: (BuildContext context,
                              AsyncSnapshot<GetFollowupListModelByDate>
                                  snapshot) {
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
                                  if (typeIndex == 0) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount:
                                            snapshot.data!.result!.call!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.call![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (typeIndex == 1) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount:
                                            snapshot.data!.result!.call!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.call![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (typeIndex == 2) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount: snapshot
                                            .data!.result!.visit!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.visit![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (typeIndex == 3) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount: snapshot
                                            .data!.result!.meeting!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.meeting![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.meeting_room,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (typeIndex == 4) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount:
                                            snapshot.data!.result!.sms!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.sms![index];
                                          if (daySelection ==
                                                  int.parse(data!.createdOn!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.createdOn!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.createdOn!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.createdOn!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data!.createdOn!.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data!
                                                                              .createdOn!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data!.createdOn!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data
                                                                      .prospectId!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data
                                                                      .prospectId!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data!
                                                                      .createdBy
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.mobileNo!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (typeIndex == 5) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount:
                                            snapshot.data!.result!.call!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.call![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              335,
                                      child: ListView.separated(
                                        itemCount:
                                            snapshot.data!.result!.call!.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var data = snapshot
                                              .data!.result!.call![index];
                                          if (daySelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(8, 10)) &&
                                              monthSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(5, 7)) &&
                                              yearSelection ==
                                                  int.parse(data!.date!
                                                      .toString()
                                                      .substring(0, 4))) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              color: primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      DateFormat('EEEE')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3) +
                                                                          ",",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            data.date.toString().substring(8,
                                                                                10),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'MMM')
                                                                          .format(data
                                                                              .date!)
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              3),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Card(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.jm()
                                                                            .format(data.date!),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 05,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getProspectName(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              getProspectAdrs(
                                                                  data.prosID!,
                                                                  StaticData
                                                                      .prosepctList),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Followed up: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data.empName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                primaryColorLight,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "stage",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              (ActivityLogHistory()));
                                                        },
                                                        child: Card(
                                                          color: Colors
                                                              .greenAccent,
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(data!.description!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            height: 10,
                                            thickness: 5,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  getProspectName(int id, List<ProspectResult> list) {
    List<ProspectResult> p = [];
    p.add(list.where((element) => element.id == id).first);
    return p[0].prospectName;
  }

  getProspectAdrs(int id, List<ProspectResult> list) {
    List<ProspectResult> p = [];
    p.add(list.where((element) => element.id == id).first);
    return p[0].address;
  }
}

class TrackModel {
  String? location;
  DateTime? date;
  String? battery;
  TrackModel(this.location, this.date, this.battery);
}

class StageModel {
  String? stageName;
  int? id;
  Color? color;
  Icon icon;
  int? num;

  StageModel(this.stageName, this.color, this.id, this.icon, this.num);
}
