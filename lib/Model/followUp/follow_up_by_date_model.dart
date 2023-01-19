// To parse this JSON data, do
//
//     final getFollowupListModel = getFollowupListModelFromJson(jsonString);

import 'dart:convert';

GetFollowupListModelByDate getFollowupListModelByDateFromJson(String str) => GetFollowupListModelByDate.fromJson(json.decode(str));

String getFollowupListModelToJson(GetFollowupListModelByDate? data) => json.encode(data!.toJson());

class GetFollowupListModelByDate {
  GetFollowupListModelByDate({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  Result? result;
  bool? isSuccess;

  factory GetFollowupListModelByDate.fromJson(Map<String, dynamic> json) => GetFollowupListModelByDate(
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
    this.call,
    this.message,
    this.meeting,
    this.visit,
    this.others,
    this.email,
    this.sms,
    this.file,
  });

  List<Call?>? call;
  List<Call?>? message;
  List<Call?>? meeting;
  List<Call?>? visit;
  List<Call?>? others;
  List<Email?>? email;
  List<Sm?>? sms;
  List<FileElement?>? file;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    call: json["Call"] == null ? [] : List<Call?>.from(json["Call"]!.map((x) => Call.fromJson(x))),
    message: json["Message"] == null ? [] : List<Call?>.from(json["Message"]!.map((x) => Call.fromJson(x))),
    meeting: json["Meeting"] == null ? [] : List<Call?>.from(json["Meeting"]!.map((x) => Call.fromJson(x))),
    visit: json["Visit"] == null ? [] : List<Call?>.from(json["Visit"]!.map((x) => Call.fromJson(x))),
    others: json["Others"] == null ? [] : List<Call?>.from(json["Others"]!.map((x) => Call.fromJson(x))),
    email: json["Email"] == null ? [] : List<Email?>.from(json["Email"]!.map((x) => Email.fromJson(x))),
    sms: json["SMS"] == null ? [] : List<Sm?>.from(json["SMS"]!.map((x) => Sm.fromJson(x))),
    file: json["File"] == null ? [] : List<FileElement?>.from(json["File"]!.map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Call": call == null ? [] : List<dynamic>.from(call!.map((x) => x!.toJson())),
    "Message": message == null ? [] : List<dynamic>.from(message!.map((x) => x!.toJson())),
    "Meeting": meeting == null ? [] : List<dynamic>.from(meeting!.map((x) => x!.toJson())),
    "Visit": visit == null ? [] : List<dynamic>.from(visit!.map((x) => x!.toJson())),
    "Others": others == null ? [] : List<dynamic>.from(others!.map((x) => x!.toJson())),
    "Email": email == null ? [] : List<dynamic>.from(email!.map((x) => x!.toJson())),
    "SMS": sms == null ? [] : List<dynamic>.from(sms!.map((x) => x!.toJson())),
    "File": file == null ? [] : List<dynamic>.from(file!.map((x) => x!.toJson())),
  };
}

class Call {
  Call({
    this.titles,
    this.description,
    this.date,
    this.empName,
    this.prosID,
  });

  String? titles;
  String? description;
  DateTime? date;
  String? empName;
  int? prosID;

  factory Call.fromJson(Map<String, dynamic> json) => Call(
    titles: json["Title"],
    empName: json['EmployeeName'],
    prosID: json['ProspectaId'],
    description: json["Description"],
    date: DateTime.parse(json["Date"]),

  );

  Map<String, dynamic> toJson() => {
    "Title": titleValues.reverse![titles],
    "Description": description,
    "Date": date?.toIso8601String(),
    "EmployeeName" : empName,
    "ProspectaId" : prosID,
  };
}

enum Title { EMPTY, TITLE }

final titleValues = EnumValues({
  " ": Title.EMPTY,
  "": Title.TITLE
});

class Email {
  Email({
    this.id,
    this.prospectId,
    this.leadId,
    this.emailFrom,
    this.emailTo,
    this.emailCc,
    this.emailBcc,
    this.subject,
    this.body,
    this.filesOrginalName,
    this.filesStorgeName,
    this.failSendMail,
    this.prospectFollowupEmailContactPerson,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? prospectId;
  int? leadId;
  EmailFrom? emailFrom;
  String? emailTo;
  String? emailCc;
  String? emailBcc;
  String? subject;
  String? body;
  String? filesOrginalName;
  String? filesStorgeName;
  dynamic failSendMail;
  dynamic prospectFollowupEmailContactPerson;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool? isDeleted;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    id: json["Id"],
    prospectId: json["ProspectId"],
    leadId: json["LeadId"],
    emailFrom: emailFromValues!.map[json["Email_From"]],
    emailTo: json["Email_To"],
    emailCc: json["Email_CC"],
    emailBcc: json["Email_BCC"],
    subject: json["Subject"],
    body: json["Body"],
    filesOrginalName: json["Files_OrginalName"],
    filesStorgeName: json["Files_StorgeName"],
    failSendMail: json["FailSendMail"],
    prospectFollowupEmailContactPerson: json["ProspectFollowupEmailContactPerson"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProspectId": prospectId,
    "LeadId": leadId,
    "Email_From": emailFromValues.reverse![emailFrom],
    "Email_To": emailTo,
    "Email_CC": emailCc,
    "Email_BCC": emailBcc,
    "Subject": subject,
    "Body": body,
    "Files_OrginalName": filesOrginalName,
    "Files_StorgeName": filesStorgeName,
    "FailSendMail": failSendMail,
    "ProspectFollowupEmailContactPerson": prospectFollowupEmailContactPerson,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}

enum EmailFrom { CRM_SALEBEE_NET, CRM_PACIFICALBD_COM }

final emailFromValues = EnumValues({
  "crm@pacificalbd.com": EmailFrom.CRM_PACIFICALBD_COM,
  "crm@salebee.net": EmailFrom.CRM_SALEBEE_NET
});

class FileElement {
  FileElement({
    this.id,
    this.prospectId,
    this.leadId,
    this.remark,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? prospectId;
  int? leadId;
  String? remark;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool? isDeleted;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    id: json["Id"],
    prospectId: json["ProspectId"],
    leadId: json["LeadId"],
    remark: json["Remark"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProspectId": prospectId,
    "LeadId": leadId,
    "Remark": remark,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}

class Sm {
  Sm({
    this.id,
    this.prospectId,
    this.mobileNo,
    this.message,
    this.leadId,
    this.prospectFollowupSmsContactPersons,
    this.token,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? prospectId;
  String? mobileNo;
  String? message;
  int? leadId;
  dynamic prospectFollowupSmsContactPersons;
  dynamic token;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool? isDeleted;

  factory Sm.fromJson(Map<String, dynamic> json) => Sm(
    id: json["Id"],
    prospectId: json["ProspectId"],
    mobileNo: json["MobileNo"],
    message: json["Message"],
    leadId: json["LeadId"],
    prospectFollowupSmsContactPersons: json["ProspectFollowupSMSContactPersons"],
    token: json["Token"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProspectId": prospectId,
    "MobileNo": mobileNo,
    "Message": message,
    "LeadId": leadId,
    "ProspectFollowupSMSContactPersons": prospectFollowupSmsContactPersons,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
