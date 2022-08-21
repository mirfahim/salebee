// To parse this JSON data, do
//
//     final attendanceResponseModel = attendanceResponseModelFromJson(jsonString);

import 'dart:convert';

CheckinResponse attendanceResponseModelFromJson(String str) => CheckinResponse.fromJson(json.decode(str));

String attendanceResponseModelToJson(CheckinResponse data) => json.encode(data.toJson());

class CheckinResponse {
  CheckinResponse({
    this.Message,
     this.Result,
     this.IsSuccess,
  });
   late final String? Message;
   late final String? Result;
   late final bool? IsSuccess;

  CheckinResponse.fromJson(Map<String, dynamic> json){
    Message = null;
    Result = json['Result'];
    IsSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = Message;
    _data['Result'] = Result;
    _data['IsSuccess'] = IsSuccess;
    return _data;
  }
}
