import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Model/visit/visit_list.dart';
import 'package:salebee/Screen/Map/map_screen.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/visit_repository.dart';

import '../../../../Model/employee/employee_list_model.dart';
import '../../../../utils.dart';

class VisitLog extends StatefulWidget {
  @override
  State<VisitLog> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<VisitLog> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  VisitRepository visitRepository = VisitRepository();
  String? newEmployee;
  int? employeeID;
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: borderColor, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
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
                                snapshot.data!.result!.forEach((element) {
                                  employeeID = element.employeeId!;
                                  print("${element.employeeName}" +
                                      "$newEmployee");
                                });
// assignToID = snapshot
//     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                              });
                            },
                            items: snapshot.data!.result!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.employeeName.toString(),
                                child: Text(value.employeeName.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<GetVisitListModel>(
                          future: visitRepository
                              .getAllVisitController(employeeID ?? 0),
                          builder: (context, snap) {
                            if (snapshot.data == null) {
                              print("no data found");
                            } else {
                              print("data found");
                            }
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
                                    height: MediaQuery.of(context).size.height -
                                        315,
                                    child: ListView.separated(
                                      itemCount: snap.data!.result!.length!,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var visitData =
                                            snap.data!.result![index];
                                        return Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              primaryColorSecond
                                                                  .withOpacity(
                                                                      .3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      width: 100,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 4.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                visitData.locationTime ==
                                                                        null
                                                                    ? Text(
                                                                        "No data",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        DateFormat('EEEE').format(visitData.locationTime!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
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
                                                                  child: visitData
                                                                              .locationTime ==
                                                                          null
                                                                      ? Text(
                                                                          "No Data",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          " " +
                                                                              visitData.locationTime!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                ),
                                                                visitData.locationTime ==
                                                                        null
                                                                    ? Text(
                                                                        "No data")
                                                                    : Text(
                                                                        DateFormat('MMM')
                                                                            .format(visitData
                                                                                .locationTime!)
                                                                            .toString()
                                                                            .substring(0,
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
                                                                  visitData.locationTime ==
                                                                          null
                                                                      ? Text(
                                                                          "No data")
                                                                      : Text(
                                                                          DateFormat.jm()
                                                                              .format(visitData.locationTime!),
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.bold),
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
                                                        visitData.prospectName ==
                                                                null
                                                            ? Text(
                                                                "No Data",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )
                                                            : Text(
                                                                visitData
                                                                    .prospectName,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                        Text(
                                                          visitData
                                                              .locationDescription
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Visted by: ${visitData.employeeId}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
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
                                        return Divider();
                                      },
                                    ),
                                  );
                                }
                            }
                          })
                    ],
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
