import 'dart:convert';

import 'package:salebee/Model/checkin_model.dart';

import '../Helper/api_helper.dart';
import '../Model/get_attendance_model.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';

class AttendanceRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  Future<CheckinResponse> checkInController(
      {required int id,
      required int employeeId,
      required String logTimeIn,
      required double lat,
      required double lon,
      required int battery,
      required String location}) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    print("working $logTimeIn ++++++ and location is $location");

    Map<String, dynamic> bodyString = {
      "Id": 0,
      "EmployeeId": 1,
      "LogTimeIn": logTimeIn,
      "LogTimeOut": "2022-09-08T04:31:42.029Z",
      "IsLogIn": true,
      "IsLogFromPhone": true,
      "Latitude": 0,
      "Longitude": 0,
      "LocationDescription": location,
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
      "Token":
          "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks",
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-09-08T04:31:42.029Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-09-08T04:31:42.029Z",
      "IsDeleted": true
    };

    Uri url = Uri.parse("$base_url/CheckIn");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo checkIN ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body);
  }

  Future<dynamic> checkOutController(String token, int emId, String date,
      String location, double lat, double lon) async {

    String tokenString = SharedPreff.to.prefss.get("token").toString() ;
     String convertToken = tokenString.replaceAll('+', '%2B');
     String finalToken = convertToken.replaceAll('/', '%2F');

    //elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
    //elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
    //elKJVFof4wcxS98Luvq%2B%2BVWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
    print("checkout chekout em id $emId");
    print("working chekout $date");
    print("working chekout lat $lat");
    print("working chekout  lon $lon");
     print("working chekout $token");
    print("working chekout $convertToken");
    Map<String, dynamic> bodyString = {
      "Token":
          "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks",
      "EmployeeId": emId,
      "CheckOutDateTime": date,
      "Location": "Striing",
      "Latitude": 0.0,
      "Longitude": 0.0,
    };
  //  var encoded = Uri.encodeFull(
      //  "$base_url/GetEmployeeAttendance?Token=${SharedPreff.to.prefss.get("token")}&EmployeeId=1");
   // print("my encoded url link is ++++++++++++++++++++++++ $encoded");
    Uri url = Uri.parse(
        "https://app.salebee.net/api/Salebee/CheckOut?Token=$finalToken&EmployeeId=$emId&CheckOutDateTime=$date%3A42.029Z&Latitude=$lat&Longitude=$lon&Location=$location");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo checkOUt ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(
        response.body); //we will fetch the overview from this request
  }

  Future<GetAttendanceDataModel> getAttendanceController(int emp) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    var encoded = Uri.encodeFull(
        "$base_url/GetEmployeeAttendance?Token=${SharedPreff.to.prefss.get("token")}&EmployeeId=1");
    print("my encoded url link is ++++++++++++++++++++++++ $encoded");
    Uri url = Uri.parse(encoded);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get attendance${response.body}");
    String data = response.body;

    return getAttendanceDataModelFromJson(response.body);
  }
}
