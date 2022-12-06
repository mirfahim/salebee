import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController _searchController = TextEditingController();
  bool department = true;
  List<Result> searchEmployeeList = [];
  bool searchStart = false;
  String searchString = "";
  List result = [];
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
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
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
              height: 10,
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
              height: 10,
            ),
            FutureBuilder<AllEmployeeListModel>(
              future: attendanceRepository.getAllEmployeeList(),
              builder: (BuildContext context,
                  AsyncSnapshot<AllEmployeeListModel> snapshot) {

                if (snapshot.data == null) {
                  print("no data found");
                } else {
                   result = _search(snapshot.data!.result);
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
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                  itemCount: result.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = result![index];
                                    return GestureDetector(
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
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                      'images/person.jpg',
                                                    ),
                                                  ),
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
                                                  // trailing: Container(
                                                  //   width: 100,
                                                  //   child: Row(
                                                  //     crossAxisAlignment:
                                                  //         CrossAxisAlignment
                                                  //             .end,
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment.end,
                                                  //     children: [
                                                  //       Icon(Icons.call),
                                                  //       Icon(Icons.mail),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ),
                                              )
                                            ],
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
            Text("Employee id: "),
            Text(id.toString()),
          ],
        ),
          Row(
            children: [
              Text("NID: "),
              Text(nationalID.toString()),
            ],
          ),
          Row(
            children: [
              Text("Blood: "),
              Text(bloddgrp.toString()),
            ],
          ),
          Row(
            children: [
              Text("Present Address: "),
              Text(presentAddress!..toString()),
            ],
          ),
          Row(
            children: [
              Text("Phone: "),
              phoneNo == ""? Text("No data"):
              Text(phoneNo!.toString()),
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
              Text("Email: "),
              Text(email!.toString()),
            ],
          ),
          Row(
            children: [
              Text("Branch name: "),
              Text(branch.toString()),
            ],
          ),
        ],
      ),
      actions: <Widget>[

      ],
    );
  }
  List<Result> _search(List<Result>? employee) {
    if(searchString.isNotEmpty == true) {
      //search logic what you want
      return employee?.where((element) => element.employeeName!.toLowerCase().contains(searchString))
          .toList() ?? <Result>[];
    }

    return employee ?? <Result>[];
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
