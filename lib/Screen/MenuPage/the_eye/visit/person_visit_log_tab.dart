import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Model/visit/visit_list.dart';
import 'package:salebee/Screen/MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/Screen/MenuPage/the_eye/visit/visit_list_map.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:http/http.dart' as http;
import '../../../../Helper/location_helper.dart';
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
  String? emp;
  String? locationDis;
  GeolocatorService geolocatorService = GeolocatorService();
  int? employeeID;
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
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                      yearSelection = int.parse(dropdownValue);
                                    });
                                  },
                                  items: yearList.map<DropdownMenuItem<String>>(
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
                                                style: TextStyle(fontSize: 12),
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
                                snapshot.data!.results!.forEach((element) {
                                  if (newEmployee == element.employeeName!) {
                                    employeeID = element.employeeId!;
                                    print(
                                        "employee id is${element.employeeName}" +
                                            "$employeeID");
                                  }
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
                        height: 5,
                      ),
                      FutureBuilder<GetVisitListModel>(
                          future: employeeID != null
                              ? visitRepository
                                  .getEmployeeIdVisitController(employeeID!)
                              : visitRepository.getAllVisitController(),
                          builder: (context, snap) {
                            if (snap.data == null) {
                              print("no data found");
                            } else {
                              print("data found");
                            }
                            switch (snap.connectionState) {
                              case ConnectionState.waiting:
                                return Text("waiting....");
                              default:
                                if (snap.hasError)
                                  return Center(child: Text('No Data Found'));
                                if (snap.data == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snap.data!.result != null) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height -
                                        315,
                                    child: ListView.builder(
                                      itemCount: snap.data!.result!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        var visitData =
                                            snap.data!.result![index];

                                        if (monthSelection ==
                                                int.parse(visitData.locationTime
                                                    .toString()
                                                    .substring(5, 7)) &&
                                            daySelection ==
                                                int.parse(visitData.locationTime
                                                    .toString()
                                                    .substring(8, 10)) &&
                                            yearSelection ==
                                                int.parse(visitData.locationTime
                                                    .toString()
                                                    .substring(0, 4))) {
                                          return Card(
                                            child: Container(
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
                                                                    visitData.locationTime ==
                                                                            null
                                                                        ? Text(
                                                                            "No data",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                                          )
                                                                        : Text(
                                                                            DateFormat('EEEE').format(visitData.locationTime!).toString().substring(0, 3) +
                                                                                ",",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                                          ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
//"LogTimeIn":"2022-09-13T08:36:40.32"

                                                                    Center(
                                                                      child: visitData.locationTime ==
                                                                              null
                                                                          ? Text(
                                                                              "No Data",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: 10,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              " " + visitData.locationTime!.toString().substring(8, 10),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                    visitData.locationTime ==
                                                                            null
                                                                        ? Text(
                                                                            "No data")
                                                                        : Text(
                                                                            DateFormat('MMM').format(visitData.locationTime!).toString().substring(0,
                                                                                3),
                                                                            style:
                                                                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                                                                              DateFormat.jm().format(visitData.locationTime!),
                                                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    visitData
                                                                        .prospectName!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                            Text(
                                                              visitData
                                                                  .prospectAddress!,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 5,
                                                                width: 200,
                                                                child: Divider(
                                                                  thickness: 1,
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Visted by: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  "${getEmpName(visitData.employeeId!, snapshot.data!.results!)}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Address: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Container(

                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .5,
                                                                  child: Center(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        geolocatorService.determinePosition().then(
                                                                            (ele) {
                                                                          getAddressFromLatLng(ele!.latitude!, ele.longitude)
                                                                              .then((v) {
                                                                            print("my location from google api $v");

                                                                            locationDis =
                                                                                v;
                                                                          });
                                                                        }).then((value) =>
                                                                            Get.to(VisitMapScreen(
                                                                              location: locationDis,
                                                                              lat: visitData.latitude,
                                                                              lon: visitData.longitude,
                                                                              time: visitData.locationTime,
                                                                            )));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                            maxLines:2,
                                                                        visitData
                                                                            .locationDescription!,

                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                primaryColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
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

  getAddress(lat, lon) async {
    getAddressFromLatLng(lat, lon).then((v) {
      print("my location from google api $v");

      locationDis = v;
    });
    return locationDis;
  }

  getAddressFromLatLng(double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        locationDis = _formattedAddress;
        return locationDis;
      }
      return locationDis;
    }
  }

  getEmpName(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list.where((element) => element.employeeId == id).first);
    return p[0].employeeName;
  }
}
