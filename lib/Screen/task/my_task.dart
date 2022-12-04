import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Model/getAssignedTaskToMeModel.dart';
import 'package:salebee/Model/getListForTaskModel.dart';
import 'package:salebee/Provider/Login/provider_manager.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/utils.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/getAllTaskModel.dart';
import '../../Service/sharedPref_service.dart';
import '../../repository/add_task_repository.dart';

class MyTask extends StatefulWidget {
  const MyTask({Key? key}) : super(key: key);

  @override
  State<MyTask> createState() => _AssignedToMeState();
}

class _AssignedToMeState extends State<MyTask> {
  TaskRepository taskRepository = TaskRepository();
  String statusName = "";
  int stausID = 1;
  int selectedTap = 0;
  int repeatId = 0;
  List<GetListForTaskDataModel> manageTaskList = [];
  bool today = true;
  List<String> statusList = [];
  List doneList = [];
  List incompleteList = [];
  List initiatedList = [];
  int totalInitiated = 0;
  int totalDone = 0;
  int totalIncomplete = 0;
  int sendStatusId = 0;
  List<String> allStatusList = [];
  GetListForTaskDataModel manageModel = GetListForTaskDataModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderManager providersss =
        Provider.of<ProviderManager>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    String? token = SharedPreff.to.prefss.getString("token");
    return Consumer<ProviderManager>(builder: (context, provider, widget) {
      return SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<GetAllMyTaskModel>(
          future: taskRepository.getMyTaskController(), // async work
          builder: (BuildContext context,
              AsyncSnapshot<GetAllMyTaskModel> snapshot) {
            initiatedList.clear();
            doneList.clear();
            incompleteList.clear();
            if (snapshot.data == null) {
              print("no data found");
            } else {
              initiatedList.addAll(snapshot.data!.result!
                  .where((element) => element.statusId == 5));
              print("my ini list i s=++++++++++++${initiatedList.length}");
              doneList.addAll(snapshot.data!.result!
                  .where((element) => element.statusId == 4));
              print("my done list i s=++++++++++++${doneList.length}");
              incompleteList.addAll(snapshot.data!.result!
                  .where((element) => element.statusId == 1));
              print(
                  "my incomplete list i s=++++++++++++${incompleteList.length}");

              totalInitiated = initiatedList.length;
              totalDone = doneList.length;
              totalIncomplete = incompleteList.length;
            }
            // scoring system
            //    totalInitiated = snapshot.data!.result!.map((ele) => ele.statusId).fold(0, (prev, amount) => prev + amount!);

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF8686E3),
                      rightDotColor: const Color(0xFFEA3799),
                      size: 100,
                    ));
              default:
                if (snapshot.hasError)
                  return Center(child: Text('No Data Found'));
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.run_circle_outlined,
                                      color: Colors.green),
                                  Text(
                                    "Initiated: $totalInitiated",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.widgets,
                                      color: Colors.orangeAccent),
                                  Text(
                                    "Done: $totalDone",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.cancel_schedule_send,
                                      color: Colors.redAccent),
                                  Text(
                                    "Incomplete: $totalIncomplete",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ToggleSwitch(
                          minHeight: 30,
                          initialLabelIndex: today == true ? 0 : 1,
                          activeBgColor: [Colors.lightBlue],
                          totalSwitches: 2,
                          inactiveBgColor: Colors.white,
                          labels: ['Today', 'All'],
                          onToggle: (index) {
                            print('switched to: $index');
                            if (index == 0) {
                              setState(() {
                                today = true;
                              });
                            } else {
                              setState(() {
                                today = false;
                              });
                            }
                          },
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 250,
                          child: ListView.builder(
                              itemCount: snapshot.data!.result!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.result![index];

                                var filterDays = data.dueDate!
                                    .difference(DateTime.now())
                                    .inDays;


                                for (int i = 0;
                                    i < snapshot.data!.result!.length;
                                    i++) {
                                  statusList.add("All");
                                }
                                if (data.statusId == 5) {
                                  statusList[index] = "Initiated";
                                }
                                if (data.statusId == 4) {
                                  statusList[index] = "Done";
                                }
                                if (data.statusId == 1) {
                                  statusList[index] = "Incomplete";
                                }
                                if (data.statusId == 0) {
                                  statusList[index] = "All";
                                }
                                if (data.statusId == 11) {
                                  statusList[index] = "Cancelled";
                                }
                                if (data.statusId == 13) {
                                  statusList[index] = "Need More Time";
                                }
                                if (data.statusId == 3) {
                                  statusList[index] = "Partially Done";
                                }
                                print("my due date is ${data.dueDate!.toString()} and my today date is ${DateTime.now().toString()}");
                                return

                                  // filterDays > providersss.filterDay &&
                                  //           data.priorityName ==
                                  //               providersss.filterData ||
                                  //       providersss.filterData == "All" ||
                                  //       providersss.filterData.isEmpty



                                  today == true
                                      ?
                                  data.dueDate.toString().substring(0,10) ==  DateTime.now().toString().substring(0,10)

                                      ?  ExpandableNotifier(
                                    child: Stack(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 02,
                                                color: data.statusId == 5
                                                    ? Colors.greenAccent
                                                    : data.statusId == 11
                                                    ? Colors.red
                                                    : data.statusId == 1
                                                    ? Colors.blue
                                                    : Colors.orange,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(6)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Task Id: ${data.taskId}",
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(data
                                                          .createdOn!),
                                                      style: TextStyle(
                                                          color:
                                                          Colors.grey),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${data.title!}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                data.prospectName == null ?
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ):
                                                Text(
                                                  "${data.prospectName!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  data.taskDesc!,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            color: primaryColorSecond.withOpacity(.3),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                6)),
                                                        width: 100,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(vertical: 4.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(
                                                                    DateFormat('EEEE').format(data.dueDate!).toString().substring(0,3)+ ",",

                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                  Center(
                                                                    child: Text(
                                                                      " "+data.dueDate
                                                                          .toString()
                                                                          .substring(8, 10),
                                                                      textAlign:
                                                                      TextAlign.center,

                                                                    ),
                                                                  ),
                                                                  Text(DateFormat('MMM').format(data.dueDate!).toString().substring(0,3)),


                                                                ],
                                                              ),
                                                              Card(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [

                                                                    Text(
                                                                      DateFormat.jm().format(data.dueDate!),),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),


                                                    Spacer(),
                                                    Text(
                                                      "${data.dueDate!.difference(DateTime.now()).inDays} days",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                data.contactPersonDetails == null
                                                    ?  Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Prospect: ",
                                                          style: TextStyle(
                                                              fontSize:
                                                              12,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              2.5,
                                                          child:
                                                          GestureDetector(
                                                            onTap: (){


                                                            },
                                                            child: Text(
                                                              "${data.prospectName}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  12,
                                                                  color:
                                                                  Colors.lightBlue,
                                                                  fontWeight: FontWeight.normal),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    data.leadName == null || data.leadName =="" ?
                                                    Container():
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Lead:",
                                                          style: TextStyle(
                                                              fontSize:
                                                              12,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              4.1,
                                                          child: data.leadName ==
                                                              null
                                                              ? Text(
                                                            "No Data",
                                                            style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                          )
                                                              : Text(
                                                            "${data.leadName}",
                                                            style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )

                                                    :  Card(
                                                  elevation: 5,
                                                  color: data.contactPersonDetails == null
                                                      ? Colors.white
                                                      :MyColors.lightgreen,
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Prospect:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                      2.5,
                                                                  child:
                                                                  Text(
                                                                    "${data.prospectName}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        color:
                                                                        Colors.black54,
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Lead:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                      4.1,
                                                                  child: data.leadName ==
                                                                      null
                                                                      ? Text(
                                                                    "No Data",
                                                                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                                  )
                                                                      : Text(
                                                                    "${data.leadName}",
                                                                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        data.contactPersonDetails == null
                                                            ? Container()
                                                            :    Container(
                                                            child: Column(
                                                              children: [

                                                                Container(
                                                                  height: 20,
                                                                  color:
                                                                  primaryColor,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Contact person",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Designation",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Mobile",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                              ],
                                                            )
                                                        ),


                                                        Container(
                                                          height: 80,
                                                          child: ListView.builder(
                                                              itemCount: data.contactPersonDetails!.length,
                                                              itemBuilder: (BuildContext  context, int  index){
                                                                return Container(
                                                                  height: 40,
                                                                  color:
                                                                  Colors.white,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(color: Colors.grey, fontSize: 12),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonName!,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          maxLines:
                                                                          2,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 3.5,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        color:
                                                                        Colors.white,
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 3.5,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonDesignation!,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonMobile!,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        color: primaryColor,
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
                                                          children: const [
                                                            Icon(
                                                              Icons.map,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Visit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),

                                                    // const Text('Status',
                                                    //   style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 14,
                                                    //       fontWeight: FontWeight.w600
                                                    //   ),),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      width: 120,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey)),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            right: 4),
                                                        child:
                                                        DropdownButton(
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
                                                          items:
                                                          _dropDownItem(),
                                                          value: statusList[
                                                          index],
                                                          onChanged:
                                                              (String?
                                                          value) {
                                                            statusList[
                                                            index] =
                                                            value!;
                                                            print(
                                                                "updated selected ststus is $value");
                                                            if (value ==
                                                                "Done") {
                                                              stausID = 4;
                                                            }
                                                            if (value ==
                                                                "Incomplete") {
                                                              stausID = 1;
                                                            }
                                                            if (value ==
                                                                "All") {
                                                              stausID = 0;
                                                            }
                                                            if (value ==
                                                                "Cancelled") {
                                                              stausID = 11;
                                                            }
                                                            if (value ==
                                                                "Need More Time") {
                                                              stausID = 13;
                                                            }
                                                            if (value ==
                                                                "Partially Done") {
                                                              stausID = 3;
                                                            }
                                                            if (value ==
                                                                "Initiated") {
                                                              stausID = 5;
                                                            }

                                                            taskRepository
                                                                .taskUpdateController(
                                                                token:
                                                                token!,
                                                                title: data
                                                                    .title!,
                                                                taskID: data
                                                                    .taskId!,
                                                                assignaTo:
                                                                data
                                                                    .assignedTo!,
                                                                description:
                                                                data
                                                                    .taskDesc!,
                                                                type: data.type ??
                                                                    0,
                                                                repeat:
                                                                repeatId,
                                                                priority:
                                                                data
                                                                    .priority!,
                                                                status:
                                                                stausID)
                                                                .then(
                                                                    (value) {
                                                                  setState(
                                                                          () {});
                                                                });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 05,
                                                ),
                                                ScrollOnExpand(
                                                  scrollOnExpand: true,
                                                  scrollOnCollapse: false,
                                                  child: ExpandablePanel(
                                                    theme:
                                                    const ExpandableThemeData(
                                                      headerAlignment:
                                                      ExpandablePanelHeaderAlignment
                                                          .center,
                                                      tapBodyToCollapse:
                                                      true,
                                                    ),
                                                    header: Row(
                                                      children: [
                                                        const Text(
                                                          'Pick Any',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            _textMe(455);
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .chat,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            launchPhoneDialer(
                                                                "2424");
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .call,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            _launchWhatsapp( 356.toString());
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .messenger,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100)),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color:
                                                                primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    collapsed:
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    expanded: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.send,
                                                              color: Colors
                                                                  .grey,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration:
                                                              const BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              const CircleAvatar(
                                                                radius: 12,
                                                                backgroundImage:
                                                                AssetImage(
                                                                  'images/person.jpg',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            data.assignedPerson == null ?
                                                            Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                                : Text(
                                                              data.assignedPerson.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .airline_seat_recline_normal_sharp,
                                                              color: Colors
                                                                  .grey,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration:
                                                              const BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              const CircleAvatar(
                                                                radius: 12,
                                                                backgroundImage:
                                                                AssetImage(
                                                                  'images/suite.png',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            data.createdByName == null ?
                                                            Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                                :Text(
                                                              data.createdByName.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Action',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      14,
                                                                      fontWeight:
                                                                      FontWeight.w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.edit,
                                                                        color:
                                                                        primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.delete,
                                                                        color:
                                                                        Colors.red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  110,
                                                                ),

                                                                data.priorityName ==
                                                                    null
                                                                    ? Container()
                                                                    : Container(
                                                                  decoration:
                                                                  BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.redAccent),
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                                                    child: Text(
                                                                      data.priorityName.toString(),
                                                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(

                                  )
                                      :  ExpandableNotifier(
                                    child: Stack(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 02,
                                                color: data.statusId == 5
                                                    ? Colors.greenAccent
                                                    : data.statusId == 11
                                                    ? Colors.red
                                                    : data.statusId == 1
                                                    ? Colors.blue
                                                    : Colors.orange,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(6)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Task Id: ${data.taskId}",
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(data
                                                          .createdOn!),
                                                      style: TextStyle(
                                                          color:
                                                          Colors.grey),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${data.title!}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                data.prospectName == null ?
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ):
                                                Text(
                                                  "${data.prospectName!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  data.taskDesc!,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            color: primaryColorSecond.withOpacity(.3),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                6)),
                                                        width: 100,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(vertical: 4.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(
                                                                    DateFormat('EEEE').format(data.dueDate!).toString().substring(0,3)+ ",",

                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                  Center(
                                                                    child: Text(
                                                                      " "+data.dueDate
                                                                          .toString()
                                                                          .substring(8, 10),
                                                                      textAlign:
                                                                      TextAlign.center,

                                                                    ),
                                                                  ),
                                                                  Text(DateFormat('MMM').format(data.dueDate!).toString().substring(0,3)),


                                                                ],
                                                              ),
                                                              Card(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [

                                                                    Text(
                                                                      DateFormat.jm().format(data.dueDate!),),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),


                                                    Spacer(),
                                                    Text(
                                                      "${data.dueDate!.difference(DateTime.now()).inDays} days",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                data.contactPersonDetails == null
                                                    ?  Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Prospect: ",
                                                          style: TextStyle(
                                                              fontSize:
                                                              12,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              2.5,
                                                          child:
                                                          GestureDetector(
                                                            onTap: (){


                                                            },
                                                            child: Text(
                                                              "${data.prospectName}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  12,
                                                                  color:
                                                                  Colors.lightBlue,
                                                                  fontWeight: FontWeight.normal),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    data.leadName == null || data.leadName =="" ?
                                                    Container():
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Lead:",
                                                          style: TextStyle(
                                                              fontSize:
                                                              12,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              4.1,
                                                          child: data.leadName ==
                                                              null
                                                              ? Text(
                                                            "No Data",
                                                            style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                          )
                                                              : Text(
                                                            "${data.leadName}",
                                                            style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )

                                                    :  Card(
                                                  elevation: 5,
                                                  color: data.contactPersonDetails == null
                                                      ? Colors.white
                                                      :MyColors.lightgreen,
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Prospect:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                      2.5,
                                                                  child:
                                                                  Text(
                                                                    "${data.prospectName}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        12,
                                                                        color:
                                                                        Colors.black54,
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Lead:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                      4.1,
                                                                  child: data.leadName ==
                                                                      null
                                                                      ? Text(
                                                                    "No Data",
                                                                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                                  )
                                                                      : Text(
                                                                    "${data.leadName}",
                                                                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        data.contactPersonDetails == null
                                                            ? Container()
                                                            :    Container(
                                                            child: Column(
                                                              children: [

                                                                Container(
                                                                  height: 20,
                                                                  color:
                                                                  primaryColor,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Contact person",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Designation",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                            4,
                                                                        child: Text(
                                                                          "Mobile",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                              ],
                                                            )
                                                        ),


                                                        Container(
                                                          height: 80,
                                                          child: ListView.builder(
                                                              itemCount: data.contactPersonDetails!.length,
                                                              itemBuilder: (BuildContext  context, int  index){
                                                                return Container(
                                                                  height: 40,
                                                                  color:
                                                                  Colors.white,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(color: Colors.grey, fontSize: 12),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonName!,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          maxLines:
                                                                          2,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 3.5,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        color:
                                                                        Colors.white,
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 3.5,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonDesignation!,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      data.contactPersonDetails ==
                                                                          null
                                                                          ? Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          "No Data",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Container(
                                                                        width:
                                                                        MediaQuery.of(context).size.width / 4,
                                                                        child:
                                                                        Text(
                                                                          data.contactPersonDetails!.first.contactpersonMobile!,
                                                                          style:
                                                                          TextStyle(
                                                                            color: Colors.grey,
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        color: primaryColor,
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
                                                          children: const [
                                                            Icon(
                                                              Icons.map,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Visit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),

                                                    // const Text('Status',
                                                    //   style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 14,
                                                    //       fontWeight: FontWeight.w600
                                                    //   ),),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      width: 120,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey)),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            right: 4),
                                                        child:
                                                        DropdownButton(
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
                                                          items:
                                                          _dropDownItem(),
                                                          value: statusList[
                                                          index],
                                                          onChanged:
                                                              (String?
                                                          value) {
                                                            statusList[
                                                            index] =
                                                            value!;
                                                            print(
                                                                "updated selected ststus is $value");
                                                            if (value ==
                                                                "Done") {
                                                              stausID = 4;
                                                            }
                                                            if (value ==
                                                                "Incomplete") {
                                                              stausID = 1;
                                                            }
                                                            if (value ==
                                                                "All") {
                                                              stausID = 0;
                                                            }
                                                            if (value ==
                                                                "Cancelled") {
                                                              stausID = 11;
                                                            }
                                                            if (value ==
                                                                "Need More Time") {
                                                              stausID = 13;
                                                            }
                                                            if (value ==
                                                                "Partially Done") {
                                                              stausID = 3;
                                                            }
                                                            if (value ==
                                                                "Initiated") {
                                                              stausID = 5;
                                                            }

                                                            taskRepository
                                                                .taskUpdateController(
                                                                token:
                                                                token!,
                                                                title: data
                                                                    .title!,
                                                                taskID: data
                                                                    .taskId!,
                                                                assignaTo:
                                                                data
                                                                    .assignedTo!,
                                                                description:
                                                                data
                                                                    .taskDesc!,
                                                                type: data.type ??
                                                                    0,
                                                                repeat:
                                                                repeatId,
                                                                priority:
                                                                data
                                                                    .priority!,
                                                                status:
                                                                stausID)
                                                                .then(
                                                                    (value) {
                                                                  setState(
                                                                          () {});
                                                                });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 05,
                                                ),
                                                ScrollOnExpand(
                                                  scrollOnExpand: true,
                                                  scrollOnCollapse: false,
                                                  child: ExpandablePanel(
                                                    theme:
                                                    const ExpandableThemeData(
                                                      headerAlignment:
                                                      ExpandablePanelHeaderAlignment
                                                          .center,
                                                      tapBodyToCollapse:
                                                      true,
                                                    ),
                                                    header: Row(
                                                      children: [
                                                        const Text(
                                                          'Pick Any',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            _textMe(455);
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .chat,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            launchPhoneDialer(
                                                                "2424");
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .call,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                            _launchWhatsapp( 356.toString());
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .messenger,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100)),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color:
                                                                primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    collapsed:
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    expanded: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.send,
                                                              color: Colors
                                                                  .grey,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration:
                                                              const BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              const CircleAvatar(
                                                                radius: 12,
                                                                backgroundImage:
                                                                AssetImage(
                                                                  'images/person.jpg',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            data.assignedPerson == null ?
                                                            Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                                : Text(
                                                              data.assignedPerson.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .airline_seat_recline_normal_sharp,
                                                              color: Colors
                                                                  .grey,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration:
                                                              const BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              const CircleAvatar(
                                                                radius: 12,
                                                                backgroundImage:
                                                                AssetImage(
                                                                  'images/suite.png',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            data.createdByName == null ?
                                                            Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                                :Text(
                                                              data.createdByName.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Action',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      14,
                                                                      fontWeight:
                                                                      FontWeight.w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.edit,
                                                                        color:
                                                                        primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.delete,
                                                                        color:
                                                                        Colors.red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  110,
                                                                ),

                                                                data.priorityName ==
                                                                    null
                                                                    ? Container()
                                                                    : Container(
                                                                  decoration:
                                                                  BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.redAccent),
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                                                    child: Text(
                                                                      data.priorityName.toString(),
                                                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                              }),
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ));
    });
  }

  _launchWhatsapp(String num) async {
    var whatsapp = "+88${num}";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello Sir");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
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

  _textMe(num) async {
    // Android
    var uri = 'sms:+88${num.toString()}?body= Hellow Sir';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:+8801782084390?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  List<String> selectedItemValue = [];

  List<DropdownMenuItem<String>> _dropDownItem() {
    //  print("my all status in dropdown is $listStatus");

    // listStatus.forEach((element) {
    //   statusList.add(element);
    // });
    List<String>? stsList = SharedPreff.to.prefss.getStringList("statusList");
    List<String> ddl = [
      'Change Status',
      'Cancelled',
      'Done',
      'Incomplete',
      'Initiated',
      'Need More Time',
      'Need Others help',
      'Partially done'
    ];
    return stsList!
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }
}
// {
// "TaskID": 141759,
// "CreatedOn": "2020-12-27T16:42:48.197",
// "CreatedBy": 65,
// "Title": "Follow up with -JK",
// "AssignedTo": 79,
// "AssignedPerson": "Md. Kamal Hossain",
// "TaskDesc": "Have to follow up just for hi-hello to keep going business relation",
// "StatusId": 5,
// "DueDate": "2021-04-30T16:02:48",
// "Type": 1,
// "TaskType": "Call",
// "AllStatus": "1,Incomplete,0;2,Need More Time,0;3,Partially Done,0;4,Done,0;5,Initiated,1;9,Need others help,0;11,Cancelled,0",
// "PriorityName": "Very High",
// "Priority": 5,
// "ProspectName": "prospect name 31613",
// "ProspectId": 31613,
// "ProspectStatus": true,
// "IsIndividual": false,
// "ProspectNumber": "",
// "StatusUpdateDate": null,
// "LeadName": "",
// "DoneOrder": 0,
// "Contact": "41695,contact person x,Managing partner,000000",
// "TaskShares": "",
// "CanDelete": false,
// "OverDueOrder": 1,
// "IsProspectActive": "T",
// "CreatedByName": "Md. Kamal Hossain"
// },
