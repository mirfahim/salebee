import 'dart:convert';



import 'package:salebee/Model/followUp/follow_up_by_date_model.dart';
import 'package:salebee/Model/prospect/get_prospectList_by_id_model.dart';

import '../Helper/api_helper.dart';
import '../Model/followUp/followUP_by_prospectID_model.dart';
import '../Model/getAllMyTaskModel.dart';
import '../Model/getAssignedTaskToMeModel.dart';
import '../Model/getListForTaskModel.dart';
import '../Model/prospect/get_prospect_model.dart';
import '../Model/task_update_model.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';

class ProspectRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();

  Future prospectAddController(
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

    Uri url = Uri.parse("$base_url/LoadProspect?Token=$tokenString");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return response.body;
  }

  Future<GetProspectListModel> getAllProspectController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/LoadProspect?Token=$finalToken");
    final response = await http.post(
      url,
      body: jsonEncode({"Token": tokenString}),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all prospect list ${response.body}");
    String data = response.body;

    return getProspectListModelFromJson(response.body);
  }

  Future<GetAllProspectByIdtModel> getAllProspectListByUserIdController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/GetAllProspectByAssignedUserId");
    final response = await http.post(
      url,
      body: jsonEncode({"Token": tokenString}),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all prospect list by id${response.body}");
    String data = response.body;

    return getAllProspectByIdtModelFromJson(response.body!);
  }
  Future<GetFollowupListModel> getProspectFollowupByIdController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/ProspectFollowupById");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token": tokenString,
        "ProspectID": 163305,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get followup list by id${response.body}");
    String data = response.body;

    return getFollowupListModelFromJson(response.body!);
  }
  Future<GetFollowupListModelByDate> getProspectFollowupByDateController() async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/ProspectFollowupByDate");
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
            "FollowupID": 0,
            "ExpenseID": 0,
            "Type": "string",
            "StatusId": 0,
            "FromDate": "2023-01-18T04:41:35.079Z",
            "ToDate": DateTime.now().toString(),
          }
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get followup list by date ${response.body}");
    String data = response.body;

    return getFollowupListModelByDateFromJson(response.body!);
  }
}
