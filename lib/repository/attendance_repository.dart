import 'dart:convert';

import 'package:salebee/Model/checkin_model.dart';

import '../Helper/api_helper.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';
class AttendanceRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  Future<CheckinResponse> checkInController(int id, int employeeId, DateTime logTimeIn, double lat, double lon, int battery) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");



    Map<String, dynamic> bodyString = {
      "Id": 0,
      "EmployeeId": employeeId,
      "LogTimeIn": "2022-08-16T06:09:14.941Z",
      "LogTimeOut": "2022-08-16T06:09:14.941Z",
      "IsLogIn": true,
      "IsLogFromPhone": true,
      "Latitude": 0,
      "Longitude": 0,
      "LocationDescription": "string",
      "Remark": "string",
      "IsLate": true,
      "IsEarlyOut": true,
      "IsHalfDay": true,
      "IsExtremeLate": true,
      "IsExtremeEarlyOut": true,
      "LatitudeOut": 0,
      "LongitudeOut": 0,
      "LocationDescriptionOut": "string",
      "BatteryStatus": "string",
      "Absent": 0,
      "OnLeave": 0,
      "WorkingDays": 0,
      "OnTime": 0,
      "Token": SharedPreff.to.prefss.getString("token"),
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-08-16T06:09:14.941Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-08-16T06:09:14.941Z",
      "IsDeleted": true
    };

      Uri url = Uri.parse("$base_url/CheckIn");
      final response = await http.post(

         url,
        body:  jsonEncode(bodyString),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo ${response.body}");
     String data = response.body;

      return attendanceResponseModelFromJson(response.body);
    }



}