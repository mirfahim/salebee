// To parse this JSON data, do
//
//     final getAllTaskModel = getAllTaskModelFromJson(jsonString);

import 'dart:convert';

GetAllTaskModel getAllTaskModelFromJson(String str) => GetAllTaskModel.fromJson(json.decode(str));

String getAllTaskModelToJson(GetAllTaskModel data) => json.encode(data.toJson());

class GetAllTaskModel {
  GetAllTaskModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAllTaskModel.fromJson(Map<String, dynamic> json) => GetAllTaskModel(
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
  AssignedPerson? assignedPerson;
  String? taskDesc;
  int? statusId;
  DateTime? dueDate;
  int? type;
  TaskType? taskType;
  String? allStatus;
  PriorityName? priorityName;
  int? priority;
  String? prospectName;
  int? prospectId;
  bool? prospectStatus;
  bool? isIndividual;
  ProspectNumber? prospectNumber;
  DateTime? statusUpdateDate;
  String? leadName;
  int? doneOrder;
  String? contact;
  String? taskShares;
  bool? canDelete;
  int? overDueOrder;
  IsProspectActive? isProspectActive;
  AssignedPerson? createdByName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    taskId: json["TaskID"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
    title: json["Title"],
    assignedTo: json["AssignedTo"],
    assignedPerson: assignedPersonValues.map[json["AssignedPerson"]],
    taskDesc: json["TaskDesc"],
    statusId: json["StatusId"],
    dueDate: DateTime.parse(json["DueDate"]),
    type: json["Type"],
    taskType: taskTypeValues.map[json["TaskType"]],
    allStatus: json["AllStatus"],
    priorityName: priorityNameValues.map[json["PriorityName"]],
    priority: json["Priority"],
    prospectName: json["ProspectName"],
    prospectId: json["ProspectId"],
    prospectStatus: json["ProspectStatus"] == null ? null : json["ProspectStatus"],
    isIndividual: json["IsIndividual"] == null ? null : json["IsIndividual"],
    prospectNumber: prospectNumberValues.map[json["ProspectNumber"]],
    statusUpdateDate: json["StatusUpdateDate"] == null ? null : DateTime.parse(json["StatusUpdateDate"]),
    leadName: json["LeadName"],
    doneOrder: json["DoneOrder"],
    contact: json["Contact"],
    taskShares: json["TaskShares"],
    canDelete: json["CanDelete"],
    overDueOrder: json["OverDueOrder"],
    isProspectActive: isProspectActiveValues.map[json["IsProspectActive"]],
    createdByName: assignedPersonValues.map[json["CreatedByName"]],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "CreatedOn": createdOn!.toIso8601String(),
    "CreatedBy": createdBy,
    "Title": title,
    "AssignedTo": assignedTo,
    "AssignedPerson": assignedPersonValues.reverse[assignedPerson],
    "TaskDesc": taskDesc,
    "StatusId": statusId,
    "DueDate": dueDate!.toIso8601String(),
    "Type": type,
    "TaskType": taskTypeValues.reverse[taskType],
    "AllStatus": allStatus,
    "PriorityName": priorityNameValues.reverse[priorityName],
    "Priority": priority,
    "ProspectName": prospectName,
    "ProspectId": prospectId,
    "ProspectStatus": prospectStatus == null ? null : prospectStatus,
    "IsIndividual": isIndividual == null ? null : isIndividual,
    "ProspectNumber": prospectNumberValues.reverse[prospectNumber],
    "StatusUpdateDate": statusUpdateDate == null ? null : statusUpdateDate!.toIso8601String(),
    "LeadName": leadName,
    "DoneOrder": doneOrder,
    "Contact": contact,
    "TaskShares": taskShares,
    "CanDelete": canDelete,
    "OverDueOrder": overDueOrder,
    "IsProspectActive": isProspectActiveValues.reverse[isProspectActive],
    "CreatedByName": assignedPersonValues.reverse[createdByName],
  };
}

enum AssignedPerson { EMPTY, MEPLOYEE_NAME_1, MEPLOYEE_NAME_79, MEPLOYEE_NAME_2121, MEPLOYEE_NAME_1114, MEPLOYEE_NAME_92, MEPLOYEE_NAME_114, MEPLOYEE_NAME_85, MEPLOYEE_NAME_88, MEPLOYEE_NAME_113, MEPLOYEE_NAME_91, MEPLOYEE_NAME_94, MEPLOYEE_NAME_82, MEPLOYEE_NAME_105, MEPLOYEE_NAME_101, MEPLOYEE_NAME_81, MEPLOYEE_NAME_102, MEPLOYEE_NAME_87, MEPLOYEE_NAME_83, MEPLOYEE_NAME_95, MEPLOYEE_NAME_86, MEPLOYEE_NAME_77, MEPLOYEE_NAME_104 }

final assignedPersonValues = EnumValues({
  "": AssignedPerson.EMPTY,
  "meployee name 1": AssignedPerson.MEPLOYEE_NAME_1,
  "meployee name 101": AssignedPerson.MEPLOYEE_NAME_101,
  "meployee name 102": AssignedPerson.MEPLOYEE_NAME_102,
  "meployee name 104": AssignedPerson.MEPLOYEE_NAME_104,
  "meployee name 105": AssignedPerson.MEPLOYEE_NAME_105,
  "meployee name 1114": AssignedPerson.MEPLOYEE_NAME_1114,
  "meployee name 113": AssignedPerson.MEPLOYEE_NAME_113,
  "meployee name 114": AssignedPerson.MEPLOYEE_NAME_114,
  "meployee name 2121": AssignedPerson.MEPLOYEE_NAME_2121,
  "meployee name 77": AssignedPerson.MEPLOYEE_NAME_77,
  "meployee name 79": AssignedPerson.MEPLOYEE_NAME_79,
  "meployee name 81": AssignedPerson.MEPLOYEE_NAME_81,
  "meployee name 82": AssignedPerson.MEPLOYEE_NAME_82,
  "meployee name 83": AssignedPerson.MEPLOYEE_NAME_83,
  "meployee name 85": AssignedPerson.MEPLOYEE_NAME_85,
  "meployee name 86": AssignedPerson.MEPLOYEE_NAME_86,
  "meployee name 87": AssignedPerson.MEPLOYEE_NAME_87,
  "meployee name 88": AssignedPerson.MEPLOYEE_NAME_88,
  "meployee name 91": AssignedPerson.MEPLOYEE_NAME_91,
  "meployee name 92": AssignedPerson.MEPLOYEE_NAME_92,
  "meployee name 94": AssignedPerson.MEPLOYEE_NAME_94,
  "meployee name 95": AssignedPerson.MEPLOYEE_NAME_95
});

enum IsProspectActive { F, T }

final isProspectActiveValues = EnumValues({
  "F": IsProspectActive.F,
  "T": IsProspectActive.T
});

enum PriorityName { EMPTY, VERY_HIGH, NORMAL, HIGH, LOW }

final priorityNameValues = EnumValues({
  "": PriorityName.EMPTY,
  "High": PriorityName.HIGH,
  "Low": PriorityName.LOW,
  "Normal": PriorityName.NORMAL,
  "Very High": PriorityName.VERY_HIGH
});

enum ProspectNumber { EMPTY, THE_00000000 }

final prospectNumberValues = EnumValues({
  "": ProspectNumber.EMPTY,
  "00000000": ProspectNumber.THE_00000000
});

enum TaskType { ONLINE_MEETING, VISIT, CALL, MAIL, EMPTY }

final taskTypeValues = EnumValues({
  "Call": TaskType.CALL,
  "": TaskType.EMPTY,
  "Mail": TaskType.MAIL,
  "Online Meeting": TaskType.ONLINE_MEETING,
  "Visit": TaskType.VISIT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
