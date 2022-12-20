import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Model/visit/live_tracking_model.dart';
import 'package:salebee/Screen/MenuPage/the_eye/map_view.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:salebee/utils.dart';

import '../../../Data/static_data.dart';
import '../../../Model/TrackingModel/tracing_model.dart';
import '../../../Model/employee/employee_list_model.dart';




class EyeMapScreeen extends StatefulWidget {

  @override
  State<EyeMapScreeen> createState() => _MyAppState();
}

class _MyAppState extends State<EyeMapScreeen> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markerss = {};
  List<Result> result = [];

  List<LocationModel> markerlatLen = [


  ];
VisitRepository visitRepository = VisitRepository();
AttendanceRepository attendanceRepository = AttendanceRepository();
  @override
  void initState() {


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColorLight,

      body:    SingleChildScrollView(
        child:    FutureBuilder<AllEmployeeListModel>(
          future: attendanceRepository.getAllEmployeeList(),
          builder: (BuildContext context,
              AsyncSnapshot<AllEmployeeListModel> empSnap) {
            if (empSnap.data == null) {
              print("no data found");
            } else {}

            switch (empSnap.connectionState) {
              case ConnectionState.waiting:
                return Text("waiting");
              default:
                if (empSnap.hasError)
                  return Center(child: Text('No Data Found'));
                if (empSnap.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return FutureBuilder<GetLiveTrackingModel>(
                    future: visitRepository.getAllLiveTrackingController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<GetLiveTrackingModel> snapshot) {
                      if (snapshot.data == null) {
                        print("no data found");
                      } else {

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
                            snapshot.data!.result!.forEach((element) {


                                markerlatLen.add(LocationModel(getEmpName(element.employeeId!, empSnap.data!.results!), 1, LatLng(element.lat!, element.long!), element.createdOn, ""));


                            });

                            for(int i=0; i<markerlatLen.length; i++){
                              _markerss.add(
// added markers
                                  Marker(
                                    markerId: MarkerId(i.toString()),
                                    position: markerlatLen[i].latLn,
                                    infoWindow: InfoWindow(
                                      title: markerlatLen[i].title!.toString(),
                                      snippet: DateFormat.jm().format(markerlatLen[i].time!),
                                    ),
                                    icon: BitmapDescriptor.fromBytes(StaticData.customMarker!),
                                  )
                              );}
                            return Column(
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  height: MediaQuery.of(context).size.height - 160,
                                  width: MediaQuery.of(context).size.width - 10,
                                  color: primaryColorLight,
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(target: markerlatLen[0].latLn, zoom: 13),
                                    onMapCreated: (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    markers: _markerss,

                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    },
                  );
                }
            }
          },
        ),
      ),

    );
  }
  getEmpName(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list
        .where((element) => element.employeeId == id)
        .first);
    return p[0].employeeName;
  }
  getEmpImage(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list
        .where((element) => element.employeeId == id)
        .first);
    return p[0].employeeName;
  }
}



