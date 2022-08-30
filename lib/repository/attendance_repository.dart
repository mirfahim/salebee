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
   Future<CheckinResponse>checkInController(int id, int employeeId, DateTime logTimeIn, double lat, double lon, int battery) async {

    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");
    print(" my url is $base_url");
    Map <String, String>  headerMap = {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json'

    };

    var bodyString = {
      "Id": 0,
      "EmployeeId": 1,
      "LogTimeIn": "2022-08-17T04:41:39.650Z",
      "LogTimeOut": "2022-08-17T04:41:39.650Z",
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
      "BatteryStatus": "12",
      "Absent": 0,
      "OnLeave": 0,
      "WorkingDays": 0,
      "OnTime": 0,
      "Token": "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9x/CUR9Q0WptXm1ZhWjp0MyuiTiyPhjywkA0sFPr89VzEAqygG2oi/",
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-08-17T04:41:39.650Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-08-17T04:41:39.650Z",
      "IsDeleted": true
    };

      Uri url = Uri.parse("https://app.salebee.net/api/Salebee/CheckIn");


        var response = await http.post(

            url,
            body:  jsonEncode(bodyString),
            headers: headerMap
        );
        print("is it working 1");

        print("my resposnse repo ${response.body}");
        // var data = json.decode(response.body);

        return attendanceResponseModelFromJson(response.body);


    }



}