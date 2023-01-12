// To parse this JSON data, do
//
//     final getAllExpenseModel = getAllExpenseModelFromJson(jsonString);

import 'dart:convert';

GetAllExpenseModel getAllExpenseModelFromJson(String str) => GetAllExpenseModel.fromJson(json.decode(str));

String getAllExpenseModelToJson(GetAllExpenseModel? data) => json.encode(data!.toJson());

class GetAllExpenseModel {
  GetAllExpenseModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<Result>? result;
  bool? isSuccess;

  factory GetAllExpenseModel.fromJson(Map<String, dynamic> json) => GetAllExpenseModel(
    message: json["Message"],
    result: json["Result"] == null ? [] : List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x!.toJson())),
    "IsSuccess": isSuccess,
  };
}

class Result {
  Result({
    this.date,
    this.type,
    this.description,
    this.person,
    this.cost,
    this.status,
  });

  DateTime? date;
  String? type;
  String? description;
  int? person;
  double? cost;
  dynamic status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    date: DateTime.parse(json["Date"]),
    type: json["Type"],
    description: json["Description"],
    person: json["Person"],
    cost: json["Cost"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date?.toIso8601String(),
    "Type": typeValues.reverse![type],
    "Description": description,
    "Person": person,
    "Cost": cost,
    "Status": status,
  };
}

enum Type { FOOD, TRANSPORT, OTHERS }

final typeValues = EnumValues({
  "Food": Type.FOOD,
  "Others": Type.OTHERS,
  "Transport": Type.TRANSPORT
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
