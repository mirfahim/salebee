import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/AddTaskModel.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/getAllTaskModel.dart';
import 'package:salebee/Model/prospect_lead_concern_model.dart';
import '../Helper/api_helper.dart';
import '../Model/getAllMyTaskModel.dart';
import '../Model/getAssignedTaskToMeModel.dart';
import '../Model/getListForTaskModel.dart';
import '../Model/task_update_model.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;
import '../Utils/StringsConst.dart';

class TaskRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();

  Future<AddTaskResponseModel> taskAddController(
      {required String token,
      required String title,
      required String description,
      required int type,
      required int repeat,
      required int priority,
        int? prospectId,
        int? leadID,
        int? assignaTo,
      required int status}) async {
    print("token  ${SharedPreff.to.prefss.get("token")} , type $type repeat $repeat priority $priority prospect id $prospectId lead id $leadID, assign to $assignaTo++++++");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    List list1 = [];
    List list2 = [];

    Map<String, dynamic> bodyString = {
      "TaskID": 0,
      "Type": type,
      "Title": title,
      "TaskDesc": description,
      "Notes": "stradfaing",
      "ProspectId": prospectId ?? 0,
      "LeadID": leadID ?? 0,
      "SupportID": 0,
      "StartDate": DateTime.now().toString(),
      "StartTime": "string",
      "DueDate": DateTime.now().toString(),
      "DueTime": "string",
      "ReminderDate": "2022-08-30T10:46:49.198Z",
      "ReminderDays": 0,
      "ReminderHour": 0,
      "ReminderMinutes": 0,
      "Repeat": repeat,
      "AssignedTo": assignaTo,
      "Priority": priority ,
      "StatusId": status,
      "FollowUpID": 0,
      "IsViewed": true,
      "StatusUpdateDate": "2022-08-30T10:46:49.198Z",
      "StatusUpdateBy": 0,
      "Token": token,
      "TaskShareList": list1,
      "TaskContactList": list2
    };

    Uri url = Uri.parse("$base_url/AddTask");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return addTaskResponseModelFromJson(response.body);
  }
  Future<TaskUpdateModel> taskUpdateController(
      {required String token,
        required int taskID,
        required String title,
        required String description,
        required int type,
        required int repeat,
        required int priority,
        int? prospectId,
        int? leadID,
        int? assignaTo,
        required int status}) async {
    print("working taskid $taskID, type $type, repeat $repeat, lead $leadID , assign to $assignaTo priority $priority ${SharedPreff.to.prefss.get("token")} ++++++");

    List list1 = [];
    List list2 = [];

    Map<String, dynamic> bodyString =
    {
      "TaskID": taskID,
      "Type": 0,
      "Title": title,
      "TaskDesc": description,
      "Notes": "string",
      "ProspectId": 01,
      "LeadID": 01,
      "SupportID": 0,
      "StartDate": "2022-10-10T05:40:37.409Z",
      "StartTime": "string",
      "DueDate": "2022-10-10T05:40:37.409Z",
      "DueTime": "string",
      "ReminderDate": "2022-10-10T05:40:37.409Z",
      "ReminderDays": 0,
      "ReminderHour": 0,
      "ReminderMinutes": 0,
      "Repeat": 0,
      "AssignedTo": assignaTo,
      "Priority": priority ,
      "StatusId": status ,
      "FollowUpID": 0,
      "IsViewed": true,
      "StatusUpdateDate": "2022-10-10T05:40:37.409Z",
      "StatusUpdateBy": 0,
      "TaskShare": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [
              0
            ],
            "SelectedlongIds": [
              0
            ]
          }
        ],
        "SelectedIds": [
          0
        ],
        "SelectedlongIds": [
          0
        ]
      },
      "TaskContact": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [
              0
            ],
            "SelectedlongIds": [
              0
            ]
          }
        ],
        "SelectedIds": [
          0
        ],
        "SelectedlongIds": [
          0
        ]
      },
      "Token": token,
      "TaskShareList": [
        0
      ],
      "TaskContactList": [
        0
      ],
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-10-10T05:40:37.409Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-10-10T05:40:37.409Z",
      "IsDeleted": true
    };

    Uri url = Uri.parse("$base_url/UpdateTask");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return taskUpdateModelFromJson(response.body);
  }
// all task get
  Future<GetAllTaskModel> getAllTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    String base_url = "${StringsConst.BASEURL}";
    print("working 1 $finalToken ++++++ url $base_url");

    Uri url = Uri.parse("$base_url/AllTask");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token": tokenString,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTask ${response.body}");
    String data = response.body;

    return getAllTaskModelFromJson(response.body);
  }

  // get all assigned task to me
  Future<GetAssignedTaskToMeModel> getAssignedToMeTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");
    String base_url = "${StringsConst.BASEURL}";
    print("my main url is ----------------${StringsConst.MAINURL} ++++++");

    Uri url = Uri.parse("$base_url/AllTaskAssignedToMe");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token": tokenString
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTaskAssignedToMe${response.body}");
    String data = response.body;

    return getAssignedTaskToMeModelFromJson(response.body);
  }
  Future<GetAllMyTaskModel> getMyTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/MyTask");
    final response = await http.post(
      url,
      body: jsonEncode({"Token": tokenString}),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetMYTAsk${response.body}");
    String data = response.body;

    return getAllMyTaskModelFromJson(response.body);
  }
  // get all task assigned by me ++++++
  Future<GetAssignedTaskToMeModel> getAssignedTaskByMeController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");

    print("working 1 $finalToken ++++++");

//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks
//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks

    Uri url = Uri.parse("$base_url/AllTaskAssignedByMe");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token":
            "IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks"
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTaskAssignedToMe${response.body}");
    String data = response.body;

    return getAssignedTaskToMeModelFromJson(response.body);
  }

  // get all my task ++++
  Future<ProspectLeadandConcernModel> getProspectLeadandConcern(int prospectId) async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/LeadandProspectConcernPerson");
    final response = await http.post(
      url,
      body: jsonEncode(

            {
              "Token": tokenString,
              "ProspectID": prospectId,
              "LeadID": 0,
              "TaskID": 0,
              "EmployeeID": 0,
              "SupportID": 0,
              "FollowupID": 0

          }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo prrospect lead and concern${response.body}");
    String data = response.body;

    return prospectLeadandConcernModelFromJson(response.body);
  }

// all user list for task

  // get all task assigned by me ++++++
  Future<GetListForTaskDataModel> getAllListForTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");

    print("working 1 $tokenString ++++++");
//IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq632HPYw3Wfy4dnIz0B8tOIcCdPOwnSYWg=
//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks
//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks
// IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq632HPYw3Wfy4dnIz0B8tOIcCdPOwnSYWg=
// IfJylQXq9j2bT+BxKl9eAB+mgLuVFQLU8Ex21yo+TPzqkMgN55lU/xSnY+YOnzcG3BVgQhSSeq632HPYw3Wfy4dnIz0B8tOIcCdPOwnSYWg=
    Uri url = Uri.parse("$base_url/ManageTask");
    final response = await http.post(
      url,
      body: jsonEncode(
          {
            "Token": tokenString,
            "ProspectID": 0,
            "LeadID": 0,
            "TaskID": 0,
            "EmployeeID": 0,
            "SupportID": 0,
            "FollowupID": 0
          }
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(
        "my resposnse repo all managetask ---------------${response.body}");
    String data = response.body;

   // StaticData.statusList = data["SelectListTaskStatus"];

    return getListForTaskDataModelFromJson(response.body);
  }
}
