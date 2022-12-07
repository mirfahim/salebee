import 'dart:convert';



import '../Helper/api_helper.dart';
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


}