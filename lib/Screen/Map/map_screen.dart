import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salebee/utils.dart';



class MapScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: AppConstant.list[index]["title"])
    );
  });



  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            markers: Set.from(markers),
          ),
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