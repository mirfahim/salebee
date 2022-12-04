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
  });

  int? id;
  String? expenseName;
  String? description;
  double? expense;
  DateTime? expenseDate;
  int? approvedBy;
  dynamic attachment;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  dynamic token;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    expenseName: json["ExpenseName"] ?? "",
    description: json["Description"] ?? "",
    expense: json["Expense"] ?? 0,
    expenseDate: DateTime.parse(json["ExpenseDate"]) ,
    approvedBy: json["ApprovedBy"] ?? "",
    attachment: json["Attachment"] ?? "",
    active: json["Active"],
    createdBy: json["CreatedBy"] ?? "",
    createdOn: DateTime.parse(json["CreatedOn"]) ,
    updatedBy: json["UpdatedBy"] == null ? null :  json["UpdatedBy"] ,
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    token: json["Token"] ?? "",
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
  };
}
