import 'dart:convert';
import 'dart:io';

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

  // Foood ********************************
  Future<CheckinResponse> foodExpenseController() async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Map<String, dynamic> bodyString = {
      "Id": 0,
      "MealType": 1,
      "DishName": "Arabian Sharma",
      "Expense": 250,
      "ExpenseDate": "2022-08-29T09:47:04.136Z",
      "ApprovedBy": 1,
      "Token": SharedPreff.to.prefss.getString("token"),
    };

    Uri url = Uri.parse("$base_url/ExpenseClaimFood");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return attendanceResponseModelFromJson(response.body);
  }

  othersExpenseController() async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    var myFile = File('file.txt');
    Map<String, dynamic> bodyString =
      {
        "Id": "1",
        "ExpenseName": "Test Expense",
        "Description": "Test Expense For Salebee CRM Marketing",
        "Expense": "500.0",
        "ExpenseDate": "2022-09-05T08:15:50.746Z",
        "ApprovedBy": "1",
        "Token":
            "elKJVFof4wcxS98Luvq++VWesNLCVPMGvDvr2QljZE9R0gclbnWYFvkqzzkmQdks"

        //"Attachment":  myFile,

    };

    Uri url = Uri.parse("$base_url/ExpenseClaimOthers");
    final response = await http.post(
      url,
      body: bodyString,
    );

    print("my resposnse repo other ${response.body}");
    String data = response.body;
    return data;
    // return attendanceResponseModelFromJson(response.body);
  }

  Future transportExpenseController() async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Map<String, dynamic> bodyString = {
      "trans": {
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
        "UpdatedBy": "0",
        "UpdatedOn": "2022-08-30T04:51:03.429Z",
        "Token": SharedPreff.to.prefss.getString("token").toString(),
      },
    };

    Uri url = Uri.parse("$base_url/ExpenseClaimTransport");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    String data = response.body;

    //return transportExpenseModelFromJson(response.body);
    return data;
  }

  Future<TransportExpenseModel> transportController(file) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    var headers = {
      "Content-Type": "application/json",
    };

    Map<String, String> bodyString = {
      "trans": {
        "Id": 1.toString(),
        "VehicleType": 1.toString(),
        "StartLocation": "string",
        "EndLocation": "string",
        "StartTime": "2022-08-30T04:51:03.429Z",
        "EndTime": "2022-08-30T04:51:03.429Z",
        "Expense": "0",
        "ExpenseDate": "2022-08-30T04:51:03.429Z",
        "ApprovedBy": "0",
        "Active": "true",
        "CreatedBy": "0",
        "CreatedOn": "2022-08-30T04:51:03.429Z",
        "UpdatedBy": "0",
        "UpdatedOn": "2022-08-30T04:51:03.429Z",
        "Token": SharedPreff.to.prefss.getString("token").toString(),
      }.toString()
    };
    http.Response? response;
    http.MultipartRequest request;
    String urllink = "$base_url/ExpenseClaimTransport";
    print("working before http *******");
    request = http.MultipartRequest('POST', Uri.parse(urllink))
      ..headers.addAll(headers)
      ..fields.addAll(bodyString)
      ..files.add(await http.MultipartFile.fromPath("Attachment", file.path,
          filename: file));

    response = await http.Response.fromStream(await request.send());

    print("my resposnse repo ${response.body}");
    String data = response.body;

    return transportExpenseModelFromJson(response.body);
  }
}
