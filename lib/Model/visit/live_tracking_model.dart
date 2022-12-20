// To parse this JSON data, do
//
//     final getLiveTrackingModel = getLiveTrackingModelFromJson(jsonString);

import 'dart:convert';

GetLiveTrackingModel getLiveTrackingModelFromJson(String str) => GetLiveTrackingModel.fromJson(json.decode(str));

String getLiveTrackingModelToJson(GetLiveTrackingModel data) => json.encode(data.toJson());

class GetLiveTrackingModel {
  GetLiveTrackingModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetLiveTrackingModel.fromJson(Map<String, dynamic> json) => GetLiveTrackingModel(
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
    this.id,
    this.employeeId,
    this.lat,
    this.long,
    this.location,
    this.token,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
    this.battery,
  });

  int? id;
  int? employeeId;
  double? lat;
  double? long;
  String? location;
  String? token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  String? battery;
  DateTime? updatedOn;
  bool? isDeleted;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    battery: json["BatteryStatus"] == null ? "No data" : json["BatteryStatus"] ,
    lat: json["Lat"],
    long: json["Long"],
    location: json["Location"],
    token: json["Token"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "Lat": lat,
    "Long": long,
    "Location": location,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
    "BatteryStatus" : battery,
  };
}
