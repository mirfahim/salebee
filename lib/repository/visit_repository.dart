import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Model/AddTaskModel.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/getAllTaskModel.dart';
import 'package:salebee/Model/prospect_lead_concern_model.dart';
import 'package:universal_html/html.dart';

import '../Helper/api_helper.dart';
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
        required DateTime locationTime,
        required double latitude,
        required double longitude,
        required int employeeId,
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
      "ProspectId": 0,
      "LeadId": 0,
      "LeadName": "string",
      "ProspectName": prospectName,
      "FollowupType": 0,
      "IsLogIn": true,
      "LocationDescription": "string",
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

// all task get
  Future<GetVisitListModel> getAllVisitController(int employeeId) async {

    String base_url = "${StringsConst.BASEURL}";

try{
  Uri url = Uri.parse("$base_url/GetAllVisitList");
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


}
