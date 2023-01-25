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

class FollowUpRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  String tokenString = SharedPreff.to.prefss.get("token").toString();

  Future addFollowUpLog(
      {

        required String description,
        required int logType,
        required int outComeType,


        required int? prospectId,


        }) async {



    Map<String, dynamic> bodyString = {

        "Id": 0,
        "ProspectId": prospectId,
        "FollowupActivityTypeId": logType,
        "FollowupActivityOutcomeId": outComeType,
        "Title": StaticData.name,
        "Description": description,
        "LeadId": 0,
        "ProspectFollowupActivityContactPerson": {
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
        "ProspectFollowupActivityContactPersonId": 0,
        "Token": tokenString,
        "Active": true,
        "CreatedBy": StaticData.employeeID,
        "CreatedOn": "2023-01-24T05:09:22.274Z",
        "UpdatedBy": 0,
        "UpdatedOn": "2023-01-24T05:09:22.274Z",
        "IsDeleted": true

    };

    Uri url = Uri.parse("$base_url/AddProspectFollowupLogActivity");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo 123 ${response.body}");
    var data = jsonDecode(response.body);

    return data;
  }


}
