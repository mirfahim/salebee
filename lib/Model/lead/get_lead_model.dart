// To parse this JSON data, do
//
//     final getLeadModel = getLeadModelFromJson(jsonString);

import 'dart:convert';

GetLeadModel getLeadModelFromJson(String str) => GetLeadModel.fromJson(json.decode(str));

String getLeadModelToJson(GetLeadModel data) => json.encode(data.toJson());

class GetLeadModel {
  GetLeadModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  String? message;
  List<LeadResult>? result;
  bool? isSuccess;

  factory GetLeadModel.fromJson(Map<String, dynamic> json) => GetLeadModel(
    message: json["Message"],
    result: List<LeadResult>.from(json["Result"].map((x) => LeadResult.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class LeadResult {
  LeadResult({
    required this.leadId,
    required this.createdDate,
    required this.assignedTo,
    required this.leadName,
    required this.prospectId,
    required this.items,
    required this.concernPerson,
    this.estimatedClosingAmount,
    required this.estimatedClosingDate,
    this.priority,
    this.stageId,
    this.stageName,
    required this.stageDate,
    required this.lastFollowup,
    required this.createdBy,
  });

  int? leadId;
  DateTime? createdDate;
  int? assignedTo;
  String? leadName;
  int? prospectId;
  List<Item>? items;
  List<ConcernPerson>? concernPerson;
  double? estimatedClosingAmount;
  DateTime? estimatedClosingDate;
  String? priority;
  int? stageId;
  String? stageName;
  DateTime? stageDate;
  List<LastFollowup>? lastFollowup;
  List<int>? createdBy;

  factory LeadResult.fromJson(Map<String, dynamic> json) => LeadResult(
    leadId: json["LeadId"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    assignedTo: json["AssignedTo"],
    leadName: json["LeadName"],
    prospectId: json["ProspectId"],
    items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
    concernPerson: List<ConcernPerson>.from(json["ConcernPerson"].map((x) => ConcernPerson.fromJson(x))),
    estimatedClosingAmount: json["EstimatedClosingAmount"],
    estimatedClosingDate: DateTime.parse(json["EstimatedClosingDate"]),
    priority: json["Priority"] == null ? "Normal" : json["Priority"],
    stageId: json["StageId"],
    stageName: json["StageName"],
    stageDate: DateTime.parse(json["StageDate"]),
    lastFollowup: List<LastFollowup>.from(json["LastFollowup"].map((x) => LastFollowup.fromJson(x))),
    createdBy: List<int>.from(json["CreatedBy"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "LeadId": leadId,
    "CreatedDate": createdDate!.toIso8601String(),
    "AssignedTo": assignedTo!,
    "LeadName": leadName!,
    "ProspectId": prospectId!,
    "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "ConcernPerson": List<dynamic>.from(concernPerson!.map((x) => x.toJson())),
    "EstimatedClosingAmount": estimatedClosingAmount,
    "EstimatedClosingDate": estimatedClosingDate!.toIso8601String(),
    "Priority": priority,
    "StageId": stageId,
    "StageName": stageName,
    "StageDate": stageDate!.toIso8601String(),
    "LastFollowup": List<dynamic>.from(lastFollowup!.map((x) => x.toJson())),
    "CreatedBy": List<dynamic>.from(createdBy!.map((x) => x)),
  };
}

class ConcernPerson {
  ConcernPerson({
    this.name,
    this.designation,
    this.mobile,
  });

  String? name;
  String? designation;
  String? mobile;

  factory ConcernPerson.fromJson(Map<String, dynamic> json) => ConcernPerson(
    name: json["Name"],
    designation: json["Designation"],
    mobile: json["Mobile"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Designation": designation,
    "Mobile": mobile,
  };
}

class Item {
  Item({
    required this.itemId,
  });

  int itemId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["ItemId"],
  );

  Map<String, dynamic> toJson() => {
    "ItemId": itemId,
  };
}

class LastFollowup {
  LastFollowup({
    required this.personId,
    required this.followupType,
    required this.date,
  });

  int personId;
  int followupType;
  DateTime date;

  factory LastFollowup.fromJson(Map<String, dynamic> json) => LastFollowup(
    personId: json["PersonId"],
    followupType: json["FollowupType"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "PersonId": personId,
    "FollowupType": followupType,
    "Date": date.toIso8601String(),
  };
}

enum Priority { HIGH, NORMAL, VERY_HIGH, LOW }

final priorityValues = EnumValues({
  "High": Priority.HIGH,
  "Low": Priority.LOW,
  "Normal": Priority.NORMAL,
  "Very High": Priority.VERY_HIGH
});

enum StageName { LEAD_LOST, FOLLOWUP, DEMO, LEAD_WON, NEW_LEAD, MEETING, NEGOTIATIONS, READY_TO_BUY, QUOTATION, FREE_TRIAL }

final stageNameValues = EnumValues({
  "Demo": StageName.DEMO,
  "Followup": StageName.FOLLOWUP,
  "Free Trial ": StageName.FREE_TRIAL,
  "Lead Lost": StageName.LEAD_LOST,
  "Lead Won": StageName.LEAD_WON,
  "Meeting": StageName.MEETING,
  "Negotiations": StageName.NEGOTIATIONS,
  "New Lead": StageName.NEW_LEAD,
  "Quotation": StageName.QUOTATION,
  "Ready to Buy": StageName.READY_TO_BUY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
