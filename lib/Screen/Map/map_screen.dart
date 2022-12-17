import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/MenuPage/the_eye/map_view.dart';
import 'package:salebee/utils.dart';



class MapScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markerss = {};

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: AppConstant.list[index]["title"] + AppConstant.list[index]["title"] )
    );
  });

  List<LatLng> latLen = [
    LatLng(23.7985053, 90.3842538),
    LatLng(23.802236, 90.3700),
    LatLng(23.8061939, 90.3771193),
    LatLng(23.807764, 90.367144),
    LatLng(23.809632, 90.371358),

  ];
  List<LocationModel> markerlatLen = [
   LocationModel("pro1 ", 1, LatLng(23.7985053, 90.3842538), DateTime.now()),
    LocationModel("pro2 ", 2, LatLng(23.802236, 90.3700),DateTime.now()),
    LocationModel("pro3 ", 3, LatLng(23.8061939, 90.3771193), DateTime.now()),
    LocationModel("pro4 ", 4, LatLng(23.807764, 90.367144), DateTime.now()),
    LocationModel("pro5 ",  5, LatLng(23.809632, 90.371358), DateTime.now()),

  ];

  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    for(int i=0; i<markerlatLen.length; i++){
      _markerss.add(
        // added markers
          Marker(
            markerId: MarkerId(i.toString()),
            position: markerlatLen[i].latLn,
            infoWindow: InfoWindow(
              title: markerlatLen[i].title,
              snippet: DateFormat.jm().format(DateTime.now()),
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );}
    _polyline.add(
        Polyline(
          polylineId: PolylineId('1'),
          points: latLen,
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
          width: 400,
          color: primaryColorLight,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: LatLng(23.7985053,
                90.3842538), zoom: 13),
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

class AppConstant {
  static List<Map<String, dynamic>> list = [

    {"title": "Prospect one", "id": "1", "lat": 23.7985053, "lon": 90.3842538},
    {"title": "Prospect two", "id": "2", "lat": 23.802236, "lon": 90.3700},
    {"title": "prospect three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
    {"title": "prospect four", "id": "4", "lat": 23.807764, "lon": 90.367144},
    {"title": "prospect five", "id": "5", "lat": 23.809632, "lon": 90.371358},

  ];
}

class LocationModel{
  String? title;
  int? id;
  DateTime? time;
  LatLng latLn;
  LocationModel(this.title, this.id, this.latLn, this.time);
}