import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/route_planner/route_details.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class RoutePlan extends StatefulWidget {
  const RoutePlan({Key? key}) : super(key: key);

  @override
  State<RoutePlan> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<RoutePlan> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Plan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder<AllEmployeeListModel>(
              future: attendanceRepository.getAllEmployeeList(),
              builder: (BuildContext context,
                  AsyncSnapshot<AllEmployeeListModel> snapshot) {
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
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                            // physics: NeverScrollableScrollPhysics(),
                            //   primary: false,
                            //   shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              print("what is happening>");

                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(RouteDetails());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.grey_10,
                                      width:
                                          1, //                   <--- border width here
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: MyColors.appColor,
                                  ),
                                  child: Column(
                                    children: [
                                      //1stStart
                                      ListTile(
                                          leading: "pickup" == "pickup"
                                              ? Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.deepBlue,
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width:
                                                            1, //                   <--- border width here
                                                      ),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: "completed" ==
                                                                  "completed"
                                                              ? MyColors
                                                                  .deepBlue
                                                              : MyColors
                                                                  .deepBlue,
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "assets/pickup-01.png"),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.deepBlue,
                                                      border: Border.all(
                                                        color: Colors.green,
                                                        width:
                                                            1, //                   <--- border width here
                                                      ),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: "completed" ==
                                                                  "completed"
                                                              ? MyColors
                                                                  .deepBlue
                                                              : MyColors
                                                                  .deepBlue,
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "assets/delivery-01.png"),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                          title: Text(
                                            "Unknown",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text("Pickup"),
                                          trailing: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "krjeeori",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                            ),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Text(stopps.eta),

                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                color: MyColors.appColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 80,
                                                              width: 80,

                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: ExactAssetImage(
                                                                        'assets/map.png'),
                                                                    fit: BoxFit
                                                                        .fill),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1,
                                                                ),
                                                              ),

                                                              // child:  GoogleMap(
                                                              //       zoomControlsEnabled: false,
                                                              //       initialCameraPosition: _kGooglePlex,
                                                              // //  mapType: MapType.normal,
                                                              //   markers: Set<Marker>.of(_markers),
                                                              //   // onMapCreated: (GoogleMapController controller) {
                                                              //   //   _controller.complete(controller);
                                                              //   // },
                                                              //
                                                              //   ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: 230,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  " city srjioerjoeirjioer",
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: MyColors
                                                                          .grey_60),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 05,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 19,
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                "Date",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: MyColors
                                                                        .grey_60),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 05,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .pedal_bike_rounded,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                " PM, December 22. 2021",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: MyColors
                                                                        .grey_60),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 05,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.phone,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                "No phone num",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: MyColors
                                                                        .grey_60),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //1stEnd
                                    ],
                                  ),
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
