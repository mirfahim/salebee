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
  Future<CheckinResponse> checkInController(int id, int employeeId, String logTimeIn, double lat, double lon, int battery) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    print("working $logTimeIn ++++++");

    Map<String, dynamic> bodyString = {
      "Id": 0,
      "EmployeeId": employeeId,
      "LogTimeIn": logTimeIn,
      "LogTimeOut": "2022-08-16T06:09:14.941Z",
      "IsLogIn": true,
      "IsLogFromPhone": true,
      "Latitude": lat,
      "Longitude": lon,
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
      "BatteryStatus": battery.toString() ,
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

      print("my resposnse repo checkIN ${response.body}");
     String data = response.body;

      return attendanceResponseModelFromJson(response.body);
    }

  Future<dynamic> checkOutController(String token, int emId, String date, String location, double lat, double lon) async {
    print("working chekout ${SharedPreff.to.prefss.getString("token")}");
    print("working chekout $date");
    Map<String, dynamic> bodyString = {
      "Token": SharedPreff.to.prefss.getString("token"),
      "EmployeeId": emId,
      "CheckOutDateTime": date,
      "Location": "Striing",
      "Latitude": 0.0,
      "Longitude": 0.0,
    };
    Uri url = Uri.parse("https://app.salebee.net/api/Salebee/CheckOut?Token=elKJVFof4wcxS98Luvq%2B%2BVWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks&EmployeeId=1&CheckOutDateTime=2022-08-30T07%3A28%3A56.777Z&Latitude=0&Longitude=0&Location=dt");
    final response = await http.post(

      url,
      body:  jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo checkOUt ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body); //we will fetch the overview from this request
  }

}