import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/map_for_all/map_view.dart';
import 'package:salebee/utils.dart';

import '../../../../Data/static_data.dart';



class VisitMapScreen extends StatefulWidget {

  double? lat;
  double? lon;
  String? prospectName;
  String? location;
  DateTime? time;
  VisitMapScreen({this.lat, this.lon, this.prospectName, this.time, this.location});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VisitMapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markerss = {};




  List<LocationModel> markerlatLen = [


  ];

  @override
  void initState() {
    markerlatLen.add(LocationModel(widget.location, 1, LatLng(widget.lat!, widget.lon!), widget.time));



    for(int i=0; i<markerlatLen.length; i++){
      _markerss.add(
        // added markers
          Marker(
            markerId: MarkerId(i.toString()),
            position: markerlatLen[i].latLn,
            icon: BitmapDescriptor.fromBytes(StaticData.customMarker!),

            infoWindow: InfoWindow(
              title: markerlatLen[i].title,
              snippet: DateFormat.jm().format(widget.time!),
            ),

          )
      );}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColorLight,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: 400,
        color: primaryColorLight,
        child: GoogleMap(

          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: LatLng(widget.lat!,
              widget.lon!), zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },

          markers: _markerss,

        ),
      ),

    );
  }
}



class LocationModel{
  String? title;
  int? id;
  DateTime? time;
  LatLng latLn;
  LocationModel(this.title, this.id, this.latLn, this.time);
}