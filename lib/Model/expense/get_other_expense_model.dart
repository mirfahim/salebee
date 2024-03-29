// To parse this JSON data, do
//
//     final getOtherExpenseModel = getOtherExpenseModelFromJson(jsonString);

import 'dart:convert';

GetOtherExpenseModel getOtherExpenseModelFromJson(String str) => GetOtherExpenseModel.fromJson(json.decode(str));

String getOtherExpenseModelToJson(GetOtherExpenseModel data) => json.encode(data.toJson());

class GetOtherExpenseModel {
  GetOtherExpenseModel({
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
  factory GetOtherExpenseModel.fromJson(Map<String, dynamic> json) => GetOtherExpenseModel(
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
    this.expenseName,
    this.description,
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

    this.person,
    this.prospectID

  });

  int? id;
  String? expenseName;
  String? description;
  double? expense;
  DateTime? expenseDate;
  int? approvedBy;
  var attachment;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  String? token;
  int? person;

  int? prospectID;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    expenseName: json["ExpenseName"] ?? "",
    description: json["Description"] ?? "",
    expense: json["Expense"] ?? 0.0,
    expenseDate: DateTime.parse(json["ExpenseDate"]) ?? DateTime.parse(json["CreatedOn"]),
    approvedBy: json["ApprovedBy"] ?? "",
    attachment: json["Attachment"] == null ? null : json["Attachment"],
    active: json["Active"],
    createdBy: json["CreatedBy"] ?? "",
    createdOn: DateTime.parse(json["CreatedOn"]) ,
    updatedBy: json["UpdatedBy"] ?? DateTime.parse(json["CreatedOn"]) ,
    updatedOn: json["UpdatedOn"] == null ? DateTime.parse(json["CreatedOn"]) : DateTime.parse(json["UpdatedOn"]),
    token: json["Token"] ?? "",
    prospectID: json["ProspectId"] == null ? 0 : json["ProspectId"],

    person: json["Person"] == null ? 1 : json["Person"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ExpenseName": expenseName,
    "Description": description,
    "Expense": expense,
    "ExpenseDate": expenseDate!.toIso8601String(),
    "ApprovedBy": approvedBy,
    "Attachment": attachment,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "Token": token,
    "ProspectId": prospectID,

    "Person": person
  };
}
