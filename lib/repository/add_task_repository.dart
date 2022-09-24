import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salebee/Model/AddTaskModel.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/getAllTaskModel.dart';

import '../Helper/api_helper.dart';
import '../Model/getAllMyTaskModel.dart';
import '../Model/getAssignedTaskToMeModel.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';
class TaskRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();
  
  Future<AddTaskResponseModel> taskAddController({required String token,required String title,required String description,required int type,required int repeat,required int priority,required int status}) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

List list1 = [];
List list2 = [];

    Map<String, dynamic> bodyString = {

    "TaskID": 0,
    "Type": 0,
    "Title": title,
    "TaskDesc": description,
    "Notes": "stradfaing",
    "ProspectId": 0,
    "LeadID": 0,
    "SupportID": 0,
    "StartDate": "2022-09-21T10:46:49.198Z",
    "StartTime": "string",
    "DueDate": "2022-09-30T10:46:49.198Z",
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
    "Token": token,
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
// all task get
  Future<GetAllTaskModel> getTaskController() async {



    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 $finalToken ++++++");

    Uri url = Uri.parse("$base_url/GetAllTask?Token=$finalToken");
    final response = await http.get(

      url,

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




    Uri url = Uri.parse("$base_url/GetAllTaskAssignedToMe?Token=$tokenString");
    final response = await http.get(

      url,

      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTaskAssignedToMe${response.body}");
    String data = response.body;

    return getAssignedTaskModelFromJson(response.body);
  }

  // get all task assigned by me ++++++
  Future<GetAssignedTaskToMeModel> getAssignedTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");

    print("working 1 $finalToken ++++++");

//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks
//IfJylQXq9j2bT%2BBxKl9eAB%2BmgLuVFQLU8Ex21yo%2BTPzqkMgN55lU%2FxSnY%2BYOnzcG3BVgQhSSeq5R0gclbnWYFvkqzzkmQdks


    Uri url = Uri.parse("$base_url/GetAllTaskAssignedToMe?Token=$finalToken");
    final response = await http.get(

      url,

      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTaskAssignedToMe${response.body}");
    String data = response.body;

    return getAssignedTaskModelFromJson(response.body);
  }

  // get all my task ++++
  Future<GetAllMyTaskModel> getMyTaskController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");





    Uri url = Uri.parse("$base_url/GetAllTaskAssignedToMe?Token=$finalToken");
    final response = await http.get(

      url,

      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo GetAllTaskAssignedToMe${response.body}");
    String data = response.body;

    return getAllMyTaskModelFromJson(response.body);
  }






}