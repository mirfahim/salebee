// To parse this JSON data, do
//
//     final attendanceResponseModel = attendanceResponseModelFromJson(jsonString);

import 'dart:convert';

CheckinResponse attendanceResponseModelFromJson(String str) => CheckinResponse.fromJson(json.decode(str));

String attendanceResponseModelToJson(CheckinResponse data) => json.encode(data.toJson());

class CheckinResponse {
  String? message;
  Result? result;
  bool? isSuccess;

  CheckinResponse({this.message, this.result, this.isSuccess});

  CheckinResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}

class Result {
  int? id;
  int? employeeId;
  String? logTimeIn;
  String? logTimeOut;
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
  int? latitudeOut;
  int? longitudeOut;
  String? locationDescriptionOut;
  String? batteryStatus;
  int? absent;
  int? onLeave;
  int? workingDays;
  int? onTime;
  String? token;
  bool? active;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  bool? isDeleted;

  Result(
      {this.id,
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
        this.isDeleted});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['EmployeeId'];
    logTimeIn = json['LogTimeIn'];
    logTimeOut = json['LogTimeOut'];
    isLogIn = json['IsLogIn'];
    isLogFromPhone = json['IsLogFromPhone'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    locationDescription = json['LocationDescription'];
    remark = json['Remark'];
    isLate = json['IsLate'];
    isEarlyOut = json['IsEarlyOut'];
    isHalfDay = json['IsHalfDay'];
    isExtremeLate = json['IsExtremeLate'];
    isExtremeEarlyOut = json['IsExtremeEarlyOut'];
    latitudeOut = json['LatitudeOut'].toInt();
    longitudeOut = json['LongitudeOut'].toInt();
    locationDescriptionOut = json['LocationDescriptionOut'];
    batteryStatus = json['BatteryStatus'];
    absent = json['Absent'];
    onLeave = json['OnLeave'];
    workingDays = json['WorkingDays'];
    onTime = json['OnTime'];
    token = json['Token'];
    active = json['Active'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    updatedBy = json['UpdatedBy'];
    updatedOn = json['UpdatedOn'];
    isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeId'] = this.employeeId;
    data['LogTimeIn'] = this.logTimeIn;
    data['LogTimeOut'] = this.logTimeOut;
    data['IsLogIn'] = this.isLogIn;
    data['IsLogFromPhone'] = this.isLogFromPhone;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['LocationDescription'] = this.locationDescription;
    data['Remark'] = this.remark;
    data['IsLate'] = this.isLate;
    data['IsEarlyOut'] = this.isEarlyOut;
    data['IsHalfDay'] = this.isHalfDay;
    data['IsExtremeLate'] = this.isExtremeLate;
    data['IsExtremeEarlyOut'] = this.isExtremeEarlyOut;
    data['LatitudeOut'] = this.latitudeOut;
    data['LongitudeOut'] = this.longitudeOut;
    data['LocationDescriptionOut'] = this.locationDescriptionOut;
    data['BatteryStatus'] = this.batteryStatus;
    data['Absent'] = this.absent;
    data['OnLeave'] = this.onLeave;
    data['WorkingDays'] = this.workingDays;
    data['OnTime'] = this.onTime;
    data['Token'] = this.token;
    data['Active'] = this.active;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedOn'] = this.updatedOn;
    data['IsDeleted'] = this.isDeleted;
    return data;
  }
}

