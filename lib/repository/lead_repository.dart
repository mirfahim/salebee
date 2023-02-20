import 'dart:convert';



import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/followUp/follow_up_by_date_model.dart';
import 'package:salebee/Model/lead/get_lead_model.dart';
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

class LeaDRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();



  Future<GetLeadModel> getLeadController() async {
    String base_url = "${StringsConst.BASEURL}";
    String convertToken = tokenString.replaceAll("+", "%2B");
    String finalToken = convertToken.replaceAll("/", "%2F");
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Uri url = Uri.parse("$base_url/GetLead");
    final response = await http.post(
      url,
      body: jsonEncode({"Token": tokenString}),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo get all lead list ${response.body}");
    String data = response.body;
    SharedPreff.to.prefss.setString("leadList", data);
    return getLeadModelFromJson(response.body);
  }

  Future leadAddController(
      {String? leadName, int? prospectId}) async {
print(" addd lead working started");
String base_url = "${StringsConst.BASEURL}";

    print("yo bro lead add started");
    Map<String, dynamic> bodyString =  {
      "ID": 0,
      "LeadDate": "2023-02-15T08:22:02.035Z",
      "ProspectID": prospectId,
      "LeadName": leadName,
      "EstimatedClosingDate": "2023-02-15T08:22:02.035Z",
      "EstimatedClosingAmount": 1000,
      "AssignedPerson": 1,
      "LeadStage": 1,
      "StageDate": "2023-02-15T08:22:02.035Z",
      "Comments": "Swagger",
      "Priority": 1,
      "ProjectLocation": "DOHS",
      "ProjectType": "test",
      "AreaSft": 120,
      "LeadItems": [
        1,2,3
      ],
      "LeadConcernPersons": [
        {
          "ConcernPersonId": 1,
          "InfluencingRoleId": 1,
          "IsPrimary": true
        }
      ],
      "Token": tokenString
    };

    Uri url = Uri.parse("$base_url/AddLead");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo add Lead +++++= ${response.body}");
    String data = response.body;


    return response.body;
  }
}
