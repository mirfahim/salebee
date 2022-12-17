// To parse this JSON data, do
//
//     final getFoodExpenseModel = getFoodExpenseModelFromJson(jsonString);

import 'dart:convert';

GetFoodExpenseModel getFoodExpenseModelFromJson(String str) =>
    GetFoodExpenseModel.fromJson(json.decode(str));

String getFoodExpenseModelToJson(GetFoodExpenseModel data) =>
    json.encode(data.toJson());

class GetFoodExpenseModel {
  GetFoodExpenseModel({
    this.message,
    this.result,
    this.isSuccess,
  });
  // "Person": null,
  // "ProspectId": null,
  // "Description": null,
  String? message;
  List<Result>? result;
  bool? isSuccess;
  double totalCost() {
    return result!.fold(
        0,
        (previousValue, element) =>
            previousValue + element.expense!.toDouble());
  }

  factory GetFoodExpenseModel.fromJson(Map<String, dynamic> json) =>
      GetFoodExpenseModel(
        message: json["Message"],
        result:
            List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
        isSuccess: json["IsSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "IsSuccess": isSuccess,
      };
}

class Result {
  Result(
      {this.id,
      this.mealType,
      this.dishName,
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
      this.description,
      this.person,
      this.prospectID});

  int? id;
  int? mealType;
  var dishName;
  double? expense;
  DateTime? expenseDate;
  int? approvedBy;
  var attachment;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  int? person;
  String? description;
  int? prospectID;
  var token;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["Id"],
        mealType: json["MealType"],
        dishName: json["DishName"] ?? "no data",
        expense: json["Expense"],
        expenseDate: DateTime.parse(json["ExpenseDate"]),
        approvedBy: json["ApprovedBy"],
        attachment: json["Attachment"] == null ? "bg" : json["Attachment"],
        active: json["Active"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedBy: json["UpdatedBy"],
        updatedOn: DateTime.parse(json["UpdatedOn"]),
        token: json["Token"] == null ? "null" : json["Token"],
        prospectID: json["ProspectId"] == null ? 0 : json["ProspectId"],
        description: json["Description"] == null ? "No data" : json["Description"],
        person: json["Person"] == null ? 1 : json["Person"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "MealType": mealType,
        "DishName": dishName,
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
        "Description": description,
        "Person": person
      };
}
