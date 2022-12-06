// To parse this JSON data, do
//
//     final getProspectListModel = getProspectListModelFromJson(jsonString);

import 'dart:convert';

GetProspectListModel getProspectListModelFromJson(String str) => GetProspectListModel.fromJson(json.decode(str));

String getProspectListModelToJson(GetProspectListModel data) => json.encode(data.toJson());

class GetProspectListModel {
  GetProspectListModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetProspectListModel.fromJson(Map<String, dynamic> json) => GetProspectListModel(
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
    this.id,
    this.name,
    this.code,
    this.contactPersonName,
    this.contactNumber,
    this.designationName,
    this.email,
    this.emails,
    this.contactPersons,
    this.isIndividual,
    this.type,
  });

  int? id;
  String? name;
  String? code;
  String? contactPersonName;
  String? contactNumber;
  String? designationName;
  String? email;
  String? emails;
  String? contactPersons;
  bool? isIndividual;
  dynamic type;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    name: json["Name"],
    code: json["Code"] == null ? null : json["Code"],
    contactPersonName: json["ContactPersonName"],
    contactNumber: json["ContactNumber"],
    designationName: json["DesignationName"] == null ? null : json["DesignationName"],
    email: json["Email"] == null ? null : json["Email"],
    emails: json["Emails"] == null ? null : json["Emails"],
    contactPersons: json["ContactPersons"] == null ? null : json["ContactPersons"],
    isIndividual: json["IsIndividual"],
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Code": code == null ? null : code,
    "ContactPersonName": contactPersonName == null ? null : contactPersonNameValues.reverse[contactPersonName],
    "ContactNumber": contactNumber == null ? null : contactNumberValues.reverse[contactNumber],
    "DesignationName": designationName == null ? null : designationName,
    "Email": email == null ? null : email,
    "Emails": emails == null ? null : emails,
    "ContactPersons": contactPersons == null ? null : contactPersons,
    "IsIndividual": isIndividual,
    "Type": type,
  };
}

enum ContactNumber { BR, HOTLINE_NUMBER_BR_01800000000, HOTLINE_NUMBER_BR_01900000000, MD_ABU_SALEH_BR_01900000000, MD_SAKIB_BR_0197800340, MD_KASHEM_BR_01600000001, SIRAJ_D_KHAN_BR_1711531477, NAJIUR_RAHMAN_BR_1714143514, CONTACT_PERSON_X_BR_000000, CONTACT_PERSON_X_BR, THE_00000000 }

final contactNumberValues = EnumValues({
  "<br/>": ContactNumber.BR,
  "contact person x<br/>": ContactNumber.CONTACT_PERSON_X_BR,
  "contact person x<br/>000000": ContactNumber.CONTACT_PERSON_X_BR_000000,
  "Hotline Number<br/>01800000000": ContactNumber.HOTLINE_NUMBER_BR_01800000000,
  "Hotline Number<br/>01900000000": ContactNumber.HOTLINE_NUMBER_BR_01900000000,
  "Md Abu Saleh<br/>01900000000": ContactNumber.MD_ABU_SALEH_BR_01900000000,
  "MD Kashem<br/>01600000001": ContactNumber.MD_KASHEM_BR_01600000001,
  "MD Sakib<br/>0197800340": ContactNumber.MD_SAKIB_BR_0197800340,
  "Najiur Rahman<br/>1714143514": ContactNumber.NAJIUR_RAHMAN_BR_1714143514,
  "Siraj D.Khan<br/>1711531477": ContactNumber.SIRAJ_D_KHAN_BR_1711531477,
  "00000000": ContactNumber.THE_00000000
});

enum ContactPersonName { HOTLINE_NUMBER, MD_ABU_SALEH, MD_SAKIB, MD_KASHEM, SIRAJ_D_KHAN, NAJIUR_RAHMAN, CONTACT_PERSON_X }

final contactPersonNameValues = EnumValues({
  "contact person x": ContactPersonName.CONTACT_PERSON_X,
  "Hotline Number": ContactPersonName.HOTLINE_NUMBER,
  "Md Abu Saleh": ContactPersonName.MD_ABU_SALEH,
  "MD Kashem": ContactPersonName.MD_KASHEM,
  "MD Sakib": ContactPersonName.MD_SAKIB,
  "Najiur Rahman": ContactPersonName.NAJIUR_RAHMAN,
  "Siraj D.Khan": ContactPersonName.SIRAJ_D_KHAN
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
