import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Model/getAssignedTaskToMeModel.dart';
import 'package:salebee/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/Login/provider_manager.dart';
import '../../repository/add_task_repository.dart';

class MyTask extends StatefulWidget {
  const MyTask({Key? key}) : super(key: key);

  @override
  State<MyTask> createState() => _AssignedToMeState();
}

class _AssignedToMeState extends State<MyTask> {
  TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    ProviderManager providersss =
        Provider.of<ProviderManager>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<GetAllMyTaskModel>(
      future: taskRepository.getMyTaskController(), // async work
      builder:
          (BuildContext context, AsyncSnapshot<GetAllMyTaskModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Center(child: Text('No Data Found'));
            else
              return ListView.builder(
                  itemCount: snapshot.data!.result!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.result![index];
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
                                           Text("Task Id: 01", style: TextStyle(
                                             color:primaryColor,
                                             fontWeight: FontWeight.bold
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
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(6),
                                                  border: Border.all(
                                                      color:
                                                      Colors.grey)),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      'Initialized',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      color:
                                                      Colors.grey,
                                                    )
                                                  ],
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

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
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
}
