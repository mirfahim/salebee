// To parse this JSON data, do
//
//     final addTaskResponseModel = addTaskResponseModelFromJson(jsonString);

import 'dart:convert';

AddTaskResponseModel addTaskResponseModelFromJson(String str) => AddTaskResponseModel.fromJson(json.decode(str));

String addTaskResponseModelToJson(AddTaskResponseModel data) => json.encode(data.toJson());

class AddTaskResponseModel {
  AddTaskResponseModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  Result? result;
  bool? isSuccess;

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) => AddTaskResponseModel(
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
    this.taskId,
    this.type,
    this.title,
    this.taskDesc,
    this.notes,
    this.prospectId,
    this.leadId,
    this.supportId,
    this.startDate,
    this.startTime,
    this.dueDate,
    this.dueTime,
    this.reminderDate,
    this.reminderDays,
    this.reminderHour,
    this.reminderMinutes,
    this.repeat,
    this.assignedTo,
    this.priority,
    this.statusId,
    this.followUpId,
    this.isViewed,
    this.statusUpdateDate,
    this.statusUpdateBy,
    this.taskShare,
    this.taskContact,
    this.token,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? taskId;
  int? type;
  String? title;
  String? taskDesc;
  String? notes;
  int? prospectId;
  int? leadId;
  int? supportId;
  DateTime? startDate;
  dynamic startTime;
  DateTime? dueDate;
  dynamic dueTime;
  DateTime? reminderDate;
  int? reminderDays;
  int? reminderHour;
  int? reminderMinutes;
  int? repeat;
  int? assignedTo;
  int? priority;
  int? statusId;
  int? followUpId;
  bool? isViewed;
  DateTime? statusUpdateDate;
  int? statusUpdateBy;
  var taskShare;
  var taskContact;
  String? token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool? isDeleted;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    taskId: json["TaskID"],
    type: json["Type"],
    title: json["Title"],
    taskDesc: json["TaskDesc"],
    notes: json["Notes"],
    prospectId: json["ProspectId"],
    leadId: json["LeadID"],
    supportId: json["SupportID"],
    startDate: DateTime.parse(json["StartDate"]),
    startTime: json["StartTime"],
    dueDate: DateTime.parse(json["DueDate"]),
    dueTime: json["DueTime"],
    reminderDate: DateTime.parse(json["ReminderDate"]),
    reminderDays: json["ReminderDays"],
    reminderHour: json["ReminderHour"],
    reminderMinutes: json["ReminderMinutes"],
    repeat: json["Repeat"],
    assignedTo: json["AssignedTo"],
    priority: json["Priority"],
    statusId: json["StatusId"],
    followUpId: json["FollowUpID"],
    isViewed: json["IsViewed"],
    statusUpdateDate: DateTime.parse(json["StatusUpdateDate"]),
    statusUpdateBy: json["StatusUpdateBy"],
    taskShare: json["TaskShare"],
    taskContact: json["TaskContact"],
    token: json["Token"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "Type": type,
    "Title": title,
    "TaskDesc": taskDesc,
    "Notes": notes,
    "ProspectId": prospectId,
    "LeadID": leadId,
    "SupportID": supportId,
    "StartDate": startDate!.toIso8601String(),
    "StartTime": startTime,
    "DueDate": dueDate!.toIso8601String(),
    "DueTime": dueTime,
    "ReminderDate": reminderDate!.toIso8601String(),
    "ReminderDays": reminderDays,
    "ReminderHour": reminderHour,
    "ReminderMinutes": reminderMinutes,
    "Repeat": repeat,
    "AssignedTo": assignedTo,
    "Priority": priority,
    "StatusId": statusId,
    "FollowUpID": followUpId,
    "IsViewed": isViewed,
    "StatusUpdateDate": statusUpdateDate!.toIso8601String(),
    "StatusUpdateBy": statusUpdateBy,
    "TaskShare": taskShare,
    "TaskContact": taskContact,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}
