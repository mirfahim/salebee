import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Model/getAssignedTaskToMeModel.dart';
import 'package:salebee/Provider/Login/provider_manager.dart';
import 'package:salebee/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/getAllTaskModel.dart';
import '../../Service/sharedPref_service.dart';
import '../../repository/add_task_repository.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AssignedToMeState();
}

class _AssignedToMeState extends State<AllTask> {
  TaskRepository taskRepository = TaskRepository();
  String statusName = "";
  int stausID = 1;
  int repeatId = 0;
  List<String> status = <String>[
    'Cancelled',
    'Done',
    'Incomplete',
    'Initiated',
    'Need More Time',
    'Need Others help',
    'Partially done'
  ];
  @override
  Widget build(BuildContext context) {
    ProviderManager providersss = Provider.of<ProviderManager>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    String? token = SharedPreff.to.prefss.getString("token");
    return Consumer<ProviderManager>(
      builder: (context, provider, widget) {
        return FutureBuilder<GetAllTaskModel>(
          future: taskRepository.getAllTaskController(), // async work
          builder: (BuildContext context, AsyncSnapshot<GetAllTaskModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Text('Loading....');
              default:
                if (snapshot.hasError)
                  return Center(child: Text('No Data Found'));
                else
                  return ListView.builder(

                      itemCount: snapshot.data!.result!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.result![index];
                       // statusName  = status[0];
                        return data.priorityName == providersss.filterData ||
                            providersss.filterData == "All" ||
                            providersss.filterData.isEmpty
                            ? ExpandableNotifier(
                          child: Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Task Id: ${data!.taskId}", style: TextStyle(
                                              color:primaryColor,
                                              fontWeight: FontWeight.bold,
                                            fontSize: 12
                                          ),),
                                          Text(
                                            DateFormat.yMd()
                                                .format(data!.createdOn!),
                                            style:
                                            TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${data!.title!}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Fix a meeting with ${data!.leadName!}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.taskDesc!,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                DateFormat.yMd()
                                                    .format(data!.dueDate!),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            '+5 days',
                                            style: TextStyle(
                                                color: Colors.grey,
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
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: const CircleAvatar(
                                              radius: 12,
                                              backgroundImage: AssetImage(
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
                                                color: Colors.grey,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Contact',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          data!.contact == null
                                              ? Text(
                                            "",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          )
                                              : Text(
                                            data!.contact!,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            '01911111111',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: const BorderRadius
                                                  .only(
                                                  topLeft: Radius
                                                      .circular(30),
                                                  topRight:
                                                  Radius.circular(
                                                      30),
                                                  bottomLeft:
                                                  Radius.circular(
                                                      30),
                                                  bottomRight:
                                                  Radius.circular(
                                                      30)),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 3),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.map,
                                                    color:
                                                    Colors.white,
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
                                                    .circular(6),
                                                border: Border.all(
                                                    color:
                                                    Colors.grey)),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 4, right: 4),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: stausID == null
                                                    ? null
                                                    : status[stausID],
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
                                                    stausID =
                                                        status.indexOf(value!);
                                                  });
                                                  taskRepository.taskUpdateController(
                                                      token: token!, title: data!.title!,
                                                      taskID: data!.taskId!,
                                                      assignaTo: data!.assignedTo!,
                                                      description:  data!.taskDesc!, type:  data!.type! ?? 0,
                                                      repeat: repeatId ?? 0, priority: data!.priority! ?? 0,
                                                      status: stausID ?? 0);
                                                },
                                                items: status
                                                    .map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value, style: TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(6),
                                                color:
                                                Colors.redAccent),
                                            child: Padding(
                                              padding: EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  12.0,
                                                  vertical: 8),
                                              child: Text(
                                                data!.priorityName!,
                                                style: TextStyle(
                                                    color:
                                                    Colors.white),
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
                                          theme: const ExpandableThemeData(
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Row(
                                            children: [
                                              const Text(
                                                'Pick Any',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  _textMe();
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.chat,
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
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  launchPhoneDialer(
                                                      "01700000000");
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.call,
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
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  _launchWhatsapp();
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.messenger,
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
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        100)),
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                      shape: BoxShape
                                                          .circle),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Icon(
                                                      Icons.more_horiz,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          collapsed: const SizedBox(
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
                                                    Icons.share,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    transform:
                                                    Matrix4.translationValues(
                                                        -10, 0, 0.0),
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    transform:
                                                    Matrix4.translationValues(
                                                        -20, 0, 0.0),
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    '+12',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    transform:
                                                    Matrix4.translationValues(
                                                        -10, 0, 0.0),
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    transform:
                                                    Matrix4.translationValues(
                                                        -20, 0, 0.0),
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle),
                                                    child: const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: AssetImage(
                                                        'images/person.jpg',
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    '+22',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
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
                                                            color:
                                                            Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                100)),
                                                        child: Container(
                                                          decoration:
                                                          BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
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
                                                            BorderRadius
                                                                .circular(
                                                                100)),
                                                        child: Container(
                                                          decoration:
                                                          BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color:
                                                              Colors.red,
                                                            ),
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
                      });
            }
          },
        );
      }
    );
  }
  _launchWhatsapp() async {
    var whatsapp = "+91XXXXXXXXXX";
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
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
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw("Cannot dial");
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