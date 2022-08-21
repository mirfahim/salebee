// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';
// List<ExpenseCategoryResponseModel> expenseCategoryResponseModelFromModel(dynamic str) =>
//     List<ExpenseCategoryResponseModel>.from(str.map((x) => ExpenseCategoryResponseModel.fromJson(x)));
LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
List<LoginResponseModel> loginModelFromJson(dynamic str) =>
    List<LoginResponseModel>.from(str.map((x) => LoginResponseModel.fromJson(x)));



String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.result,
    this.isSuccess,
    //kk
  });

  String? message;
   Result? result;
  bool? isSuccess;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    message: json["Message"],
    result: Result.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
}

class Result {
  Result({
    this.designation,
    this.dob,
    this.durationInMinute,
    this.employeeId,
    this.isViewAll,
    this.isViewAllLead,
    this.isViewAllProspect,
    this.isViewAllTask,
    this.password,
    this.searchDate,
    this.userFullName,
    this.userName,
    this.userProfileImageLink,
    this.userToken,
    this.active,
    this.id,
    this.menus,
  });

  String? designation;
  DateTime? dob;
  var durationInMinute;
  int? employeeId;
  bool? isViewAll;
  dynamic isViewAllLead;
  dynamic isViewAllProspect;
  dynamic isViewAllTask;
  dynamic password;
  DateTime? searchDate;
  String? userFullName;
  dynamic userName;
  String? userProfileImageLink;
  String? userToken;
  bool? active;
  int? id;
  List<Menu>? menus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    designation: json["Designation"],
    dob: DateTime.parse(json["DOB"]),
    durationInMinute: json["DurationInMinute"],
    employeeId: json["EmployeeId"],
    isViewAll: json["IsViewAll"],
    isViewAllLead: json["IsViewAllLead"],
    isViewAllProspect: json["IsViewAllProspect"],
    isViewAllTask: json["IsViewAllTask"],
    password: json["Password"],
    searchDate: DateTime.parse(json["SearchDate"]),
    userFullName: json["UserFullName"],
    userName: json["UserName"],
    userProfileImageLink: json["UserProfileImageLink"],
    userToken: json["UserToken"],
    active: json["Active"],
    id: json["Id"],
    menus: List<Menu>.from(json["Menus"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Designation": designation,
    "DOB": dob!.toIso8601String(),
    "DurationInMinute": durationInMinute,
    "EmployeeId": employeeId,
    "IsViewAll": isViewAll,
    "IsViewAllLead": isViewAllLead,
    "IsViewAllProspect": isViewAllProspect,
    "IsViewAllTask": isViewAllTask,
    "Password": password,
    "SearchDate": searchDate!.toIso8601String(),
    "UserFullName": userFullName,
    "UserName": userName,
    "UserProfileImageLink": userProfileImageLink,
    "UserToken": userToken,
    "Active": active,
    "Id": id,
    "Menus": List<dynamic>.from(menus!.map((x) => x.toJson())),
  };
}

class Menu {
  Menu({
    this.id,
    this.label,
    this.action,
    this.controller,
    this.parentId,
    this.active,
    this.className,
    this.displayOrder,
    this.isAjaxEnable,
    this.uniqueName,
  });

  int? id;
  String? label;
  String? action;
  String? controller;
  int? parentId;
  bool? active;
  String? className;
  int? displayOrder;
  bool? isAjaxEnable;
  String? uniqueName;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["Id"],
    label: json["Label"],
    action: json["Action"] == null ? null : json["Action"],
    controller: json["Controller"] == null ? null : json["Controller"],
    parentId: json["ParentId"],
    active: json["Active"],
    className: json["ClassName"] == null ? null : json["ClassName"],
    displayOrder: json["DisplayOrder"] == null ? null : json["DisplayOrder"],
    isAjaxEnable: json["IsAjaxEnable"] == null ? null : json["IsAjaxEnable"],
    uniqueName: json["UniqueName"] == null ? null : json["UniqueName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Label": label,
    "Action": action == null ? null : action,
    "Controller": controller == null ? null : controller,
    "ParentId": parentId,
    "Active": active,
    "ClassName": className == null ? null : className,
    "DisplayOrder": displayOrder == null ? null : displayOrder,
    "IsAjaxEnable": isAjaxEnable == null ? null : isAjaxEnable,
    "UniqueName": uniqueName == null ? null : uniqueName,
  };
}


