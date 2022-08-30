import 'dart:convert';

import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/transportExpenseModel.dart';

import '../Helper/api_helper.dart';
import '../Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:http/http.dart' as http;

import '../Utils/StringsConst.dart';
class ExpenseRepository {
  String base_url = "${StringsConst.BASEURL}";
  ApiService apiService = ApiService();
  Future<CheckinResponse> foodExpenseController() async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");



    Map<String, dynamic> bodyString = {

        "Id": 0,
        "MealType": 1,
        "DishName": "Arabian Sharma",
        "Expense": 250,
        "ExpenseDate": "2022-08-29T09:47:04.136Z",
        "ApprovedBy": 1,
        "Token": "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9x/CUR9Q0WptXm1ZhWjp0MyuiTiyPhjywkA0sFPr89VzEAqygG2oi/"

    };

    Uri url = Uri.parse("$base_url/ExpenseClaimFood");
    final response = await http.post(

      url,
      body:  jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body);
  }

  Future<CheckinResponse> othersExpenseController(int id, int employeeId, DateTime logTimeIn, double lat, double lon, int battery) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");



    Map<String, dynamic> bodyString = {

        "Id": 0,
        "ExpenseName": "string",
        "Description": "string",
        "Expense": 0,
        "ExpenseDate": "2022-08-30T08:14:09.746Z",
        "ApprovedBy": 0,
        "Token": "string"

    };

    Uri url = Uri.parse("$base_url/CheckIn");
    final response = await http.post(

      url,
      body:  jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body);
  }
  Future<TransportExpenseModel> transportExpenseController(int id, int employeeId, DateTime logTimeIn, double lat, double lon, int battery) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");



    Map<String, dynamic> bodyString = {

        "Id": 1,
        "VehicleType": 1,
        "StartLocation": "string",
        "EndLocation": "string",
        "StartTime": "2022-08-30T04:51:03.429Z",
        "EndTime": "2022-08-30T04:51:03.429Z",
        "Expense": 0,
        "ExpenseDate": "2022-08-30T04:51:03.429Z",
        "ApprovedBy": 0,
        "Active": true,
        "CreatedBy": 0,
        "CreatedOn": "2022-08-30T04:51:03.429Z",
        "UpdatedBy": 0,
        "UpdatedOn": "2022-08-30T04:51:03.429Z",
        "Token": "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks"

    };

    Uri url = Uri.parse("$base_url/ExpenseClaimTransport");
    final response = await http.post(

      url,
      body:  jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return transportExpenseModelFromJson(response.body);
  }

}