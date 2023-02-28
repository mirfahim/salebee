import 'dart:convert';



import 'package:salebee/Data/static_data.dart';
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

  Future prospectAddController({String? prospectName}) async {



    print("yo bro prospect add");
    Map<String, dynamic> bodyString =  {
      "ProspectName": prospectName,
      "InformationSourceId": 10,
      "OrganizaiontypeId": 2,
      "IsIndividual": 0,
      "CampaignId": 1,
      "Note": "Test Swagger",
      "Phone": "0197980034",
      "Email": "reza@nexzen.com",
      "InterestedItems": [1,2,3,4,5],
      "ContactPersons": {
        "Name": "reza",
        "Phone": "01979800341",
        "Email": "reza1@nexzen.com",
        "DepartmentId": 10,
        "DesignationId": 10,
        "InfluencingRoleId": 1,
        "GenderId": 1,
        "ProfessionId": 1,
        "JobTypeId": 1,
        "IsPrimary": true,
        "DateOfBirth": "2023-02-15T06:53:09.991Z"
      },
      "Organization": {
        "Address": "DOHS",
        "Phone": "01979800342",
        "Website": "string",
        "Zone": 10,
        "SocialMedia": "string",
        "Latitude": 0,
        "Longitude": 0
      },
      "Token": tokenString,
    };

    Uri url = Uri.parse("$base_url/AddProspect");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo add prospect ${response.body}");
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
    String base_url = "${StringsConst.BASEURL}";
    print("my main url is ----------------${StringsConst.MAINURL} ++++++");
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 brop bro bro ${SharedPreff.to.prefss.get("token")} ++++++");
try{
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

  SharedPreff.to.prefss.setString("prospectList", data);
  print("prospect yo bro");
  return getAllProspectByIdtModelFromJson(response.body!);
}
catch(e){
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

  SharedPreff.to.prefss.setString("prospectList", data);
  print("prospect yo bro");
  print("my get all prospect error is $e");
  return getAllProspectByIdtModelFromJson(response.body!);

}

  }
  Future<GetFollowupListModel> getProspectFollowupByIdController(int prospectId) async {
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/ProspectFollowupById");
    final response = await http.post(
      url,
      body: jsonEncode({
        "Token": tokenString,
        "ProspectID": prospectId,
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

    try{
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
    }catch(e){
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

      print("my error repo get followup list by date $e");
      String data = response.body;

      return getFollowupListModelByDateFromJson(response.body!);
    }

  }
}
