import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/Attendence_report/individual_report/individual_report_details.dart';
import 'package:salebee/Utils/StringsConst.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/utils.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualReport extends StatefulWidget {
  const IndividualReport({Key? key}) : super(key: key);

  @override
  State<IndividualReport> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<IndividualReport> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController _searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  String searchString = "";
  List result = [];

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
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
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
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                  itemCount: result.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = result![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(IndividualReportDetails(name: data.employeeName!, employeeID: data.employeeId,));
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
                                                    backgroundImage: NetworkImage(
                                                      StringsConst.MAINURL + data.profilePicturePath,
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
                                                      data.departmentObj == null
                                                          ? Text("No data")
                                                          : Text(data
                                                                  .departmentObj!
                                                                  .departmentName! +
                                                              ", Branch Name"),
                                                      data.designationObj ==
                                                              null
                                                          ? Text("No data")
                                                          : Text(data
                                                              .designationObj!
                                                              .designationName!),
                                                    ],
                                                  ),
                                                  trailing: Container(
                                                    width: 30,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(Icons.call),

                                                      ],
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

  List<Results> _search(List<Results>? employee) {
    if (searchString.isNotEmpty == true) {
      //search logic what you want
      return employee
              ?.where((element) =>
                  element.employeeName!.toLowerCase().contains(searchString))
              .toList() ??
          <Results>[];
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
