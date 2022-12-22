// To parse this JSON data, do
//
//     final getVisitListModel = getVisitListModelFromJson(jsonString);

import 'dart:convert';

GetVisitListModel getVisitListModelFromJson(String str) => GetVisitListModel.fromJson(json.decode(str));

String getVisitListModelToJson(GetVisitListModel data) => json.encode(data.toJson());

class GetVisitListModel {
  GetVisitListModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetVisitListModel.fromJson(Map<String, dynamic> json) => GetVisitListModel(
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
    this.employeeName,
    this.latitude,
    this.longitude,
    this.locationTime,
    this.leadId,
    this.leadName,
    this.prospectId,
    this.prospectName,
    this.locationDescription
  });

  int? id;
  int? employeeId;
  String? employeeName;
  double? latitude;
  double? longitude;
  DateTime? locationTime;
  int? leadId;
  String? leadName;
  int? prospectId;
  String? prospectName;
  String? locationDescription;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    employeeName: json["EmployeeName"],
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    locationTime: DateTime.parse(json["LocationTime"]),
    leadId: json["LeadId"],
    leadName: json["LeadName"] == null ? "No data" : json["LeadName"],
    locationDescription: json["LocationDescription"] == null ? "No data" : json["LocationDescription"],
    prospectId: json["ProspectId"],
    prospectName: json["ProspectName"] == null ? "No Data" : json["ProspectName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "EmployeeName": employeeName,
    "Latitude": latitude,
    "Longitude": longitude,
    "LocationTime": locationTime!.toIso8601String(),
    "LeadId": leadId,
    "LeadName": leadName,
    "ProspectId": prospectId,
    "ProspectName": prospectName,
    "LocationDescription": locationDescription,
  };
}






