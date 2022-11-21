// To parse this JSON data, do
//
//     final getAttendanceDataModel = getAttendanceDataModelFromJson(jsonString);

import 'dart:convert';

GetAttendanceDataModel getAttendanceDataModelFromJson(String str) => GetAttendanceDataModel.fromJson(json.decode(str));

String getAttendanceDataModelToJson(GetAttendanceDataModel data) => json.encode(data.toJson());

class GetAttendanceDataModel {
  GetAttendanceDataModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  dynamic message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAttendanceDataModel.fromJson(Map<String, dynamic> json) => GetAttendanceDataModel(
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
    this.logTimeIn,
    this.logTimeOut,
    this.isLogIn,
    this.isLogFromPhone,
    this.latitude,
    this.longitude,
    this.locationDescription,
    this.remark,
    this.isLate,
    this.isEarlyOut,
    this.isHalfDay,
    this.isExtremeLate,
    this.isExtremeEarlyOut,
    this.latitudeOut,
    this.longitudeOut,
    this.locationDescriptionOut,
    this.batteryStatus,
    this.absent,
    this.onLeave,
    this.workingDays,
    this.onTime,
    this.checkInNote,
    this.checkOutNote,
    this.token,
    this.hours,
    this.overTime,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? employeeId;
  var logTimeIn;
  var logTimeOut;
  bool? isLogIn;
  bool? isLogFromPhone;
  var latitude;
 var longitude;
  String? locationDescription;
  String? remark;
  bool? isLate;
  bool? isEarlyOut;
  bool? isHalfDay;
  bool? isExtremeLate;
  bool? isExtremeEarlyOut;
  var latitudeOut;
  var longitudeOut;
  String? locationDescriptionOut;
  String? batteryStatus;
  int? absent;
  int? onLeave;
  int? workingDays;
  int? onTime;
  String? checkInNote;
  String? checkOutNote;
  var token;
  var hours;
  var overTime;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  bool? isDeleted;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    logTimeIn: json["LogTimeIn"]   ,
    logTimeOut: json["LogTimeOut"]  ,
    isLogIn: json["IsLogIn"],
    isLogFromPhone: json["IsLogFromPhone"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    locationDescription: json["LocationDescription"],
    remark: json["Remark"],
    isLate: json["IsLate"],
    isEarlyOut: json["IsEarlyOut"],
    isHalfDay: json["IsHalfDay"],
    isExtremeLate: json["IsExtremeLate"],
    isExtremeEarlyOut: json["IsExtremeEarlyOut"],
    latitudeOut: json["LatitudeOut"],
    longitudeOut: json["LongitudeOut"],
    locationDescriptionOut: json["LocationDescriptionOut"],
    batteryStatus: json["BatteryStatus"],
    absent: json["Absent"],
    onLeave: json["OnLeave"],
    workingDays: json["WorkingDays"],
    onTime: json["OnTime"],
    checkInNote: json["CheckInNote"],
    checkOutNote: json["CheckOutNote"],
    token: json["Token"],
    hours: json["Hours"],
    overTime: json["OverTime"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: DateTime.parse(json["CreatedOn"]),
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "LogTimeIn": logTimeIn!.toIso8601String(),
    "LogTimeOut": logTimeOut!.toIso8601String(),
    "IsLogIn": isLogIn,
    "IsLogFromPhone": isLogFromPhone,
    "Latitude": latitude,
    "Longitude": longitude,
    "LocationDescription": locationDescription,
    "Remark": remark,
    "IsLate": isLate,
    "IsEarlyOut": isEarlyOut,
    "IsHalfDay": isHalfDay,
    "IsExtremeLate": isExtremeLate,
    "IsExtremeEarlyOut": isExtremeEarlyOut,
    "LatitudeOut": latitudeOut,
    "LongitudeOut": longitudeOut,
    "LocationDescriptionOut": locationDescriptionOut,
    "BatteryStatus": batteryStatus,
    "Absent": absent,
    "OnLeave": onLeave,
    "WorkingDays": workingDays,
    "OnTime": onTime,
    "CheckInNote": checkInNote,
    "CheckOutNote": checkOutNote,
    "Token": token,
    "Hours": hours,
    "OverTime": overTime,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}
