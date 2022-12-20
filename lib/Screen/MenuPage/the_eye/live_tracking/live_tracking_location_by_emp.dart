import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Model/visit/live_tracking_model.dart';
import 'package:salebee/Screen/MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:battery_plus/battery_plus.dart';
import '../../../../Model/TrackingModel/tracing_model.dart';
import '../../../../Model/visit/visit_list.dart';
import '../../../../utils.dart';

class AllVisitTrackPage extends StatefulWidget {
 String? employeeName;
 int? employeeId;
 AllVisitTrackPage(this.employeeName, this.employeeId);

  @override
  State<AllVisitTrackPage> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<AllVisitTrackPage> {
  GeolocatorService geolocatorService = GeolocatorService();
VisitRepository visitRepository = VisitRepository();
  List<TrackModel> trackingList = [
    TrackModel("Mirpur,DOHS, road 7", DateTime.now(), "33%"),
    TrackModel("Dhanmondi,kolabon, road 27", DateTime.now(), "34%"),
    TrackModel("Banani,K block, road 5", DateTime.now(), "65%"),
    TrackModel("Gulshan,DOHS, road 7", DateTime.now(), "53%"),
    TrackModel("Rampura,DOHS, road 7", DateTime.now(), "24%"),
    TrackModel("Banasree,DOHS, road 7", DateTime.now(), "76%"),
    TrackModel("AftabNagar,DOHS, road 7", DateTime.now(), "89%"),
    TrackModel("Malibag,DOHS, road 7", DateTime.now(), "34%"),
    TrackModel("Badda,DOHS, road 7", DateTime.now(), "78%"),
    TrackModel("Hatirjheel,lake road, road 7", DateTime.now(), "29%"),
    TrackModel("Shahbag,4rastar mor, road 7", DateTime.now(), "93%"),
  ];

  var battery = Battery();
  getBattery()async{
   var bat = await  battery.batteryLevel;
    return bat;
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.employeeName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            FutureBuilder<GetLiveTrackingModel>(
                future: widget.employeeId != null ?
                visitRepository
                    .getLiveTrackingByEmpController(widget.employeeId!)
                    : visitRepository
                    .getLiveTrackingByEmpController(widget.employeeId!),
                builder: (context, snap) {
                  if (snap.data == null) {
                    print("no data found");
                  } else {
                    geolocatorService.determinePosition().then((ele) {
                      getBattery().then((v){
                        const oneSec = Duration(minutes:5);
                        print("my timer strated $v lat ${ele!.latitude!}");
// Import package


// Instantiate it


                        Timer.periodic(oneSec, (Timer t) => visitRepository.addliveTrackController(latitude: ele!.latitude!, longitude: ele.longitude, batteryStatus: v.toString(),  ));
                      });
                    });

                  }
                  switch (snap.connectionState) {
                    case ConnectionState.waiting:
                      return Text("waiting....");
                    default:
                      if (snap.hasError)
                        return Center(child: Text('No Data Found'));
                      if (snap.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snap.data!.result != null) {
                        List<LatLng> latln = [];
                        List<LocationModel> trackingModel = [];
                        snap.data!.result!.forEach((element) {
                          latln.add(LatLng(element.lat!, element.long!));
                          trackingModel.add(LocationModel(element.location, element.id, LatLng(element.lat!, element.long!), element.createdOn, ""),);
                        });
                       
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width,
                              child: MapScreen(latLnList: latln, trackingList: trackingModel,),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height -
                                  420,
                              child: ListView.separated(
                                itemCount: snap.data!.result!.length,
                                itemBuilder:
                                    (BuildContext context, index) {
                                  var visitData =
                                  snap.data!.result![index];

                                  if (1==1) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      primaryColorSecond
                                                          .withOpacity(
                                                          .3),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(6)),
                                                  width: 100,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            visitData
                                                                .createdOn ==
                                                                null
                                                                ? Text(
                                                              "No data",
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            )
                                                                : Text(
                                                              DateFormat(
                                                                  'EEEE')
                                                                  .format(
                                                                  visitData
                                                                      .createdOn!)
                                                                  .toString()
                                                                  .substring(
                                                                  0,
                                                                  3) +
                                                                  ",",
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
//"LogTimeIn":"2022-09-13T08:36:40.32"

                                                            Center(
                                                              child: visitData
                                                                  .createdOn ==
                                                                  null
                                                                  ? Text(
                                                                "No Data",
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  10,
                                                                ),
                                                              )
                                                                  : Text(
                                                                " " +
                                                                    visitData
                                                                        .createdOn!
                                                                        .toString()
                                                                        .substring(
                                                                        8,
                                                                        10),
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  10,
                                                                ),
                                                              ),
                                                            ),
                                                            visitData
                                                                .createdOn ==
                                                                null
                                                                ? Text(
                                                                "No data")
                                                                : Text(
                                                              DateFormat(
                                                                  'MMM')
                                                                  .format(
                                                                  visitData
                                                                      .createdOn!)
                                                                  .toString()
                                                                  .substring(
                                                                  0,
                                                                  3),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        Card(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              visitData
                                                                  .createdOn ==
                                                                  null
                                                                  ? Text(
                                                                  "No data")
                                                                  : Text(
                                                                DateFormat
                                                                    .jm()
                                                                    .format(
                                                                    visitData
                                                                        .createdOn!),
                                                                style: TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight
                                                                        .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 05,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    visitData
                                                        .location ==
                                                        null
                                                        ? Text(
                                                      "No Data",
                                                      style:
                                                      TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .black54,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    )
                                                        : Text(
                                                      visitData
                                                          .location!,
                                                      style:
                                                      TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .black54,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    ),


                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Battery Charge: ${visitData.battery} ",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                              Colors
                                                                  .black,
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          ),
                                                        ),

                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),



                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider();
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                  }
                })
          ],
        ),
      ),
    );
  }
}

class TrackModel {
  String? location;
  DateTime? date;
  String? battery;
  TrackModel(this.location, this.date, this.battery);
}
