import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/Attendence_report/individual_report/individual_report_pdf_preview.dart';
import 'package:salebee/Screen/Attendence_report/map_for_attendance.dart';
import 'package:salebee/utils.dart';

import '../../../Model/get_attendance_model.dart';
import '../../../repository/attendance_repository.dart';

///import 'package:my_app/globals.dart' as globals;

class IndividualReportDetails extends StatefulWidget {
  String? name;
  int? employeeID;
  IndividualReportDetails({this.name, this.employeeID});
  @override
  State<IndividualReportDetails> createState() => _ReportState();
}

class _ReportState extends State<IndividualReportDetails> {
  final summaryOpen = false.obs;
  AttendanceRepository attendanceRepository = AttendanceRepository();
  GetAttendanceDataModel getAttendanceDataModel = GetAttendanceDataModel();
  //TabController _tabController;
  List listData = [];
  int workingDays = 0;
  int onTime = 0;
  int late = 0;
  List<String> yearList = <String>[
    DateTime.now().year.toString(),
    DateTime(DateTime.now().year - 1).toString().substring(0, 4),
    DateTime(DateTime.now().year - 2).toString().substring(0, 4)
  ];
  String dropdownValue = DateTime.now().year.toString();
  int leftEarly = 0;
  int onLeave = 0;
  int absent = 0;
  int yearSelection = int.parse(DateTime.now().toString().substring(0, 4));
  int monthSelection = int.parse(DateTime.now().toString().substring(5, 7));
  List<DataCell> dataRow = [
    DataCell(
      Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(6)),
          width: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Text(
                  '13',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'SAT',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    ),
    DataCell(
      Container(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '08:26am',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Text(
                'Central building office',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 8),
              )
            ],
          )),
    ),
    DataCell(
      Container(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '08:26am',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Text(
                'Central building office',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 8),
              )
            ],
          )),
    ),
    DataCell(
      Container(
        width: 80,
        child: Text(
          '10hr00mm',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  ];

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

  //AttendanceRepository attendanceRepository = AttendanceRepository();
  @override
  void initState() {
    attendanceRepository
        .getAttendanceController(
            DateTime(
              DateTime.now().year,
              monthSelection,
            ),
            widget.employeeID)
        .then((value) {
      listData = value.result!;
      // _tabController = new TabController(vsync: this, length: tabs.length);
      leaveCount(listData);
      onTimeCount(listData);
      workingDaysCount(listData);
      absentCount(listData);
      leaveCount(listData);
      leftTimelyCount(listData);
    });

    // TODO: implement initState
    super.initState();
  }

  leaveCount(List data) {
    num count = 0;
    data.forEach((item) => count += item.onLeave);
    print("on leave is $count");
    onLeave = count.toInt();
    return count;
  }

  leftTimelyCount(List data) {
    num count = 0;
    data.forEach((item) => count += item.onLeave);
    print("on leave is $count");
    onLeave = count.toInt();
    return count;
  }

  onTimeCount(List data) {
    num count = 0;
    data.forEach((item) => count += item.onLeave);
    print("on leave is $count");
    onTime = count.toInt();
    return count;
  }

  workingDaysCount(List data) {
    num count = 0;
    data.forEach((item) => count += item.onLeave);
    print("on leave is $count");
    workingDays = count.toInt();
    return count;
  }

  absentCount(List data) {
    num count = 0;
    data.forEach((item) => count += item.onLeave);
    print("on leave is $count");
    absent = count.toInt();
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Individual Report Details"),
      ),
      body: Container(
        color: primaryColorLight,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.name}' + "'s Attendance Report",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: primaryColorSecond.withOpacity(.4)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Click for Summary',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Obx(() => InkWell(
                          onTap: () {
                            if (summaryOpen.value == false) {
                              summaryOpen.value = true;
                            } else {
                              summaryOpen.value = false;
                            }
                          },
                          child: summaryOpen.value == false
                              ? Icon(Icons.keyboard_arrow_down_rounded)
                              : Icon(Icons.keyboard_arrow_up)))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => summaryOpen.value == true
                ? FutureBuilder<GetAttendanceDataModel>(
                    future: attendanceRepository.getAttendanceController(
                        DateTime(DateTime.now().year, monthSelection),
                        widget.employeeID),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<GetAttendanceDataModel> snapshot,
                    ) {
                      // print("my report data is ++++++++++++${snapshot.data!.result![0].workingDays}");

                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                summaryRow(
                                    Colors.blue, 'Working Days', workingDays),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.green, 'On Time', onTime),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.red, 'Late', late),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.greenAccent, 'Left Timely',
                                    leftEarly),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(
                                    Colors.redAccent, 'Left Early', leftEarly),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.orange, 'On leave', onLeave),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.red.withOpacity(.35),
                                    'Absent', absent),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                summaryRow(Colors.blue, 'Working Days', 0),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.green, 'On Time', 0),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.red, 'Late', 2),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(
                                    Colors.greenAccent, 'Left Timely', 10),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.redAccent, 'Left Early', 25),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(Colors.orange, 'On leave', 4),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                                summaryRow(
                                    Colors.red.withOpacity(.35), 'Absent', 8),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(.35),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    })
                : Container()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DefaultTabController(
                  initialIndex: monthSelection - 1,
                  length: 12,
                  child: Column(
                    children: [
                      Row(
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
                            child: TabBar(
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primaryColorSecond.withOpacity(.5)),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(tab),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Check IN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Check Out',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Working Hour',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                        child: FutureBuilder<GetAttendanceDataModel>(
                            future:
                                attendanceRepository.getAttendanceController(
                                    DateTime(
                                      DateTime.now().year,
                                      monthSelection,
                                    ),
                                    widget.employeeID),
                            builder: (BuildContext context,
                                AsyncSnapshot<GetAttendanceDataModel>
                                    snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              350,
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data!.result!.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            var data =
                                                snapshot.data!.result![index];
                                            print(
                                                "my month selection is length ++ ${snapshot.data!.result!.length} and month ${data.logTimeIn.toString().substring(5, 7)}");
                                            final hours = DateTime.parse(data
                                                        .logTimeOut ??
                                                    "2035-09-13T21:06:40.32")
                                                .difference(DateTime.parse(
                                                    data.logTimeIn))
                                                .inHours;
                                            final minutes = DateTime.parse(data
                                                        .logTimeOut ??
                                                    "2035-09-13T21:06:40.32")
                                                .difference(DateTime.parse(
                                                    data.logTimeIn))
                                                .inMinutes;
                                            final totalWorkingHours =
                                                '$hours.${(minutes - (hours * 60))}';
                                            if (monthSelection ==
                                                    int.parse(data.logTimeIn
                                                        .toString()
                                                        .substring(5, 7)) &&
                                                yearSelection ==
                                                    int.parse(data.logTimeIn
                                                        .toString()
                                                        .substring(0, 4))) {
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          width: 30,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                Center(
                                                                  child: Text(
                                                                    data.logTimeIn
                                                                        .toString()
                                                                        .substring(
                                                                            8,
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 3,
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          'EEEE')
                                                                      .format(DateTime
                                                                          .parse(data
                                                                              .logTimeIn))
                                                                      .toString()
                                                                      .substring(
                                                                          0, 3),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
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
                                                                    .format(DateTime
                                                                        .parse(data
                                                                            .logTimeIn)),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.to(
                                                                      AttendanceMapScreen(
                                                                    lat: data
                                                                        .latitude,
                                                                    lon: data
                                                                        .longitude,
                                                                    location: data
                                                                        .locationDescription,
                                                                    time: DateTime
                                                                        .parse(data
                                                                            .logTimeIn),
                                                                  ));
                                                                },
                                                                child: Text(
                                                                  data.locationDescription
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          8),
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
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  : Text(
                                                                      DateFormat.jm()
                                                                              .format(DateTime.parse(data.logTimeOut)) ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                              data.locationDescriptionOut ==
                                                                      null
                                                                  ? Text(
                                                                      "No Data",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              8),
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            AttendanceMapScreen(
                                                                          lat:23.7985053,
                                                                          lon:90.3842538,
                                                                          location:
                                                                              data.locationDescriptionOut ?? "",
                                                                          time:
                                                                              DateTime.now(),
                                                                        ));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        data.locationDescriptionOut
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
                                                        child: totalWorkingHours ==
                                                                null
                                                            ? Text(
                                                                "No Data",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )
                                                            : double.parse(
                                                                        totalWorkingHours) >
                                                                    18.00
                                                                ? Text(
                                                                    "No check out data.",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                : Text(
                                                                    totalWorkingHours
                                                                            .toString() +
                                                                        " hrs",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                      ),
                                                    ]),
                                              );
                                            }

                                            return Container();
                                          }),
                                    ),
                                    snapshot.data!.result!.length != 0
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      PdfPreviewPage(
                                                        name: widget.name!,
                                                    report: snapshot.data!,
                                                    yearSelection:
                                                        yearSelection,
                                                    monthSelection:
                                                        monthSelection,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                    'images/Icons/utility_expense.png',
                                                  ))),
                                                ),
                                                Text(
                                                  "View PDF",
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ))
                                        : Container(),
                                  ],
                                );
                              } else {
                                CircularProgressIndicator();
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
}
// table view attendance

// Expanded(
// child: TabBarView(
// physics: AlwaysScrollableScrollPhysics(),
// // physics: NeverScrollableScrollPhysics(),
// children: tabs
//     .map((e) => SingleChildScrollView(
// scrollDirection: Axis.vertical,
// child: SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// child: DataTable(
// dataRowHeight: 60,
// columns: const [
// DataColumn(
// label: SizedBox(
// width: 50,
// child: Text(
// 'Date',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 12),
// ),
// ),
// ),
// DataColumn(
// label: SizedBox(
// width: 80,
// child: Text(
// 'Check In',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 12),
// ),
// )),
// DataColumn(
// label: SizedBox(
// width: 80,
// child: Text(
// 'Check Out',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 12),
// ),
// )),
// DataColumn(
// label: SizedBox(
// width: 80,
// child: Text(
// 'Working Hour',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 12),
// ),
// ))
// ],
// rows: [
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// DataRow(cells: dataRow.map((e) => e).toList()),
// ]
//
// ),
// ),
// ),
// )
//     .toList(),
// ),
// ),
