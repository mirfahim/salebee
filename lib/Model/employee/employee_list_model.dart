// To parse this JSON data, do
//
//     final AllEmployeeListModel = AllEmployeeListModelFromJson(jsonString);

import 'dart:convert';

AllEmployeeListModel AllEmployeeListModelFromJson(String str) => AllEmployeeListModel.fromJson(json.decode(str));

String AllEmployeeListModelToJson(AllEmployeeListModel data) => json.encode(data.toJson());

class AllEmployeeListModel {
  AllEmployeeListModel({
    this.message,
    this.results,
    this.isSuccess,s
  });

  String? message;
  List<Results>? results;
  bool? isSuccess;

  factory AllEmployeeListModel.fromJson(Map<String, dynamic> json) => AllEmployeeListModel(
    message: json["Message"],
    results: List<Results>.from(json["Result"].map((x) => Results.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(results!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class Results {
  Results({
    this.employeeDocuments,
    this.employeeId,
    this.employeeName,
    this.employeeUniqueId,
    this.otpNumber,
    this.designationId,
    this.departmentId,
    this.joiningDate,
    this.resignDate,
    this.shiftId,
    this.assignedZone,
    this.highestEducationDegree,
    this.nationalId,
    this.gender,
    this.nationality,
    this.religion,
    this.bloodGroup,
    this.dateOfBirth,
    this.birthDayGreetingsBy,
    this.emergencyContact,
    this.relationWithEmergrncyContct,
    this.emergencyContactPhone,
    this.emergencyContact2,
    this.relationWithEmergrncyContct2,
    this.emergencyContactPhone2,
    this.presentAddressThana,
    this.presentAddressDistrict,
    this.presentAddressDivision,
    this.presentAddress,
    this.presentAddressZone,
    this.permanentAddressThana,
    this.permanentAddressDistrict,
    this.permanentAddressDivision,
    this.permanentAddress,
    this.permanentAddressZone,
    this.fathersName,
    this.fathersPhone,
    this.mothersName,
    this.mothersPhone,
    this.maritalStatus,
    this.spouseName,
    this.spousePhone,
    this.createdBy,
    this.createdOn,
    this.active,
    this.isEmpActive,
    this.updatedBy,
    this.updatedOn,
    this.reportToEmpId,
    this.designationObj,
    this.departmentObj,
    this.profilePicturePath,
    this.profilePictureName,
    this.phoneNumbers,
    this.emailAddresses,
    this.faxes,
    this.employeeWebsites,
    this.socialNetworks,
    this.primaryEmail,
    this.empUserId,
    this.empUserName,
    this.employeeAttachment,
    this.canDelete,
  });

  List<EmployeeDocument>? employeeDocuments;
  int? employeeId;
  String? employeeName;
  String? employeeUniqueId;
  String? otpNumber;
  int? designationId;
  int? departmentId;
  DateTime? joiningDate;
  DateTime? resignDate;
  int? shiftId;
  int? assignedZone;
  int? highestEducationDegree;
  String? nationalId;
  int? gender;
  int? nationality;
  int? religion;
  int? bloodGroup;
  DateTime? dateOfBirth;
  String? birthDayGreetingsBy;
  String? emergencyContact;
  String? relationWithEmergrncyContct;
  String? emergencyContactPhone;
  String? emergencyContact2;
  String? relationWithEmergrncyContct2;
  String? emergencyContactPhone2;
  int? presentAddressThana;
  int? presentAddressDistrict;
  int? presentAddressDivision;
  String? presentAddress;
  int? presentAddressZone;
  int? permanentAddressThana;
  int? permanentAddressDistrict;
  int? permanentAddressDivision;
  String? permanentAddress;
  int? permanentAddressZone;
  String? fathersName;
  String? fathersPhone;
  String? mothersName;
  String? mothersPhone;
  int? maritalStatus;
  String? spouseName;
  String? spousePhone;
  int? createdBy;
  DateTime? createdOn;
  bool? active;
  bool? isEmpActive;
  int? updatedBy;
  DateTime? updatedOn;
  int? reportToEmpId;
  DesignationObj? designationObj;
  DepartmentObj? departmentObj;
  dynamic profilePicturePath;
  dynamic profilePictureName;
  String? phoneNumbers;
  String? emailAddresses;
  dynamic faxes;
  dynamic employeeWebsites;
  dynamic socialNetworks;
  String? primaryEmail;
  int? empUserId;
  dynamic empUserName;
  dynamic employeeAttachment;
  bool? canDelete;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    employeeDocuments: List<EmployeeDocument>.from(json["EmployeeDocuments"].map((x) => EmployeeDocument.fromJson(x))),
    employeeId: json["EmployeeId"],
    employeeName: json["EmployeeName"],
    employeeUniqueId: json["EmployeeUniqueID"],
    otpNumber: json["OtpNumber"] == null ? null : json["OtpNumber"],
    designationId: json["DesignationId"],
    departmentId: json["DepartmentId"],
    joiningDate: json["JoiningDate"] == null ? null : DateTime.parse(json["JoiningDate"]),
    resignDate: json["ResignDate"],
    shiftId: json["ShiftId"],
    assignedZone: json["AssignedZone"],
    highestEducationDegree: json["HighestEducationDegree"],
    nationalId: json["NationalId"],
    gender: json["Gender"],
    nationality: json["Nationality"],
    religion: json["Religion"],
    bloodGroup: json["BloodGroup"],
    dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.parse(json["DateOfBirth"]),
    birthDayGreetingsBy: json["BirthDayGreetingsBy"],
    emergencyContact: json["EmergencyContact"],
    relationWithEmergrncyContct: json["RelationWithEmergrncyContct"],
    emergencyContactPhone: json["EmergencyContactPhone"],
    emergencyContact2: json["EmergencyContact2"] == null ? null : json["EmergencyContact2"],
    relationWithEmergrncyContct2: json["RelationWithEmergrncyContct2"] == null ? null : json["RelationWithEmergrncyContct2"],
    emergencyContactPhone2: json["EmergencyContactPhone2"] == null ? null : json["EmergencyContactPhone2"],
    presentAddressThana: json["PresentAddressThana"],
    presentAddressDistrict: json["PresentAddressDistrict"],
    presentAddressDivision: json["PresentAddressDivision"],
    presentAddress: json["PresentAddress"] == null ? null : json["PresentAddress"],
    presentAddressZone: json["PresentAddressZone"],
    permanentAddressThana: json["PermanentAddressThana"] == null ? null : json["PermanentAddressThana"],
    permanentAddressDistrict: json["PermanentAddressDistrict"] == null ? null : json["PermanentAddressDistrict"],
    permanentAddressDivision: json["PermanentAddressDivision"] == null ? null : json["PermanentAddressDivision"],
    permanentAddress: json["PermanentAddress"] == null ? null : json["PermanentAddress"],
    permanentAddressZone: json["PermanentAddressZone"] == null ? null : json["PermanentAddressZone"],
    fathersName: json["FathersName"],
    fathersPhone: json["FathersPhone"],
    mothersName: json["MothersName"],
    mothersPhone: json["MothersPhone"],
    maritalStatus: json["MaritalStatus"],
    spouseName: json["SpouseName"],
    spousePhone: json["SpousePhone"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    active: json["Active"],
    isEmpActive: json["IsEmpActive"],
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    reportToEmpId: json["ReportToEmpId"],
    designationObj: DesignationObj.fromJson(json["DesignationObj"]),
    departmentObj: DepartmentObj.fromJson(json["DepartmentObj"]),
    profilePicturePath: json["ProfilePicturePath"],
    profilePictureName: json["ProfilePictureName"],
    phoneNumbers: json["PhoneNumbers"],
    emailAddresses: json["EmailAddresses"],
    faxes: json["Faxes"],
    employeeWebsites: json["EmployeeWebsites"],
    socialNetworks: json["SocialNetworks"],
    primaryEmail: json["PrimaryEmail"],
    empUserId: json["EmpUserID"],
    empUserName: json["EmpUserName"],
    employeeAttachment: json["EmployeeAttachment"],
    canDelete: json["CanDelete"],
  );

  Map<String, dynamic> toJson() => {
    "EmployeeDocuments": List<dynamic>.from(employeeDocuments!.map((x) => x.toJson())),
    "EmployeeId": employeeId,
    "EmployeeName": employeeName,
    "EmployeeUniqueID": employeeUniqueId,
    "OtpNumber": otpNumber == null ? null : otpNumber,
    "DesignationId": designationId,
    "DepartmentId": departmentId,
    "JoiningDate": joiningDate == null ? null : joiningDate!.toIso8601String(),
    "ResignDate": resignDate,
    "ShiftId": shiftId,
    "AssignedZone": assignedZone,
    "HighestEducationDegree": highestEducationDegree,
    "NationalId": nationalId,
    "Gender": gender,
    "Nationality": nationality,
    "Religion": religion,
    "BloodGroup": bloodGroup,
    "DateOfBirth": dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
    "BirthDayGreetingsBy": birthDayGreetingsBy,
    "EmergencyContact": emergencyContact,
    "RelationWithEmergrncyContct": relationWithEmergrncyContct,
    "EmergencyContactPhone": emergencyContactPhone,
    "EmergencyContact2": emergencyContact2 == null ? null : emergencyContact2,
    "RelationWithEmergrncyContct2": relationWithEmergrncyContct2 == null ? null : relationWithEmergrncyContct2,
    "EmergencyContactPhone2": emergencyContactPhone2 == null ? null : emergencyContactPhone2,
    "PresentAddressThana": presentAddressThana,
    "PresentAddressDistrict": presentAddressDistrict,
    "PresentAddressDivision": presentAddressDivision,
    "PresentAddress": presentAddress == null ? null : presentAddress,
    "PresentAddressZone": presentAddressZone,
    "PermanentAddressThana": permanentAddressThana == null ? null : permanentAddressThana,
    "PermanentAddressDistrict": permanentAddressDistrict == null ? null : permanentAddressDistrict,
    "PermanentAddressDivision": permanentAddressDivision == null ? null : permanentAddressDivision,
    "PermanentAddress": permanentAddress == null ? null : permanentAddress,
    "PermanentAddressZone": permanentAddressZone == null ? null : permanentAddressZone,
    "FathersName": fathersName,
    "FathersPhone": fathersPhone,
    "MothersName": mothersName,
    "MothersPhone": mothersPhone,
    "MaritalStatus": maritalStatus,
    "SpouseName": spouseName,
    "SpousePhone": spousePhone,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn == null ? null : createdOn!.toIso8601String(),
    "Active": active,
    "IsEmpActive": isEmpActive,
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "UpdatedOn": updatedOn == null ? null : updatedOn!.toIso8601String(),
    "ReportToEmpId": reportToEmpId,
    "DesignationObj": designationObj!.toJson(),
    "DepartmentObj": departmentObj!.toJson(),
    "ProfilePicturePath": profilePicturePath,
    "ProfilePictureName": profilePictureName,
    "PhoneNumbers": phoneNumbers,
    "EmailAddresses": emailAddresses,
    "Faxes": faxes,
    "EmployeeWebsites": employeeWebsites,
    "SocialNetworks": socialNetworks,
    "PrimaryEmail": primaryEmail,
    "EmpUserID": empUserId,
    "EmpUserName": empUserName,
    "EmployeeAttachment": employeeAttachment,
    "CanDelete": canDelete,
  };
}

class DepartmentObj {
  DepartmentObj({
    this.departmentId,
    this.departmentName,
    this.departmentCode,
    this.departmentShortName,
    this.description,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? departmentId;
  String? departmentName;
  String? departmentCode;
  String? departmentShortName;
  String? description;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;

  factory DepartmentObj.fromJson(Map<String, dynamic> json) => DepartmentObj(
    departmentId: json["DepartmentID"],
    departmentName: json["DepartmentName"],
    departmentCode: json["DepartmentCode"] == null ? null : json["DepartmentCode"],
    departmentShortName: json["DepartmentShortName"] == null ? null : json["DepartmentShortName"],
    description: json["Description"] == null ? null : json["Description"],
    active: json["Active"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "DepartmentID": departmentId,
    "DepartmentName": departmentName,
    "DepartmentCode": departmentCode == null ? null : departmentCode,
    "DepartmentShortName": departmentShortName == null ? null : departmentShortName,
    "Description": description == null ? null : description,
    "Active": active,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "UpdatedOn": updatedOn == null ? null : updatedOn!.toIso8601String(),
  };
}

class DesignationObj {
  DesignationObj({
    this.designationId,
    this.designationName,
    this.designationShortName,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  int? designationId;
  String? designationName;
  String? designationShortName;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;

  factory DesignationObj.fromJson(Map<String, dynamic> json) => DesignationObj(
    designationId: json["DesignationID"],
    designationName: json["DesignationName"],
    designationShortName: json["DesignationShortName"],
    active: json["Active"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "DesignationID": designationId,
    "DesignationName": designationName,
    "DesignationShortName": designationShortName,
    "Active": active,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "UpdatedOn": updatedOn == null ? null : updatedOn!.toIso8601String(),
  };
}

class EmployeeDocument {
  EmployeeDocument({
    this.id,
    this.employeeId,
    this.fileName,
    this.isProfilePicture,
    this.active,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.isDeleted,
  });

  int? id;
  int? employeeId;
  String? fileName;
  bool? isProfilePicture;
  bool? active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  bool? isDeleted;

  factory EmployeeDocument.fromJson(Map<String, dynamic> json) => EmployeeDocument(
    id: json["ID"],
    employeeId: json["EmployeeID"],
    fileName: json["FileName"],
    isProfilePicture: json["IsProfilePicture"],
    active: json["Active"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "EmployeeID": employeeId,
    "FileName": fileName,
    "IsProfilePicture": isProfilePicture,
    "Active": active,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn == null ? null : createdOn!.toIso8601String(),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "UpdatedOn": updatedOn == null ? null : updatedOn!.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}
