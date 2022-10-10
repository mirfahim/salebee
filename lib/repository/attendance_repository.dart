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
        required String token,
      required int employeeId,
      required String logTimeIn,
      required double lat,
      required double lon,
      required int battery,
      required String location,
      String? note}) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    print("working $logTimeIn ++++++ and location is $location emloyee id $employeeId");
    print("CHECK IN ++++++++++++++++LOGTIME IN IS ++++++ $logTimeIn ");
    String finalToken = token.replaceAll('/', '%2F');
    // {


    // "LongitudeOut": 0,
    // "LocationDescriptionOut": "string",
    // "BatteryStatus": "string",
    // "Absent": 0,
    // "OnLeave": 0,
    // "WorkingDays": 0,
    // "OnTime": 0,
    // "CheckInNote": "string",
    // "CheckOutNote": "string",
    // "Token": "IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks",
    // "Hours": "string",
    // "OverTime": "string",
    // "Active": true,
    // "CreatedBy": 0,
    // "CreatedOn": "2022-10-02T04:49:01.264Z",
    // "UpdatedBy": 0,
    // "UpdatedOn": "2022-10-02T04:49:01.264Z",
    // "IsDeleted": true
    // }
    Map<String, dynamic> bodyString = {
      "Id": 0,
      "EmployeeId": employeeId,
      "LogTimeIn": logTimeIn,
      "LogTimeOut": "2022-10-02T04:49:01.264Z",
      "IsLogIn": true,
      "IsLogFromPhone": true,
      "Latitude": 0,
      "Longitude": 0,
      "LocationDescription": location,
      "Remark": note,
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
      "CheckInNote": "string",
      "CheckOutNote": "string",
      "Token": token,
      "Hours": "string",
      "OverTime": "string",
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-10-02T04:49:01.264Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-10-02T04:49:01.264Z",
      "IsDeleted": true
    };

    Uri url = Uri.parse("$base_url/CheckIn");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json'
      },
    );

    print("my resposnse repo checkIN ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body);
  }

  Future<dynamic> checkOutController(String token, int emId, String date,
      String location, double lat, double lon, String note) async {

// IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks

     String finalToken = token.replaceAll('/', '%2F');

    //elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
    //elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
    //elKJVFof4wcxS98Luvq%2B%2BVWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks
     //IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks  //kamal
    print("checkout chekout em id $emId");
    print("working chekout $date");
    print("working chekout lat $lat");
    print("working chekout  lon $lon");
     print("working chekout token token$token");
    print("working chekout final token$finalToken");
    Map<String, dynamic> bodyString = {
      "Token": token,
      "EmployeeId": emId,
      "CheckOutDateTime": date,
      "Latitude": lat,
      "Longitude": lon,
      "Location": location,
      "CheckOutNote": note,
    };
  //  var encoded = Uri.encodeFull(
      //  "$base_url/GetEmployeeAttendance?Token=${SharedPreff.to.prefss.get("token")}&EmployeeId=1");
   // print("my encoded url link is ++++++++++++++++++++++++ $encoded");
    Uri url = Uri.parse(
        "$base_url/CheckOut");
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
    String tokenString = SharedPreff.to.prefss.get("token").toString();
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 $finalToken ++++++");

    Uri url = Uri.parse("$base_url/GetEmployeeAttendance?EmployeeId=$emp");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token": tokenString
      },),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get attendance${response.body}");
    String data = response.body;

    return getAttendanceDataModelFromJson(response.body);
  }
}
