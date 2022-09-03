// To parse this JSON data, do
//
//     final getAssignedTaskModel = getAssignedTaskModelFromJson(jsonString);

import 'dart:convert';

GetAssignedTaskModel getAssignedTaskModelFromJson(String str) => GetAssignedTaskModel.fromJson(json.decode(str));

String getAssignedTaskModelToJson(GetAssignedTaskModel data) => json.encode(data.toJson());

class GetAssignedTaskModel {
  GetAssignedTaskModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAssignedTaskModel.fromJson(Map<String, dynamic> json) => GetAssignedTaskModel(
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
    this.taskId,
    this.createdOn,
    this.createdBy,
    this.title,
    this.assignedTo,
    this.assignedPerson,
    this.taskDesc,
    this.statusId,
    this.dueDate,
    this.type,
    this.taskType,
    this.allStatus,
    this.priorityName,
    this.priority,
    this.prospectName,
    this.prospectId,
    this.prospectStatus,
    this.isIndividual,
    this.prospectNumber,
    this.statusUpdateDate,
    this.leadName,
    this.doneOrder,
    this.contact,
    this.taskShares,
    this.canDelete,
    this.overDueOrder,
    this.isProspectActive,
    this.createdByName,
  });

  int? taskId;
  DateTime? createdOn;
  int? createdBy;
  String? title;
  int? assignedTo;
  String? assignedPerson;
  String? taskDesc;
  int? statusId;
  DateTime? dueDate;
  int? type;
  String? taskType;
  String? allStatus;
  String? priorityName;
  int? priority;
  String? prospectName;
  int? prospectId;
  bool? prospectStatus;
  bool? isIndividual;
  String? prospectNumber;
  DateTime? statusUpdateDate;
  String? leadName;
  int? doneOrder;
  String? contact;
  String? taskShares;
  bool? canDelete;
  int? overDueOrder;
  String? isProspectActive;
  String? createdByName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    taskId: json["TaskID"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
    title: json["Title"],
    assignedTo: json["AssignedTo"],
    assignedPerson: json["AssignedPerson"],
    taskDesc: json["TaskDesc"],
    statusId: json["StatusId"],
    dueDate: DateTime.parse(json["DueDate"]),
    type: json["Type"],
    taskType: json["TaskType"],
    allStatus: json["AllStatus"],
    priorityName: json["PriorityName"],
    priority: json["Priority"],
    prospectName: json["ProspectName"],
    prospectId: json["ProspectId"],
    prospectStatus: json["ProspectStatus"],
    isIndividual: json["IsIndividual"],
    prospectNumber: json["ProspectNumber"],
    statusUpdateDate: json["StatusUpdateDate"] == null ? null : DateTime.parse(json["StatusUpdateDate"]),
    leadName: json["LeadName"],
    doneOrder: json["DoneOrder"],
    contact: json["Contact"],
    taskShares: json["TaskShares"],
    canDelete: json["CanDelete"],
    overDueOrder: json["OverDueOrder"],
    isProspectActive: json["IsProspectActive"],
    createdByName: json["CreatedByName"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "CreatedOn": createdOn!.toIso8601String(),
    "CreatedBy": createdBy,
    "Title": title,
    "AssignedTo": assignedTo,
    "AssignedPerson": assignedPerson,
    "TaskDesc": taskDesc,
    "StatusId": statusId,
    "DueDate": dueDate!.toIso8601String(),
    "Type": type,
    "TaskType": taskType,
    "AllStatus": allStatus,
    "PriorityName": priorityName,
    "Priority": priority,
    "ProspectName": prospectName,
    "ProspectId": prospectId,
    "ProspectStatus": prospectStatus,
    "IsIndividual": isIndividual,
    "ProspectNumber": prospectNumber,
    "StatusUpdateDate": statusUpdateDate == null ? null : statusUpdateDate!.toIso8601String(),
    "LeadName": leadName,
    "DoneOrder": doneOrder,
    "Contact": contact,
    "TaskShares": taskShares,
    "CanDelete": canDelete,
    "OverDueOrder": overDueOrder,
    "IsProspectActive": isProspectActive,
    "CreatedByName": createdByName,
  };
}
