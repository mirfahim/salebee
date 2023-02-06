import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/my_colors.dart';
import '../../../utils.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<ReminderList> {
  TaskRepository taskRepository = TaskRepository();
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder List"),
      ),
      body: SingleChildScrollView(
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
                        height: MediaQuery.of(context).size.height -100,
                        child: ListView.builder(
                            itemCount: snapshot.data!.result!
                                .where((element) =>
                                    element.dueDate!.year ==
                                        DateTime.now().year &&
                                    element.dueDate!.month >=
                                        DateTime.now().month &&
                                    element.dueDate!.day >= DateTime.now().day)
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context, index) {
                              var data = snapshot.data!.result!
                                  .where((element) =>
                              element.dueDate!.year ==
                                  DateTime.now().year &&
                                  element.dueDate!.month >=
                                      DateTime.now().month &&
                                  element.dueDate!.day >= DateTime.now().day)
                                  .toList()[index];
                              return ExpandableNotifier(
                                child: Stack(
                                  children: [
                                    Card(
                                      shape:
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 02,
                                            color: data.statusId ==
                                                5
                                                ? Colors
                                                .greenAccent
                                                : data.statusId ==
                                                11
                                                ? Colors
                                                .red
                                                : data.statusId ==
                                                1
                                                ? Colors.blue
                                                : Colors.orange,
                                          ),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              6)),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            10.0,
                                            vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    Get.to(Task());
                                      },
                                                  child: Text(
                                                    "Task Id: ${data.taskId}",
                                                    style: TextStyle(
                                                        color:
                                                        primaryColor,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        fontSize:
                                                        12),
                                                  ),
                                                ),
                                                Container(
                                                    height: 52,
                                                    decoration: BoxDecoration(
                                                        color: primaryColorSecond.withOpacity(
                                                            .3),
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
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                DateFormat('EEEE').format(data.dueDate!).toString().substring(0, 3) + ",",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                              Center(
                                                                child: Text(
                                                                  " " + data.dueDate.toString().substring(8, 10),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                              Text(DateFormat('MMM').format(data.dueDate!).toString().substring(0, 3)),
                                                            ],
                                                          ),
                                                          Card(
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  DateFormat.jm().format(data.dueDate!),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${data.title!}',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .w600),
                                            ),

                                            Text(
                                              data.taskDesc!,
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontSize: 14),
                                            ),







                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
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
