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
  double? latitude;
  double? longitude;
  LocationDescription? locationDescription;
  LocationDescription? remark;
  bool? isLate;
  bool? isEarlyOut;
  bool? isHalfDay;
  bool? isExtremeLate;
  bool? isExtremeEarlyOut;
  var latitudeOut;
  var longitudeOut;
  LocationDescription? locationDescriptionOut;
  String? batteryStatus;
  int? absent;
  int? onLeave;
  int? workingDays;
  int? onTime;
  dynamic token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  bool? isDeleted;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    logTimeIn: DateTime.parse(json["LogTimeIn"]),
    logTimeOut: DateTime.parse(json["LogTimeOut"]),
    isLogIn: json["IsLogIn"],
    isLogFromPhone: json["IsLogFromPhone"],
    latitude: json["Latitude"].toDouble(),
    longitude: json["Longitude"].toDouble(),
    locationDescription: locationDescriptionValues.map![json["LocationDescription"]],
    remark: locationDescriptionValues.map![json["Remark"]],
    isLate: json["IsLate"],
    isEarlyOut: json["IsEarlyOut"],
    isHalfDay: json["IsHalfDay"],
    isExtremeLate: json["IsExtremeLate"],
    isExtremeEarlyOut: json["IsExtremeEarlyOut"],
    latitudeOut: json["LatitudeOut"],
    longitudeOut: json["LongitudeOut"],
    locationDescriptionOut: locationDescriptionValues.map![json["LocationDescriptionOut"]],
    batteryStatus: json["BatteryStatus"],
    absent: json["Absent"],
    onLeave: json["OnLeave"],
    workingDays: json["WorkingDays"],
    onTime: json["OnTime"],
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
    "LocationDescription": locationDescriptionValues.reverse[locationDescription],
    "Remark": locationDescriptionValues.reverse[remark],
    "IsLate": isLate,
    "IsEarlyOut": isEarlyOut,
    "IsHalfDay": isHalfDay,
    "IsExtremeLate": isExtremeLate,
    "IsExtremeEarlyOut": isExtremeEarlyOut,
    "LatitudeOut": latitudeOut,
    "LongitudeOut": longitudeOut,
    "LocationDescriptionOut": locationDescriptionValues.reverse[locationDescriptionOut],
    "BatteryStatus": batteryStatus,
    "Absent": absent,
    "OnLeave": onLeave,
    "WorkingDays": workingDays,
    "OnTime": onTime,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}

enum LocationDescription { STRING, DT }

final locationDescriptionValues = EnumValues({
  "dt": LocationDescription.DT,
  "string": LocationDescription.STRING
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
