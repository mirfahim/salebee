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
  Contact? contact;
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
    priorityName: json["PriorityName"],
    priority: json["Priority"],
    prospectName: json["ProspectName"],
    prospectId: json["ProspectId"],
    prospectStatus: json["ProspectStatus"] == null ? null : json["ProspectStatus"],
    isIndividual: json["IsIndividual"] == null ? null : json["IsIndividual"],
    prospectNumber: json["ProspectNumber"],
    statusUpdateDate: json["StatusUpdateDate"] == null ? null : DateTime.parse(json["StatusUpdateDate"]),
    leadName: json["LeadName"],
    doneOrder: json["DoneOrder"],
    contact: contactValues.map[json["Contact"]],
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
    "AssignedPerson": assignedPerson,
    "TaskDesc": taskDesc,
    "StatusId": statusId,
    "DueDate": dueDate!.toIso8601String(),
    "Type": type,
    "TaskType": taskType,
    "AllStatus": allStatus,
    "PriorityName":priorityName,
    "Priority": priority,
    "ProspectName": prospectName,
    "ProspectId": prospectId,
    "ProspectStatus": prospectStatus == null ? null : prospectStatus,
    "IsIndividual": isIndividual == null ? null : isIndividual,
    "ProspectNumber": prospectNumber,
    "StatusUpdateDate": statusUpdateDate == null ? null : statusUpdateDate!.toIso8601String(),
    "LeadName": leadName,
    "DoneOrder": doneOrder,
    "Contact": contactValues.reverse[contact],
    "ContactPersonDetails": contactPersonDetails == null ? null : List<dynamic>.from(contactPersonDetails!.map((x) => x.toJson())),
    "TaskShares": taskShares,
    "CanDelete": canDelete,
    "OverDueOrder": overDueOrder,
    "IsProspectActive": isProspectActiveValues.reverse[isProspectActive],
    "CreatedByName": createdByName,
  };
}

enum AssignedPerson { SUPERADMIN, MD_KAMAL_HOSSAIN, MD_ZIAUL_OSMAN, EMPTY, HASIBUR, RAYHAN }

final assignedPersonValues = EnumValues({
  "": AssignedPerson.EMPTY,
  "Hasibur": AssignedPerson.HASIBUR,
  "Md. Kamal Hossain": AssignedPerson.MD_KAMAL_HOSSAIN,
  "Md. Ziaul Osman": AssignedPerson.MD_ZIAUL_OSMAN,
  "Rayhan": AssignedPerson.RAYHAN,
  "Superadmin": AssignedPerson.SUPERADMIN
});

enum Contact { THE_163349_MD_ABU_SALEH_ADVISOR_01900000000_SAMPLE_MAIL_COM, EMPTY, THE_89_CONTACT_PERSON_X_GENERAL_MANAGER_000000_EMAIL_XX_COM, THE_150_CONTACT_PERSON_X_SR_EXECUTIVE_000000_EMAIL_XX_COM, THE_85_CONTACT_PERSON_X_HEAD_OF_SALES_000000_EMAIL_XX_COM }

final contactValues = EnumValues({
  "": Contact.EMPTY,
  "150,contact person x,Sr. Executive,000000,email@xx.com": Contact.THE_150_CONTACT_PERSON_X_SR_EXECUTIVE_000000_EMAIL_XX_COM,
  "163349,Md Abu Saleh,Advisor,01900000000,sample@mail.com": Contact.THE_163349_MD_ABU_SALEH_ADVISOR_01900000000_SAMPLE_MAIL_COM,
  "85,contact person x,Head of Sales,000000,email@xx.com": Contact.THE_85_CONTACT_PERSON_X_HEAD_OF_SALES_000000_EMAIL_XX_COM,
  "89,contact person x,General manager,000000,email@xx.com": Contact.THE_89_CONTACT_PERSON_X_GENERAL_MANAGER_000000_EMAIL_XX_COM
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

enum IsProspectActive { T, F }

final isProspectActiveValues = EnumValues({
  "F": IsProspectActive.F,
  "T": IsProspectActive.T
});

enum LeadName { CRM_SOFTWARE, EMPTY, CRM }

final leadNameValues = EnumValues({
  "CRM": LeadName.CRM,
  "CRM Software": LeadName.CRM_SOFTWARE,
  "": LeadName.EMPTY
});

enum PriorityName { VERY_HIGH, NORMAL, EMPTY, VERY_LOW, LOW, HIGH }

final priorityNameValues = EnumValues({
  "": PriorityName.EMPTY,
  "High": PriorityName.HIGH,
  "Low": PriorityName.LOW,
  "Normal": PriorityName.NORMAL,
  "Very High": PriorityName.VERY_HIGH,
  "Very Low": PriorityName.VERY_LOW
});

enum ProspectName { ABC_ORGANIZATION, EMPTY, A_M_CLEAN_AIR_ENGINEERING_PRIVATE_LIMITED_NABILA, AIR_FREEZE_CORPORATION_NABILA, PROSPECT_NAME_1 }

final prospectNameValues = EnumValues({
  "ABC Organization": ProspectName.ABC_ORGANIZATION,
  "Air Freeze Corporation-Nabila": ProspectName.AIR_FREEZE_CORPORATION_NABILA,
  "A M Clean Air Engineering Private Limited-Nabila": ProspectName.A_M_CLEAN_AIR_ENGINEERING_PRIVATE_LIMITED_NABILA,
  "": ProspectName.EMPTY,
  "prospect name 1": ProspectName.PROSPECT_NAME_1
});

enum TaskType { CALL, VISIT, ONLINE_MEETING, EMPTY }

final taskTypeValues = EnumValues({
  "Call": TaskType.CALL,
  "": TaskType.EMPTY,
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
