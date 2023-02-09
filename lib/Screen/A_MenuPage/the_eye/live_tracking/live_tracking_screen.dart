import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/live_tracking_location_by_emp.dart';
import 'package:salebee/Utils/StringsConst.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrackingScreen> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<LiveTrackingScreen> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController _searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  String searchString = "";
  Completer<GoogleMapController> _controller = Completer();
  List result = [];
  Iterable markers = [];
  int branchTypeIndex = 0;
  int branchType = 0;


  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              height: 40,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 80,
                      childAspectRatio: 6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: StaticData.branchList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          branchTypeIndex = index;
                          branchType = branchTypeIndex;
                          //cat = incomeList[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: branchTypeIndex == index
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    StaticData.branchList[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: branchTypeIndex == index
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
            // ToggleSwitch(
            //   minHeight: 30,
            //   initialLabelIndex: department == true ? 0 : 1,
            //   activeBgColor: [Colors.lightBlue],
            //   totalSwitches: 5,
            //   inactiveBgColor: Colors.white,
            //   labels: ['Executive', "srfs", "dfssd", "dfs", 'All'],
            //   onToggle: (index) {
            //     print('switched to: $index');
            //     if (index == 0) {
            //       setState(() {
            //         department = true;
            //       });
            //     }
            //     if (index == 1) {
            //       setState(() {
            //         department = true;
            //       });
            //     }
            //     if (index == 2) {
            //       setState(() {
            //         department = true;
            //       });
            //     }
            //     if (index == 3) {
            //       setState(() {
            //         department = true;
            //       });
            //     } else if (index == 4) {
            //       setState(() {
            //         department = false;
            //       });
            //     }
            //   },
            // ),
            SizedBox(
              height: 05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                child: TextField(
                  onChanged: (e) {

                    setState(() {
                      searchString = e;
                    });

                  },
                  onTap: () {
                    searchStart = false;
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25.0)))),
                ),
              ),
            ),
            SizedBox(
              height: 05,
            ),
            FutureBuilder<AllEmployeeListModel>(
              future: attendanceRepository.getAllEmployeeList(),
              builder: (BuildContext context,
                  AsyncSnapshot<AllEmployeeListModel> snapshot) {

                if (snapshot.data == null) {
                  print("no data found");
                } else {
                  result = _search(snapshot.data!.results);
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            Container(
                              height: MediaQuery.of(context).size.height - 250,
                              child: ListView.builder(
                                  itemCount: result.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = result![index];
                                    return ExpandableNotifier(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(
                                                  context,
                                                  data.employeeId,
                                                  data.nationalId ?? "No data",
                                                  data!.bloodGroup.toString() ?? "No data",
                                                  data.presentAddress ?? "No data",
                                                  data.departmentObj!.departmentName ?? "No data",
                                                  data.
                                                  emergencyContactPhone ?? "0000000000000",
                                                  data.emailAddresses?? "No data", ),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ListTile(
                                                        leading: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                StringsConst.MAINURL + data.profilePicturePath,
                                              ),),
                                                        title:
                                                        Text(data.employeeName!),
                                                        subtitle: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            data.departmentObj == null ?
                                                            Text("No data")
                                                                : Text(data.departmentObj!
                                                                .departmentName!),
                                                            data.designationObj == null ?
                                                            Text("No data")
                                                                :Text(data.designationObj!
                                                                .designationName!),
                                                          ],
                                                        ),
                                                        trailing: GestureDetector(
                                                          onTap: (){
                                                            Get.to(AllVisitTrackPage(data.employeeName!, data.employeeId));
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            child:  Icon(Icons.map),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
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
                                                            // _textMe(455);
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
                                                            // launchPhoneDialer(
                                                            //     "2424");
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
                                                            //    _launchWhatsapp( 356.toString());
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
                                                    expanded: Container(
                                                      color: Colors.white,
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: 130,
                                                            child: Column(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Last login time: ",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.bold
                                                                    ),),
                                                                    Text("12.30, 9th Dec",
                                                                      style: TextStyle(
                                                                        fontSize: 12,
                                                                      ),),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Battery Level: ",
                                                                      style: TextStyle(
                                                                        fontSize: 12,
                                                                          fontWeight: FontWeight.bold
                                                                      ),),
                                                                    Text("60%",
                                                                      style: TextStyle(
                                                                        fontSize: 12,
                                                                      ),),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 120,
                                                            width: 180,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Last Location: ",
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                      fontWeight: FontWeight.bold
                                                                  ),),
                                                                Text("Mirpur DOHS, road 12, house 455, block r, pollobi ,Dhaka, Bangladesh.",
                                                                  style: TextStyle(
                                                                    fontSize: 10,
                                                                  ),),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
          ]),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context,  @required int? id,  String? nationalID,  String? bloddgrp, String? presentAddress,  String? branch,  String? phoneNo,  String? email) {
    return new AlertDialog(
      title: const Text('Employee Details'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text("Employee id: ",

        style: TextStyle(
        fontSize: 10,
          fontWeight: FontWeight.bold,
      ),
              ),
              Text(id.toString(),

                style: TextStyle(
                fontSize: 10,
              ),),
            ],
          ),
          Row(
            children: [
              Text("NID: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              Text(nationalID.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),),
            ],
          ),
          Row(
            children: [
              Text("Blood: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              Text(bloddgrp.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),),
            ],
          ),
          Row(
            children: [
              Text("Present Address: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              Expanded(
                flex: 1,
                  child: Text(presentAddress!..toString(),
                  style: TextStyle(
                    fontSize: 10,
                  ),),
              ),
            ],
          ),
          Row(
            children: [
              Text("Phone: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              phoneNo == ""? Text("No data",
                style: TextStyle(
                  fontSize: 10,
                ),):
              Text(phoneNo!.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),),
              SizedBox(width: 20,),

              InkWell(
                  onTap: (){
                    launchPhoneDialer(phoneNo!);
                  },
                  child: Icon(Icons.call)),
            ],
          ),
          Row(
            children: [
              Text("Email: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              Text(email!.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),),
            ],
          ),
          Row(
            children: [
              Text("Branch name: ",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),),
              Text(branch.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),),
            ],
          ),
        ],
      ),
      actions: <Widget>[

      ],
    );
  }
  List<Results> _search(List<Results>? employee) {
    if(searchString.isNotEmpty == true) {
      //search logic what you want
      return employee?.where((element) => element.employeeName!.toLowerCase().contains(searchString))
          .toList() ?? <Results>[];
    }

    return employee ?? <Results>[];
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
}
