// To parse this JSON data, do
//
//     final taskUpdateModel = taskUpdateModelFromJson(jsonString);

import 'dart:convert';

TaskUpdateModel taskUpdateModelFromJson(String str) => TaskUpdateModel.fromJson(json.decode(str));

String taskUpdateModelToJson(TaskUpdateModel data) => json.encode(data.toJson());

class TaskUpdateModel {
  TaskUpdateModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  Result? result;
  bool? isSuccess;

  factory TaskUpdateModel.fromJson(Map<String, dynamic> json) => TaskUpdateModel(
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
    this.taskShareList,
    this.taskContactList,
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
  Task? taskShare;
  Task? taskContact;
  String? token;
  List<int>? taskShareList;
  List<int>? taskContactList;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
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
    taskShare: Task.fromJson(json["TaskShare"]),
    taskContact: Task.fromJson(json["TaskContact"]),
    token: json["Token"],
    taskShareList: List<int>.from(json["TaskShareList"].map((x) => x)),
    taskContactList: List<int>.from(json["TaskContactList"].map((x) => x)),
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
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
    "TaskShare": taskShare!.toJson(),
    "TaskContact": taskContact!.toJson(),
    "Token": token,
    "TaskShareList": List<dynamic>.from(taskShareList!.map((x) => x)),
    "TaskContactList": List<dynamic>.from(taskContactList!.map((x) => x)),
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}

class Task {
  Task({
    this.list,
    this.selectedIds,
    this.selectedlongIds,
  });

  List<ListElement>? list;
  List<int>? selectedIds;
  List<int>? selectedlongIds;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
    selectedIds: List<int>.from(json["SelectedIds"].map((x) => x)),
    selectedlongIds: List<int>.from(json["SelectedlongIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "List": List<dynamic>.from(list!.map((x) => x.toJson())),
    "SelectedIds": List<dynamic>.from(selectedIds!.map((x) => x)),
    "SelectedlongIds": List<dynamic>.from(selectedlongIds!.map((x) => x)),
  };
}

class ListElement {
  ListElement({
    this.id,
    this.name,
    this.selectedIds,
    this.selectedlongIds,
  });

  int? id;
  String? name;
  List<int>? selectedIds;
  List<int>? selectedlongIds;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["Id"],
    name: json["Name"],
    selectedIds: List<int>.from(json["SelectedIds"].map((x) => x)),
    selectedlongIds: List<int>.from(json["SelectedlongIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "SelectedIds": List<dynamic>.from(selectedIds!.map((x) => x)),
    "SelectedlongIds": List<dynamic>.from(selectedlongIds!.map((x) => x)),
  };
}
