import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Model/AddTaskModel.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/getAllTaskModel.dart';
import 'package:salebee/Model/prospect_lead_concern_model.dart';
import 'package:salebee/Model/visit/live_tracking_model.dart';
import 'package:universal_html/html.dart';

import '../Helper/api_helper.dart';
import '../Model/TrackingModel/get_all_live_tracking_model.dart';
import '../Model/getAllMyTaskModel.dart';
import '../Model/getAssignedTaskToMeModel.dart';
import '../Model/getListForTaskModel.dart';
import '../Model/task_update_model.dart';
import '../Model/visit/visit_list.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';

class VisitRepository {

  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();

  Future visitAddController(

      {required String prospectName,
        required String batteryStatus,
        required String location,

        required DateTime locationTime,

        required double latitude,
        required double longitude,
        required int employeeId,
        required int prospectId,
      }) async {


    List list1 = [];
    List list2 = [];

    Map<String, dynamic> bodyString =
    {
      "Id": 0,
      "EmployeeId": StaticData.employeeID,
      "Latitude": latitude,
      "Longitude": longitude,
      "LocationTime": locationTime.toString(),
      "IMEI": "string",
      "IP": "string",
      "Brand": "string",
      "Model": "string",
      "OS": "string",
      "BatteryStatus": "string",
      "OSVersion": "string",
      "Note": "string",
      "ProspectId": prospectId,
      "LeadId": 0,
      "LeadName": "string",
      "ProspectName": prospectName,
      "FollowupType": 0,
      "IsLogIn": true,
      "LocationDescription": location,
      "Token": tokenString,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-12-15T10:28:24.418Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-12-15T10:28:24.418Z",
      "IsDeleted": true
    };

    Uri url = Uri.parse("$base_url/AddEmployeeVisit");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo visit ${response.body}");
    String data = response.body;

    return data;
  }
  Future addliveTrackController(

      {
        required String batteryStatus,
        required String location,
        required double latitude,
        required double longitude,


      }) async {


    print("my add Live data ++++++++url = ${StringsConst.BASEURL} lat $latitude, emp ${StaticData.employeeID}, location $location, battery $batteryStatus, my token = $tokenString");

    Map<String, dynamic> bodyString =
    {
      "Id": 0,
      "EmployeeId": StaticData.employeeID,
      "Lat": latitude,
      "Long": longitude,
      "Location": location,
      "BatteryStatus": batteryStatus,
      "Token": tokenString,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-12-19T05:42:29.862Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-12-19T05:42:29.862Z",
      "IsDeleted": true
    };

    try{
      Uri url = Uri.parse("${StringsConst.BASEURL}/AddLiveTraking");
      final response = await http.post(
        url,
        body: jsonEncode(bodyString),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse add live tracking  +++++++++++++ ${response.body}");
      String data = response.body;

      return data;
    }
    catch(e){
      print("my add live data error is $e");
    }
    Uri url = Uri.parse("${StringsConst.BASEURL}/AddLiveTraking");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse add live tracking  +++++++++++++ ${response.body}");
    String data = response.body;

    return data;

  }
// all task get
  Future<GetVisitListModel> getAllVisitController() async {

    String base_url = "${StringsConst.BASEURL}";

try{
  Uri url = Uri.parse("$base_url/GetAllVisitList");
  final response = await http.post(
    url,
    body: jsonEncode({

        "Token": tokenString,


    }),
    headers: {
      "Content-Type": "application/json",
    },
  );

  print("my resposnse repo get all visit data ${response.body}");
  String data = response.body;

  return getVisitListModelFromJson(response.body);
}catch(e){
  print("visit error is $e");
}
    Uri url = Uri.parse("$base_url/GetEmployeeVisitList");
    final response = await http.post(
      url,
      body: jsonEncode({

          "Token": tokenString,
          "ProspectID": 0,
          "LeadID": 0,
          "TaskID": 0,
          "EmployeeID": 0,
          "SupportID": 0,
          "FollowupID": 0,
          "FromDate": "2022-12-15T12:47:13.839Z",
          "ToDate": "2022-12-15T12:47:13.839Z"

      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all visit data ${response.body}");
    String data = response.body;

    return getVisitListModelFromJson(response.body);
  }
  Future<GetVisitListModel> getEmployeeIdVisitController(int employeeId) async {

    String basse_url = "${StringsConst.BASEURL}";
    print("my add Live data ++++++++url = $basse_url my token = $tokenString");

    try{
      Uri url = Uri.parse("$basse_url/GetEmployeeVisitList");
      final response = await http.post(
        url,
        body: jsonEncode({

          "Token": tokenString,
          "EmployeeID": employeeId,

        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo get all visit data ${response.body}");
      String data = response.body;

      return getVisitListModelFromJson(response.body);
    }catch(e){
      print("visit error is $e");
    }
    Uri url = Uri.parse("$basse_url/GetEmployeeVisitList");
    final response = await http.post(
      url,
      body: jsonEncode({

        "Token": tokenString,
        "ProspectID": 0,
        "LeadID": 0,
        "TaskID": 0,
        "EmployeeID": 0,
        "SupportID": 0,
        "FollowupID": 0,
        "FromDate": "2022-12-15T12:47:13.839Z",
        "ToDate": "2022-12-15T12:47:13.839Z"

      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all visit data ${response.body}");
    String data = response.body;

    return getVisitListModelFromJson(response.body);
  }

  Future<GetLiveTrackingModel> getLiveTrackingByEmpController(int employeeId) async {
    print("working in live");
    String basse_url = StringsConst.BASEURL;


    try{
      Uri url = Uri.parse("$basse_url/GetLiveTrakingDataList");
      final response = await http.post(
        url,
        body: jsonEncode({

            "Token": tokenString,
            "ProspectID": 0,
            "LeadID": 0,
            "TaskID": 0,
            "EmployeeID": employeeId,
            "SupportID": 0,
            "FollowupID": 0,
            "FromDate": "2022-12-18T11:28:31.643Z",
            "ToDate": "2022-12-18T11:28:31.643Z"


        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo get live tracking ${response.body}");
      String data = response.body;

      return getLiveTrackingModelFromJson(response.body);
    }catch(e){
      print("visit error is $e");
    }
    Uri url = Uri.parse("$basse_url/GetLiveTrakingDataList");
    final response = await http.post(
      url,
      body: jsonEncode({


          "Token": tokenString,
          "ProspectID": 0,
          "LeadID": 0,
          "TaskID": 0,
          "EmployeeID": employeeId,
          "SupportID": 0,
          "FollowupID": 0,
          "FromDate": "2022-12-18T11:28:31.643Z",
          "ToDate": "2022-12-18T11:28:31.643Z"


      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get live tracking ${response.body}");
    String data = response.body;

    return getLiveTrackingModelFromJson(response.body);
  }
  Future<GetAllLiveTrackingModel> getAllLiveTrackingController() async {

    String base_url = "${StringsConst.BASEURL}";

    try{
      Uri url = Uri.parse("$base_url/GetAllLiveTrakingDataList");
      final response = await http.post(
        url,
        body: jsonEncode({

          "Token": tokenString,
          "ProspectID": 0,
          "LeadID": 0,
          "TaskID": 0,

          "SupportID": 0,
          "FollowupID": 0,
          "FromDate": "2022-12-18T11:28:31.643Z",
          "ToDate": "2022-12-18T11:28:31.643Z"


        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo get all live tracking ${response.body}");
      String data = response.body;

      return getAllLiveTrackingModelFromJson(response.body);
    }catch(e){
      print("visit error is $e");
    }
    Uri url = Uri.parse("$base_url/GetAllLiveTrakingDataList");
    final response = await http.post(
      url,
      body: jsonEncode({


        "Token": tokenString,
        "ProspectID": 0,
        "LeadID": 0,
        "TaskID": 0,

        "SupportID": 0,
        "FollowupID": 0,
        "FromDate": "2022-12-18T11:28:31.643Z",
        "ToDate": "2022-12-18T11:28:31.643Z"


      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all live tracking ${response.body}");
    String data = response.body;

    return getAllLiveTrackingModelFromJson(response.body);
  }


}
