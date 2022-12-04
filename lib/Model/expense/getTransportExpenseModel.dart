// To parse this JSON data, do
//
//     final getTransportExpenseModel = getTransportExpenseModelFromJson(jsonString);

import 'dart:convert';

GetTransportExpenseModel getTransportExpenseModelFromJson(String str) => GetTransportExpenseModel.fromJson(json.decode(str));

String getTransportExpenseModelToJson(GetTransportExpenseModel data) => json.encode(data.toJson());

class GetTransportExpenseModel {
  GetTransportExpenseModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;
  double totalCost() {
    return result!.fold(0, (previousValue, element) => previousValue + element.expense!.toDouble());
  }
  factory GetTransportExpenseModel.fromJson(Map<String, dynamic> json) => GetTransportExpenseModel(
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
    this.vehicleType,
    this.startLocation,
    this.endLocation,
    this.startTime,
    this.endTime,
    this.expense,
    this.expenseDate,
    this.approvedBy,
    this.attachment,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.token,
  });

  int? id;
  int? vehicleType;
  String? startLocation;
  String? endLocation;
  DateTime? startTime;
  DateTime? endTime;
  double? expense;
  DateTime? expenseDate;
  int? approvedBy;
  String? attachment;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  String? token;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    vehicleType: json["VehicleType"],
    startLocation: json["StartLocation"],
    endLocation: json["EndLocation"],
    startTime: DateTime.parse(json["StartTime"]),
    endTime: DateTime.parse(json["EndTime"]),
    expense: json["Expense"],
    expenseDate: DateTime.parse(json["ExpenseDate"]),
    approvedBy: json["ApprovedBy"],
    attachment: json["Attachment"] == null ? null : json["Attachment"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    token: json["Token"] == null ? null : json["Token"] ,
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "VehicleType": vehicleType,
    "StartLocation": startLocation,
    "EndLocation": endLocation,
    "StartTime": startTime!.toIso8601String(),
    "EndTime": endTime!.toIso8601String(),
    "Expense": expense,
    "ExpenseDate": expenseDate!.toIso8601String(),
    "ApprovedBy": approvedBy,
    "Attachment": attachment == null ? null : attachment,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "Token": token!,
  };
}
