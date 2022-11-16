// To parse this JSON data, do
//
//     final prospectLeadandConcernModel = prospectLeadandConcernModelFromJson(jsonString);

import 'dart:convert';

ProspectLeadandConcernModel prospectLeadandConcernModelFromJson(String str) => ProspectLeadandConcernModel.fromJson(json.decode(str));

String prospectLeadandConcernModelToJson(ProspectLeadandConcernModel data) => json.encode(data.toJson());

class ProspectLeadandConcernModel {
  ProspectLeadandConcernModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory ProspectLeadandConcernModel.fromJson(Map<String, dynamic> json) => ProspectLeadandConcernModel(
    message: json["Message"],
    result: List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
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
    this.lead,
    this.contact,
    this.isIndividual,
  });

  List<Lead>? lead;
  List<Contact>? contact;
  bool? isIndividual;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    lead: List<Lead>.from(json["Lead"]!.map((x) => Lead.fromJson(x))),
    contact: List<Contact>.from(json["Contact"]!.map((x) => Contact.fromJson(x))),
    isIndividual: json["IsIndividual"],
  );

  Map<String, dynamic> toJson() => {
    "Lead": List<dynamic>.from(lead!.map((x) => x.toJson())),
    "Contact": List<dynamic>.from(contact!.map((x) => x.toJson())),
    "IsIndividual": isIndividual,
  };
}

class Contact {
  Contact({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}

class Lead {
  Lead({
    this.id,
    this.leadName,
  });

  int? id;
  String? leadName;

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    id: json["ID"],
    leadName: json["LeadName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "LeadName": leadName,
  };
}
