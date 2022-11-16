// // To parse this JSON data, do
// //
// //     final foodExpenseModel = foodExpenseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// FoodExpenseModel foodExpenseModelFromJson(String str) => FoodExpenseModel.fromJson(json.decode(str));
//
// String foodExpenseModelToJson(FoodExpenseModel data) => json.encode(data.toJson());
//
// class FoodExpenseModel {
//   FoodExpenseModel({
//     this.message,
//     this.result,
//     this.isSuccess,
//   });
//
//   String message;
//   Result result;
//   bool isSuccess;
//
//   factory FoodExpenseModel.fromJson(Map<String, dynamic> json) => FoodExpenseModel(
//     message: json["Message"],
//     result: Result.fromJson(json["Result"]),
//     isSuccess: json["IsSuccess"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Message": message,
//     "Result": result.toJson(),
//     "IsSuccess": isSuccess,
//   };
// }
//
// class Result {
//   Result({
//     this.id,
//     this.mealType,
//     this.dishName,
//     this.expense,
//     this.expenseDate,
//     this.approvedBy,
//     this.attachment,
//     this.active,
//     this.createdBy,
//     this.createdOn,
//     this.updatedBy,
//     this.updatedOn,
//     this.token,
//   });
//
//   int id;
//   int mealType;
//   String dishName;
//   int expense;
//   DateTime expenseDate;
//   int approvedBy;
//   dynamic attachment;
//   bool active;
//   int createdBy;
//   DateTime createdOn;
//   int updatedBy;
//   DateTime updatedOn;
//   String token;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["Id"],
//     mealType: json["MealType"],
//     dishName: json["DishName"],
//     expense: json["Expense"],
//     expenseDate: DateTime.parse(json["ExpenseDate"]),
//     approvedBy: json["ApprovedBy"],
//     attachment: json["Attachment"],
//     active: json["Active"],
//     createdBy: json["CreatedBy"],
//     createdOn: DateTime.parse(json["CreatedOn"]),
//     updatedBy: json["UpdatedBy"],
//     updatedOn: DateTime.parse(json["UpdatedOn"]),
//     token: json["Token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Id": id,
//     "MealType": mealType,
//     "DishName": dishName,
//     "Expense": expense,
//     "ExpenseDate": expenseDate.toIso8601String(),
//     "ApprovedBy": approvedBy,
//     "Attachment": attachment,
//     "Active": active,
//     "CreatedBy": createdBy,
//     "CreatedOn": createdOn.toIso8601String(),
//     "UpdatedBy": updatedBy,
//     "UpdatedOn": updatedOn.toIso8601String(),
//     "Token": token,
//   };
// }
