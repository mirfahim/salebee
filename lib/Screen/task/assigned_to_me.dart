import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Model/getAssignedTaskToMeModel.dart';
import 'package:salebee/Model/getListForTaskModel.dart';
import 'package:salebee/Provider/Login/provider_manager.dart';
import 'package:salebee/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/getAllTaskModel.dart';
import '../../Service/sharedPref_service.dart';
import '../../repository/add_task_repository.dart';

class AssignedToMe extends StatefulWidget {
  const AssignedToMe({Key? key}) : super(key: key);

  @override
  State<AssignedToMe> createState() => _AssignedToMeState();
}

class _AssignedToMeState extends State<AssignedToMe> {
  TaskRepository taskRepository = TaskRepository();
  String statusName = "";
  int stausID = 1;
  int selectedTap = 0;
  int repeatId = 0;
  List<GetListForTaskDataModel> manageTaskList = [];

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
            child: FutureBuilder<GetAssignedTaskToMeModel>(
              future: taskRepository.getAssignedToMeTaskController(), // async work
              builder:
                  (BuildContext context, AsyncSnapshot<GetAssignedTaskToMeModel> snapshot) {

                    initiatedList.clear();
                    doneList.clear();
                    incompleteList.clear();
                    if(snapshot.data == null){
                      print("no data found");
                    } else{
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
                    return Text('Loading....');
                  default:
                    if (snapshot.hasError)
                      return Center(child: Text('No Data Found'));
                    if(snapshot.data == null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else {
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
                                      Text("Done: $totalDone",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.cancel_schedule_send,
                                          color: Colors.redAccent),
                                      Text("Incomplete: $totalIncomplete",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height -220,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.result!.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.result![index];

                                    var filterDays = data.dueDate!
                                        .difference(DateTime.now())
                                        .inDays;
                                    print(
                                        "my filter days is difference is $filterDays ${provider.filterDay}");

                                    print(
                                        "my date is = ${providersss.filterDay} ${snapshot.data!.result![index].dueDate!}");
                                    print(
                                        "my date is =  ${snapshot.data!.result![index].dueDate!}");

                                    for (int i = 0;
                                    i < snapshot.data!.result!.length;
                                    i++) {
                                      statusList.add("All");
                                    }
                                    if(data.statusId == 5){
                                      statusList[index] = "Initiated";
                                    }if(data.statusId == 4){
                                      statusList[index] = "Done";
                                    }if(data.statusId == 1){
                                      statusList[index] = "Incomplete";
                                    }if(data.statusId == 0){
                                      statusList[index] = "All";
                                    }if(data.statusId == 11){
                                      statusList[index] = "Cancelled";
                                    }if(data.statusId == 13){
                                      statusList[index] = "Need More Time";
                                    }
                                    return filterDays > providersss.filterDay &&
                                        data.priorityName ==
                                            providersss.filterData ||
                                        providersss.filterData == "All" ||
                                        providersss.filterData.isEmpty

                                    // data.dueDate.toString().substring(0,10) ==  providersss.today.toString().substring(0,10)
                                        ? ExpandableNotifier(
                                      child: Stack(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 02,
                                                  color:data.statusId ==
                                                      5
                                                      ?  Colors
                                                      .greenAccent
                                                      : data.statusId ==
                                                      11 ?  Colors.red : data.statusId ==
                                                      1 ? Colors.blue : Colors.orange,
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
                                                        "Task Id: ${data!.taskId}",
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
                                                            .format(data!
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
                                                    '${data!.title!}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                  Text(
                                                    'Fix a meeting with ${data!.leadName!}',
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
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color:
                                                            Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            DateFormat.yMd()
                                                                .format(data!
                                                                .dueDate!),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
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
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.send,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
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
                                                      Text(
                                                        data!.assignedPerson!,
                                                        style: TextStyle(
                                                            color:
                                                            Colors.grey,
                                                            fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Contact:',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        data.contact ==
                                                            null || data!.contact!.isEmpty
                                                            ? Text(
                                                          "No Data",
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .grey,
                                                            fontSize:
                                                            14,
                                                          ),
                                                        )
                                                            : Text(
                                                          data
                                                              .contact!,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          maxLines:
                                                          2,
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .grey,
                                                            fontSize:
                                                            14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Concern Person no:',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      data.prospectNumber == null
                                                          ||  data!.prospectNumber!.isEmpty?

                                                      Text(
                                                        "No Data",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                          :
                                                      Text(
                                                        data.prospectNumber!,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
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
                                                              if(value == "Done"){
                                                                stausID = 4;
                                                              }if(value == "Incomplete"){
                                                                stausID = 1;
                                                              }if(value == "All"){
                                                                stausID = 0;
                                                              }if(value == "Cancelled"){
                                                                stausID = 11;
                                                              }if(value == "Need More Time"){
                                                                stausID = 13;
                                                              }if(value == "Partially Done"){
                                                                stausID = 3;
                                                              }if(value == "Initiated"){
                                                                stausID = 5;
                                                              }
                                                              taskRepository
                                                                  .taskUpdateController(
                                                                  token:
                                                                  token!,
                                                                  title: data!
                                                                      .title!,
                                                                  taskID: data!
                                                                      .taskId!,
                                                                  assignaTo: data!
                                                                      .assignedTo!,
                                                                  description:
                                                                  data!
                                                                      .taskDesc!,
                                                                  type: data!.type! ??
                                                                      0,
                                                                  repeat:
                                                                  repeatId ??
                                                                      0,
                                                                  priority:
                                                                  data!
                                                                      .priority!,
                                                                  status:
                                                                  stausID ??
                                                                      0)
                                                                  .then(
                                                                      (value) {

                                                                    setState(
                                                                            () {

                                                                            });
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
                                                              _textMe();
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
                                                                  "01700000000");
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
                                                              _launchWhatsapp();
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
                                                          // Row(
                                                          //   children: [
                                                          //     Icon(
                                                          //       Icons.share,
                                                          //       color: Colors
                                                          //           .grey,
                                                          //     ),
                                                          //     SizedBox(
                                                          //       width: 5,
                                                          //     ),
                                                          //     Container(
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Container(
                                                          //       transform: Matrix4
                                                          //           .translationValues(
                                                          //           -10,
                                                          //           0,
                                                          //           0.0),
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Container(
                                                          //       transform: Matrix4
                                                          //           .translationValues(
                                                          //           -20,
                                                          //           0,
                                                          //           0.0),
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     const Text(
                                                          //       '+12',
                                                          //       style: TextStyle(
                                                          //           color: Colors
                                                          //               .grey,
                                                          //           fontSize:
                                                          //           14),
                                                          //     ),
                                                          //     SizedBox(
                                                          //       width: 15,
                                                          //     ),
                                                          //     Icon(
                                                          //       Icons
                                                          //           .remove_red_eye,
                                                          //       color: Colors
                                                          //           .grey,
                                                          //     ),
                                                          //     SizedBox(
                                                          //       width: 10,
                                                          //     ),
                                                          //     Container(
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Container(
                                                          //       transform: Matrix4
                                                          //           .translationValues(
                                                          //           -10,
                                                          //           0,
                                                          //           0.0),
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Container(
                                                          //       transform: Matrix4
                                                          //           .translationValues(
                                                          //           -20,
                                                          //           0,
                                                          //           0.0),
                                                          //       decoration:
                                                          //       const BoxDecoration(
                                                          //           shape:
                                                          //           BoxShape.circle),
                                                          //       child:
                                                          //       const CircleAvatar(
                                                          //         radius: 12,
                                                          //         backgroundImage:
                                                          //         AssetImage(
                                                          //           'images/person.jpg',
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     const Text(
                                                          //       '+22',
                                                          //       style: TextStyle(
                                                          //           color: Colors
                                                          //               .grey,
                                                          //           fontSize:
                                                          //           14),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Assign to',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                data!.assignedPerson ==
                                                                    null
                                                                    ? Text(
                                                                  "",
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                    14,
                                                                  ),
                                                                )
                                                                    : Text(
                                                                  data!
                                                                      .assignedPerson!,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  maxLines:
                                                                  2,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                    14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Created by',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              data!.createdByName == null ?
                                                              Text(
                                                                "",
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 14,
                                                                ),
                                                              )
                                                                  :
                                                              Text(data!.createdByName!,
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
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
                                                                  data!.priorityName!.isEmpty ?
                                                                  Container()
                                                                      :
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            6),
                                                                        color:
                                                                        Colors.redAccent),
                                                                    child:
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                          12.0,
                                                                          vertical:
                                                                          8),
                                                                      child:
                                                                      Text(
                                                                        data!
                                                                            .priorityName!,
                                                                        style:
                                                                        TextStyle(color: Colors.white),
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
                                        : Container();
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

  _launchWhatsapp() async {
    var whatsapp = "+91XXXXXXXXXX";
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
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

  _textMe() async {
    // Android
    const uri = 'sms:+39 348 060 888?body=hello%20there';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:0039-222-060-888?body=hello%20there';
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
