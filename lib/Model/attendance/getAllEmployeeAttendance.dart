// To parse this JSON data, do
//
//     final getAllEmployeeAttendance = getAllEmployeeAttendanceFromJson(jsonString);

import 'dart:convert';

GetAllEmployeeAttendance getAllEmployeeAttendanceFromJson(String str) => GetAllEmployeeAttendance.fromJson(json.decode(str));

String getAllEmployeeAttendanceToJson(GetAllEmployeeAttendance data) => json.encode(data.toJson());

class GetAllEmployeeAttendance {
  GetAllEmployeeAttendance({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAllEmployeeAttendance.fromJson(Map<String, dynamic> json) => GetAllEmployeeAttendance(
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
    this.departmentName,
    this.employeeUniqueId,
    this.logTimeIn,
    this.logTimeOut,
    this.hours,
    this.overTime,
    this.locationDescription,
    this.locationDescriptionOut,
    this.remark,
    this.fromDate,
    this.toDate,
    this.companyName,
    this.companyAddress,
    this.companyLogo,
    this.checkInNote,
    this.checkOutNote,
    this.latitude,
    this.longitude,
    this.latitudeOut,
    this.longitudeOut,
    this.formattedAddressIn,
    this.formattedAddressOut,
  });

  int? id;
  int? employeeId;
  String? employeeName;
  String? departmentName;
  String? employeeUniqueId;
  DateTime? logTimeIn;
  dynamic logTimeOut;
  String? hours;
  dynamic overTime;
  String? locationDescription;
  dynamic locationDescriptionOut;
  String? remark;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic companyName;
  dynamic companyAddress;
  dynamic companyLogo;
  String? checkInNote;
  dynamic checkOutNote;
  double? latitude;
  double? longitude;
  dynamic latitudeOut;
  dynamic longitudeOut;
  dynamic formattedAddressIn;
  dynamic formattedAddressOut;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    employeeName: json["EmployeeName"],
    departmentName: json["DepartmentName"],
    employeeUniqueId: json["EmployeeUniqueID"],
    logTimeIn: DateTime.parse(json["LogTimeIn"]),
    logTimeOut: json["LogTimeOut"],
    hours: json["Hours"],
    overTime: json["OverTime"],
    locationDescription: json["LocationDescription"],
    locationDescriptionOut: json["LocationDescriptionOut"],
    remark: json["Remark"],
    fromDate: DateTime.parse(json["FromDate"]),
    toDate: DateTime.parse(json["ToDate"]),
    companyName: json["CompanyName"],
    companyAddress: json["CompanyAddress"],
    companyLogo: json["CompanyLogo"],
    checkInNote: json["CheckInNote"],
    checkOutNote: json["CheckOutNote"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    latitudeOut: json["LatitudeOut"],
    longitudeOut: json["LongitudeOut"],
    formattedAddressIn: json["Formatted_addressIn"],
    formattedAddressOut: json["Formatted_addressOut"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "EmployeeName": employeeName,
    "DepartmentName": departmentName,
    "EmployeeUniqueID": employeeUniqueId,
    "LogTimeIn": logTimeIn!.toIso8601String(),
    "LogTimeOut": logTimeOut,
    "Hours": hours,
    "OverTime": overTime,
    "LocationDescription": locationDescription,
    "LocationDescriptionOut": locationDescriptionOut,
    "Remark": remark,
    "FromDate": fromDate!.toIso8601String(),
    "ToDate": toDate!.toIso8601String(),
    "CompanyName": companyName,
    "CompanyAddress": companyAddress,
    "CompanyLogo": companyLogo,
    "CheckInNote": checkInNote,
    "CheckOutNote": checkOutNote,
    "Latitude": latitude,
    "Longitude": longitude,
    "LatitudeOut": latitudeOut,
    "LongitudeOut": longitudeOut,
    "Formatted_addressIn": formattedAddressIn,
    "Formatted_addressOut": formattedAddressOut,
  };
}
