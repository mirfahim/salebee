import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Screen/MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/Screen/MenuPage/the_eye/activity_log_history.dart';
import 'package:salebee/repository/attendance_repository.dart';

import '../../../Model/employee/employee_list_model.dart';
import '../../../utils.dart';

class FollowUpActivity extends StatefulWidget {
  @override
  State<FollowUpActivity> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<FollowUpActivity> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
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
                                        child: Text(
                                          tab,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
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
                        Container(
                          height: MediaQuery.of(context).size.height - 335,
                          child: ListView.separated(
                            itemCount: trackingList.length,
                            itemBuilder: (BuildContext context, index) {
                              var data = trackingList[index];
                              return Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: primaryColorSecond
                                                    .withOpacity(.3),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            width: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        DateFormat('EEEE')
                                                                .format(
                                                                    data.date!)
                                                                .toString()
                                                                .substring(
                                                                    0, 3) +
                                                            ",",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
//"LogTimeIn":"2022-09-13T08:36:40.32"
                                                      Center(
                                                        child: Text(
                                                          " " +
                                                              data.date
                                                                  .toString()
                                                                  .substring(
                                                                      8, 10),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('MMM')
                                                            .format(data.date!)
                                                            .toString()
                                                            .substring(0, 3),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                              .format(
                                                                  data.date!),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Prospect Name",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                data.location.toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Followed up: ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Mr. xyz",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to((ActivityLogHistory()));
                                          },
                                          child: Card(
                                            color: Colors.greenAccent,
                                            child: Text(
                                              "Activity",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              105,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: stageList.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Card(
                                                elevation: 5,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .11,
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          child: Text(
                                                            stageList[index]
                                                                .num
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 8),
                                                          ),
                                                          backgroundColor:
                                                              stageList[index]
                                                                          .id! <=
                                                                      8
                                                                  ? stageList[
                                                                          index]
                                                                      .color
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          stageList[index]
                                                              .stageName!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 7),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                width: 0,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 10,
                                thickness: 5,
                              );
                            },
                          ),
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
