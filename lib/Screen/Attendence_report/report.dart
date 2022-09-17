import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/get_attendance_model.dart';
import '../../repository/attendance_repository.dart';
import '../../utils.dart';

class Report extends StatefulWidget {
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final summaryOpen = false.obs;
AttendanceRepository attendanceRepository = AttendanceRepository();
GetAttendanceDataModel getAttendanceDataModel = GetAttendanceDataModel();

  List<DataCell> dataRow = [

    DataCell(
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(6)
        ),
          width: 30, child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: const [
                Text('13',textAlign: TextAlign.center,),
                SizedBox(height: 3,),
                Text('SAT',textAlign: TextAlign.center,),
              ],
            ),
          )),
    ),
    DataCell(
      SizedBox(width: 80, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('08:26am',style: TextStyle(
            color: Colors.grey,fontWeight: FontWeight.w600
          ),),
          Text('Central building office',style: TextStyle(
              color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 8
          ),)
        ],
      )),
    ),
    DataCell(
      SizedBox(width: 80, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('08:26am',style: TextStyle(
              color: Colors.grey,fontWeight: FontWeight.w600
          ),),
          Text('Central building office',style: TextStyle(
              color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 8
          ),)
        ],
      )),
    ),
    const DataCell(
      SizedBox(width: 80, child: Text('10hr00mm',style: TextStyle(
          color: Colors.grey,fontWeight: FontWeight.w600
      ),),),
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
    'November'
        'December'
  ];
  //AttendanceRepository attendanceRepository = AttendanceRepository();
@override
  void initState() {
  attendanceRepository.getAttendanceController(1).then((value) {
     print(" my get report model is ${value.result!.length}");
  });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    'Summary',
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
                          ? const Icon(Icons.keyboard_arrow_down_rounded)
                          : const Icon(Icons.keyboard_arrow_up)))
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
              future: attendanceRepository.getAttendanceController(1),
              builder: (BuildContext context, AsyncSnapshot<GetAttendanceDataModel> snapshot,) {
               // print("my report data is ++++++++++++${snapshot.data!.result![0].workingDays}");

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AnimatedContainer(
                      curve: Curves.easeIn,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        children: [
                          summaryRow(Colors.blue, 'Working Days', snapshot.data!.result![0].workingDays),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.green, 'On Time', snapshot.data!.result![0].onTime),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.red, 'Late', 2),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.greenAccent, 'Left Timely', 10),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.redAccent, 'Left Early', 25),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.orange, 'On leave', snapshot.data!.result![0].onLeave),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                          summaryRow(Colors.red.withOpacity(.35), 'Absent', snapshot.data!.result![0].absent),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError){
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
                          summaryRow(Colors.greenAccent, 'Left Timely', 10),
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
                          summaryRow(Colors.red.withOpacity(.35), 'Absent', 8),
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
              }
            )
            : Container()),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DefaultTabController(
              length: 11,
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor),
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: tabs
                        .map((tab) => Tab(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(tab),
                              ),
                            ))
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // physics: NeverScrollableScrollPhysics(),
                      children: tabs
                          .map((e) => SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  dataRowHeight: 60,
                                    columns: const [
                                   DataColumn(
                                    label: SizedBox(
                                      width: 50,
                                      child: Text(
                                        'Date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                      label: SizedBox(
                                        width: 80,
                                        child: Text(
                                    'Check In',
                                          textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                      )),
                                  DataColumn(
                                      label: SizedBox(
                                        width: 80,
                                        child: Text(
                                    'Check Out',
                                          textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                      )),
                                  DataColumn(
                                      label: SizedBox(
                                        width: 80,
                                        child: Text(
                                    'Working Hour',
                                          textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                      ))
                                ],
                                    rows: [
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                  DataRow(cells: dataRow.map((e) => e).toList()),
                                ]

                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
