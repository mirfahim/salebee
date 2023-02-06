// To parse this JSON data, do
//
//     final getAllProspectByIdtModel = getAllProspectByIdtModelFromJson(jsonString);

import 'dart:convert';

GetAllProspectByIdtModel getAllProspectByIdtModelFromJson(String str) => GetAllProspectByIdtModel.fromJson(json.decode(str));

String getAllProspectByIdtModelToJson(GetAllProspectByIdtModel? data) => json.encode(data!.toJson());

class GetAllProspectByIdtModel {
  GetAllProspectByIdtModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<ProspectResult>? result;
  bool? isSuccess;

  factory GetAllProspectByIdtModel.fromJson(Map<String, dynamic> json) => GetAllProspectByIdtModel(
    message: json["Message"],
    result: json["Result"] == null ? [] : List<ProspectResult>.from(json["Result"]!.map((x) => ProspectResult.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x!.toJson())),
    "IsSuccess": isSuccess,
  };
}

class ProspectResult {
  ProspectResult({
    this.id,
    this.prospectName,
    this.type,
    this.stage,
    this.isIndividual,
    this.industry,
    this.prospectFor,
    this.createdBy,
    this.createdOn,
    this.code,
    this.assignTo,
   this.lastFollowup,
    this.lastFollowupEmployeeId,
     this.concernPerson,
     this.importantNote,
     this.address,
     this.followupLogActivity,
     this.followupActivity,
     this.lat,
     this.lon,
    this.website,
    this.zone,
    // this.filter,
  });

  int? id;
  String? prospectName;
  Type? type;
  String? stage;
  String? website;
  String? zone;
  bool? isIndividual;
  String? industry;
  String? prospectFor;
  int? createdBy;
  DateTime? createdOn;
  String? code;
  int? assignTo;
  DateTime? lastFollowup;
  int? lastFollowupEmployeeId;
   List<ConcernPerson>? concernPerson;
   String? importantNote;
   String? address;
   FollowupLogActivity? followupLogActivity;
   FollowupActivity? followupActivity;
   double? lat;
   double? lon;
  // List<int?>? filter;

  factory ProspectResult.fromJson(Map<String, dynamic> json) => ProspectResult(
    id: json["Id"],
    prospectName: json["prospect_name"],
    type: typeValues!.map[json["Type"]],
    stage: json["Stage"] == null ? "No Data" : json["Stage"] ,
    website: json["Website"] == null ? "No Website" : json["Website"] ,
    zone: json["Zone"] == null ? "No Zone" : json["Zone"] ,
    isIndividual: json["IsIndividual"],
    industry: json["Industry"] == null ? "No data" :json["Industry"] ,
    prospectFor: json["prospect_for"] == null ? "No Data" : json["prospect_for"],
    createdBy: json["created_by"] == null ? 1 : json["created_by"],
    createdOn: json["created_on"] == null ? DateTime.now() :DateTime.parse(json["created_on"]),
    code: json["Code"] == null ? "jhi" : json["Code"],
    assignTo: json["assign_to"] == null ? 1 :  json["assign_to"],
    lastFollowup: json["last_followup"] == null ? DateTime.now() :DateTime.parse(json["last_followup"]),
    lastFollowupEmployeeId: json["last_followup_employee_id"] == null ? 1 :json["last_followup_employee_id"] ,
     concernPerson: json["concern_person"] == null ? [] : List<ConcernPerson>.from(json["concern_person"]!.map((x) => ConcernPerson.fromJson(x))),
     importantNote: json["important_note"] == null ? "No data" : json["important_note"],
     address: json["Address"] == "" ? "No Address" : json["Address"],
     followupLogActivity: FollowupLogActivity.fromJson(json["followup_log_activity"]),
     followupActivity: FollowupActivity.fromJson(json["followup_activity"]),
     lat: json["Lat"] == null ? 23.487845 :json["Lat"],
     lon: json["lon"] == null ? 230434 : json["lon"],
    // filter: json["filter"] == null ? [] : List<int?>.from(json["filter"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "prospect_name": prospectName,
    "Type": typeValues.reverse![type],
    "Stage": stage,
    "Website": website,
    "Zone": zone,
    "IsIndividual": isIndividual,
    "Industry": industry,
    "prospect_for": prospectFor,
    "created_by": createdBy,
    "created_on": createdOn?.toIso8601String(),
    "Code": code,
    "assign_to": assignTo,
    "last_followup": lastFollowup,
    "last_followup_employee_id": lastFollowupEmployeeId,
     "concern_person": concernPerson == null ? [] : List<dynamic>.from(concernPerson!.map((x) => x!.toJson())),
     "important_note": importantNote,
     "Address": address,
     "followup_log_activity": followupLogActivity!.toJson(),
     "followup_activity": followupActivity!.toJson(),
     "Lat": lat,
     "lon": lon,
    // "filter": filter == null ? [] : List<dynamic>.from(filter!.map((x) => x)),
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
    name: json["name"] == null ? "urwio" : json["name"],
    designation: json["designation"] == null ? "No Data" : json["designation"] ,
    mobile: json["mobile"]== null ? "No Data" : json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "designation": designation,
    "mobile": mobile,
  };
}

enum Name { SSD_S, HOTLINE_NUMBER, STRING, TEST, THE_01979800340, MD_ABU_SALEH, TEST_1, MD_SAKIB, MD_SAKIB123, MD_SAKIB1234, MD_KASHEM, SIRAJ_D_KHAN, NAJIUR_RAHMAN, PAUL_SEBASTIAN, AJAY_MANE, M_SAGAYARAJ, KARAN_SINGH_RATHORE_SALES_COORDINATOR, KARAN_ANTURKAR, KULDEEP_SINGH_THAKUR_OWNER, VINAYAK_NAIK, P_M_MAHENDIRAN_MANAGING_DIRECTOR, MR_SOUMIYA_SANKAR_RAY, HENA, CONTACT_PERSON_X }

final nameValues = EnumValues({
  "Ajay Mane": Name.AJAY_MANE,
  "contact person x": Name.CONTACT_PERSON_X,
  "hena": Name.HENA,
  "Hotline Number": Name.HOTLINE_NUMBER,
  "Karan Anturkar": Name.KARAN_ANTURKAR,
  "Karan Singh Rathore (Sales Coordinator)": Name.KARAN_SINGH_RATHORE_SALES_COORDINATOR,
  "Kuldeep Singh Thakur (Owner)": Name.KULDEEP_SINGH_THAKUR_OWNER,
  "Md Abu Saleh": Name.MD_ABU_SALEH,
  "MD Kashem": Name.MD_KASHEM,
  "MD Sakib": Name.MD_SAKIB,
  "MD Sakib123": Name.MD_SAKIB123,
  "MD Sakib1234": Name.MD_SAKIB1234,
  "Mr Soumiya Sankar Ray": Name.MR_SOUMIYA_SANKAR_RAY,
  "M. Sagayaraj": Name.M_SAGAYARAJ,
  "Najiur Rahman": Name.NAJIUR_RAHMAN,
  "Paul Sebastian": Name.PAUL_SEBASTIAN,
  "P.M Mahendiran (Managing Director)": Name.P_M_MAHENDIRAN_MANAGING_DIRECTOR,
  "Siraj D.Khan": Name.SIRAJ_D_KHAN,
  "ssdS": Name.SSD_S,
  "string": Name.STRING,
  "test": Name.TEST,
  "test 1": Name.TEST_1,
  "01979800340": Name.THE_01979800340,
  "Vinayak Naik": Name.VINAYAK_NAIK
});

class FollowupActivity {
  FollowupActivity({
    this.call,
    this.message,
    this.meeting,
    this.visit,
  });

  int? call;
  int? message;
  int? meeting;
  int? visit;

  factory FollowupActivity.fromJson(Map<String, dynamic> json) => FollowupActivity(
    call: json["Call"] == null ? 0 : json["Call"],
    message: json["Message"]== null? 0:json["Message"],
    meeting: json["Meeting"] == null? 0:   json["Meeting"],
    visit: json["Visit"] == null? 0 :json["Visit"],
  );

  Map<String, dynamic> toJson() => {
    "Call": call,
    "Message": message,
    "Meeting": meeting,
    "Visit": visit,
  };
}

class FollowupLogActivity {
  FollowupLogActivity({
    this.leadCount,
    this.quoteCount,
    this.orderCount,
  });

  int? leadCount;
  int? quoteCount;
  int? orderCount;

  factory FollowupLogActivity.fromJson(Map<String, dynamic> json) => FollowupLogActivity(
    leadCount: json["LeadCount"] == null ? 0 :  json["LeadCount"],
    quoteCount: json["QuoteCount"] == null ? 0:json["QuoteCount"],
    orderCount: json["OrderCount"] == null ? 0:json["OrderCount"],
  );

  Map<String, dynamic> toJson() => {
    "LeadCount": leadCount,
    "QuoteCount": quoteCount,
    "OrderCount": orderCount,
  };
}

enum Type { ORGANIZATION, INDIVIDUAL }

final typeValues = EnumValues({
  "Individual": Type.INDIVIDUAL,
  "Organization": Type.ORGANIZATION
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
