import 'dart:convert';

import 'package:salebee/Model/AddTaskModel.dart';
import 'package:salebee/Model/checkin_model.dart';

import '../Helper/api_helper.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';
class TaskRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  Future<AddTaskResponseModel> taskAddController() async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

List list1 = [];
List list2 = [];

    Map<String, dynamic> bodyString = {

    "TaskID": 0,
    "Type": 0,
    "Title": "afd",
    "TaskDesc": "stasdfaring",
    "Notes": "stradfaing",
    "ProspectId": 0,
    "LeadID": 0,
    "SupportID": 0,
    "StartDate": "2022-08-30T10:46:49.198Z",
    "StartTime": "string",
    "DueDate": "2022-08-30T10:46:49.198Z",
    "DueTime": "string",
    "ReminderDate": "2022-08-30T10:46:49.198Z",
    "ReminderDays": 0,
    "ReminderHour": 0,
    "ReminderMinutes": 0,
    "Repeat": 0,
    "AssignedTo": 0,
    "Priority": 0,
    "StatusId": 0,
    "FollowUpID": 0,
    "IsViewed": true,
    "StatusUpdateDate": "2022-08-30T10:46:49.198Z",
    "StatusUpdateBy": 0,
    "Token": "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks",
    "TaskShareList": list1,
    "TaskContactList": list2
    };

    Uri url = Uri.parse("$base_url/AddTask");
    final response = await http.post(

      url,
      body:  jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return addTaskResponseModelFromJson(response.body);
  }



}