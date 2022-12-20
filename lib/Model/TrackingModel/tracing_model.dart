import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel{
  String? title;
  int? id;
  DateTime? time;
  LatLng latLn;
  String? image;
  LocationModel(this.title, this.id, this.latLn, this.time, this.image);
}