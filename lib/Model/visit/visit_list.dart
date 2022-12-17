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
    this.latitude,
    this.longitude,
    this.locationTime,
    this.imei,
    this.ip,
    this.brand,
    this.model,
    this.os,
    this.batteryStatus,
    this.osVersion,
    this.note,
    this.prospectId,
    this.leadId,
    this.leadName,
    this.prospectName,
    this.followupType,
    this.isLogIn,
    this.locationDescription,
    this.token,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? employeeId;
  double? latitude;
  double? longitude;
  DateTime? locationTime;
  String? imei;
  String? ip;
  dynamic brand;
  dynamic model;
  dynamic os;
  dynamic batteryStatus;
  dynamic osVersion;
  String? note;
  int? prospectId;
  int? leadId;
  dynamic leadName;
  dynamic prospectName;
  dynamic followupType;
  dynamic isLogIn;
  dynamic locationDescription;
  dynamic token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool? isDeleted;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    locationTime: DateTime.parse(json["LocationTime"]),
    imei: json["IMEI"] == null ? null : json["IMEI"],
    ip: json["IP"],
    brand: json["Brand"],
    model: json["Model"],
    os: json["OS"],
    batteryStatus: json["BatteryStatus"],
    osVersion: json["OSVersion"],
    note: json["Note"],
    prospectId: json["ProspectId"] == null ? null : json["ProspectId"],
    leadId: json["LeadId"] == null ? null : json["LeadId"],
    leadName: json["LeadName"],
    prospectName: json["ProspectName"],
    followupType: json["FollowupType"],
    isLogIn: json["IsLogIn"],
    locationDescription: json["LocationDescription"],
    token: json["Token"],
    active: json["Active"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "Latitude": latitude,
    "Longitude": longitude,
    "LocationTime": locationTime!.toIso8601String(),
    "IMEI": imei == null ? null : imei,
    "IP": ip == null ? null : ipValues.reverse[ip],
    "Brand": brand,
    "Model": model,
    "OS": os,
    "BatteryStatus": batteryStatus,
    "OSVersion": osVersion,
    "Note": note,
    "ProspectId": prospectId == null ? null : prospectId,
    "LeadId": leadId == null ? null : leadId,
    "LeadName": leadName,
    "ProspectName": prospectName,
    "FollowupType": followupType,
    "IsLogIn": isLogIn,
    "LocationDescription": locationDescription,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}

enum Ip { THE_1921681111, EMPTY }

final ipValues = EnumValues({
  "": Ip.EMPTY,
  "192.168.1.111": Ip.THE_1921681111
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
