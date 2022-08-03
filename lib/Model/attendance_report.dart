// To parse this JSON data, do
//
//     final attendanceResponseModel = attendanceResponseModelFromJson(jsonString);

import 'dart:convert';

AttendanceResponseModel attendanceResponseModelFromJson(String str) => AttendanceResponseModel.fromJson(json.decode(str));

String attendanceResponseModelToJson(AttendanceResponseModel data) => json.encode(data.toJson());

class AttendanceResponseModel {
  AttendanceResponseModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  dynamic message;
  AttendanceResponseModelResult? result;
  bool? isSuccess;

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) => AttendanceResponseModel(
    message: json["Message"],
    result: AttendanceResponseModelResult.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
}

class AttendanceResponseModelResult {
  AttendanceResponseModelResult({
    this.message,
    this.result,
    this.isSuccess,
  });

  dynamic message;
  List<ResultElement>? result;
  bool? isSuccess;

  factory AttendanceResponseModelResult.fromJson(Map<String, dynamic> json) => AttendanceResponseModelResult(
    message: json["Message"],
    result: List<ResultElement>.from(json["Result"].map((x) => ResultElement.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class ResultElement {
  ResultElement({
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
  DateTime? logTimeIn;
  DateTime? logTimeOut;
  bool? isLogIn;
  bool? isLogFromPhone;
  int? latitude;
  int? longitude;
  String? locationDescription;
  String? remark;
  bool? isLate;
  bool? isEarlyOut;
  bool? isHalfDay;
  bool? isExtremeLate;
  bool? isExtremeEarlyOut;
  int? latitudeOut;
  int? longitudeOut;
  String? locationDescriptionOut;
  dynamic token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  bool? isDeleted;

  factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    logTimeIn: DateTime.parse(json["LogTimeIn"]),
    logTimeOut: DateTime.parse(json["LogTimeOut"]),
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
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}
