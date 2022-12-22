// To parse this JSON data, do
//
//     final getAllLiveTrackingModel = getAllLiveTrackingModelFromJson(jsonString);

import 'dart:convert';

GetAllLiveTrackingModel getAllLiveTrackingModelFromJson(String str) => GetAllLiveTrackingModel.fromJson(json.decode(str));

String getAllLiveTrackingModelToJson(GetAllLiveTrackingModel data) => json.encode(data.toJson());

class GetAllLiveTrackingModel {
  GetAllLiveTrackingModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAllLiveTrackingModel.fromJson(Map<String, dynamic> json) => GetAllLiveTrackingModel(
    message: json["Message"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class Result {
  Result({
    this.location,
    this.lat,
    this.long,
    this.batteryStatus,
    this.employeeId,
    this.createdOn,
  });

  String? location;
  double? lat;
  double? long;
  String? batteryStatus;
  int? employeeId;
  DateTime? createdOn;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    location: json["Location"],
    lat: json["Lat"].toDouble(),
    long: json["Long"].toDouble(),
    batteryStatus: json["BatteryStatus"] == null ? null : json["BatteryStatus"],
    employeeId: json["EmployeeId"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Location": location,
    "Lat": lat,
    "Long": long,
    "BatteryStatus": batteryStatus == null ? null : batteryStatus,
    "EmployeeId": employeeId,
    "CreatedOn": createdOn!.toIso8601String(),
  };
}
