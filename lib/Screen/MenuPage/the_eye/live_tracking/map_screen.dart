import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/MenuPage/the_eye/map_view.dart';
import 'package:salebee/utils.dart';

import '../../../../Model/TrackingModel/tracing_model.dart';





class MapScreen extends StatefulWidget {
  List<LatLng> latLnList;
  List<LocationModel> trackingList;
  MapScreen({required this.latLnList, required this.trackingList});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markerss = {};



  // List<LatLng> latLen = [
  //   LatLng(23.7985053, 90.3842538),
  //   LatLng(23.802236, 90.3700),
  //   LatLng(23.8061939, 90.3771193),
  //   LatLng(23.807764, 90.367144),
  //   LatLng(23.809632, 90.371358),
  //
  // ];
  // List<LocationModel> markerlatLen = [
  //  LocationModel("pro1 ", 1, LatLng(23.7985053, 90.3842538), DateTime.now()),
  //   LocationModel("pro2 ", 2, LatLng(23.802236, 90.3700),DateTime.now()),
  //   LocationModel("pro3 ", 3, LatLng(23.8061939, 90.3771193), DateTime.now()),
  //   LocationModel("pro4 ", 4, LatLng(23.807764, 90.367144), DateTime.now()),
  //   LocationModel("pro5 ",  5, LatLng(23.809632, 90.371358), DateTime.now()),
  //
  // ];

  @override
  void initState() {

    for(int i=0; i<widget.trackingList.length; i++){
      _markerss.add(
        // added markers
          Marker(
            markerId: MarkerId(i.toString()),
            position: widget.trackingList[i].latLn,
            infoWindow: InfoWindow(
              title: widget.trackingList[i].title,
              snippet: DateFormat.jm().format(widget.trackingList[i].time!),
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );}
    _polyline.add(
        Polyline(
          polylineId: PolylineId('1'),
          points: widget.latLnList,
          color: Colors.green,
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: primaryColorLight,

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: 600,
          color: primaryColorLight,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: widget.latLnList[0], zoom: 13),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markerss,
            polylines: _polyline,
          ),
        ),

    );
  }
}



