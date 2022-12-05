// To parse this JSON data, do
//
//     final getAssignedTaskModel = getAssignedTaskModelFromJson(jsonString);

import 'dart:convert';

GetAllMyTaskModel getAllMyTaskModelFromJson(String str) => GetAllMyTaskModel.fromJson(json.decode(str));

String getAllMyTaskModelModelToJson(GetAllMyTaskModel data) => json.encode(data.toJson());




class GetAllMyTaskModel {
  GetAllMyTaskModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAllMyTaskModel.fromJson(Map<String, dynamic> json) => GetAllMyTaskModel(
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
    this.contactPersonDetails,
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
  List<ContactPersonDetail>? contactPersonDetails;
  String? taskShares;
  bool? canDelete;
  int? overDueOrder;
  IsProspectActive? isProspectActive;
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
    priorityName:json["PriorityName"],
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
    contactPersonDetails: json["ContactPersonDetails"] == null ? null : List<ContactPersonDetail>.from(json["ContactPersonDetails"].map((x) => ContactPersonDetail.fromJson(x))),
    taskShares: json["TaskShares"],
    canDelete: json["CanDelete"],
    overDueOrder: json["OverDueOrder"],
    isProspectActive: isProspectActiveValues.map[json["IsProspectActive"]],
    createdByName: json["CreatedByName"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "CreatedOn": createdOn!.toIso8601String(),
    "CreatedBy": createdBy,
    "Title": title,
    "AssignedTo": assignedTo,
    "AssignedPerson":assignedPerson,
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
    "ContactPersonDetails": contactPersonDetails == null ? null : List<dynamic>.from(contactPersonDetails!.map((x) => x.toJson())),
    "TaskShares": taskShares,
    "CanDelete": canDelete,
    "OverDueOrder": overDueOrder,
    "IsProspectActive": isProspectActiveValues.reverse[isProspectActive],
    "CreatedByName": createdByName,
  };
}

enum AssignedPerson { MUHAMMAD_HASIBUR_RAHMAN }

final assignedPersonValues = EnumValues({
  "Muhammad Hasibur Rahman": AssignedPerson.MUHAMMAD_HASIBUR_RAHMAN
});

class ContactPersonDetail {
  ContactPersonDetail({
    this.contactpersonName,
    this.contactpersonDesignation,
    this.contactpersonMobile,
    this.contactpersonEmail,
  });

  String? contactpersonName;
  String? contactpersonDesignation;
  String? contactpersonMobile;
  String? contactpersonEmail;

  factory ContactPersonDetail.fromJson(Map<String, dynamic> json) => ContactPersonDetail(
    contactpersonName: json["ContactpersonName"],
    contactpersonDesignation: json["ContactpersonDesignation"],
    contactpersonMobile: json["ContactpersonMobile"],
    contactpersonEmail: json["ContactpersonEmail"],
  );

  Map<String, dynamic> toJson() => {
    "ContactpersonName": contactpersonName,
    "ContactpersonDesignation": contactpersonDesignation,
    "ContactpersonMobile": contactpersonMobile,
    "ContactpersonEmail": contactpersonEmail,
  };
}

enum CreatedByName { IRTISHAM_RAHMAN_OISHY, TASNIM_FERDOUSI, MD_RAYHAN_UDDEN, MOHAMMAD_KAMAL_HOSSAIN, SUPER_ADMIN, OLIULLAH_ASHRAFI }

final createdByNameValues = EnumValues({
  "Irtisham Rahman Oishy": CreatedByName.IRTISHAM_RAHMAN_OISHY,
  "Md. Rayhan Udden": CreatedByName.MD_RAYHAN_UDDEN,
  "Mohammad Kamal Hossain": CreatedByName.MOHAMMAD_KAMAL_HOSSAIN,
  "Oliullah Ashrafi": CreatedByName.OLIULLAH_ASHRAFI,
  "Super admin": CreatedByName.SUPER_ADMIN,
  "Tasnim Ferdousi": CreatedByName.TASNIM_FERDOUSI
});

enum IsProspectActive { T }

final isProspectActiveValues = EnumValues({
  "T": IsProspectActive.T
});

enum PriorityName { VERY_HIGH, NORMAL }

final priorityNameValues = EnumValues({
  "Normal": PriorityName.NORMAL,
  "Very High": PriorityName.VERY_HIGH
});

enum TaskType { CALL, MAIL, VISIT, ONLINE_MEETING }

final taskTypeValues = EnumValues({
  "Call": TaskType.CALL,
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

