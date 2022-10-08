// To parse this JSON data, do
//
//     final getListForTaskDataModel = getListForTaskDataModelFromJson(jsonString);

import 'dart:convert';

GetListForTaskDataModel getListForTaskDataModelFromJson(String str) => GetListForTaskDataModel.fromJson(json.decode(str));

String getListForTaskDataModelToJson(GetListForTaskDataModel data) => json.encode(data.toJson());

class GetListForTaskDataModel {
  GetListForTaskDataModel({
    this.message,
    required this.result,
    this.isSuccess,
  });

  String? message;
  Map<String, List<Result>?>? result;
  bool? isSuccess;

  factory GetListForTaskDataModel.fromJson(Map<String, dynamic> json) => GetListForTaskDataModel(
    message: json["Message"],
    result: Map.from(json["Result"]).map((k, v) => MapEntry<String, List<Result>?>(k, v == null ? null : List<Result>.from(v.map((x) => Result.fromJson(x))))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": Map.from(result!).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : List<dynamic>.from(v.map((x) => x.toJson())))),
    "IsSuccess": isSuccess,
  };
}

class Result {
  Result({
    required this.disabled,
    this.group,
    required this.selected,
    required this.text,
    required this.value,
  });

  bool disabled;
  dynamic group;
  bool selected;
  String text;
  String value;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    disabled: json["Disabled"],
    group: json["Group"],
    selected: json["Selected"],
    text: json["Text"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Disabled": disabled,
    "Group": group,
    "Selected": selected,
    "Text": text,
    "Value": value,
  };
}
