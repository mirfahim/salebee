import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
  String? tokenString = SharedPreff.to.prefss.getString("token");

  // Foood ********************************
  Future foodExpenseController(
      { image,
      required int mealType,
      required String dishName,
      required int expense,
      required String date}) async {
    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");

    Map<String, dynamic> bodyString = {
      "Id": 0,
      "MealType": 0,
      "DishName": "string",
      "Expense": 0,
      "ExpenseDate": "2022-11-15T04:09:52.678Z",
      "ApprovedBy": 0,
      "Attachment": null,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-11-15T04:09:52.678Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-11-15T04:09:52.678Z",
      "Token": tokenString
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
    var data = jsonDecode(response.body);

    return data;
  }



  Future othersExpenseController(
      {
     image,
    required String expenseName,
    required String discription,
    required int expense,
    required String date,
  }) async {

    Map<String, dynamic> bodyString =
    {
      "Id": 0,
      "ExpenseName": "string",
      "Description": "string",
      "Expense": 0,
      "ExpenseDate": "2022-11-15T06:05:16.691Z",
      "ApprovedBy": 0,
      "Attachment": null,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-11-15T06:05:16.691Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-11-15T06:05:16.691Z",
      "Token": tokenString
    };

    Uri url = Uri.parse("$base_url/ExpenseClaimOthers");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo other ${response.body}");
    var data = jsonDecode(response.body);
    return data;
    // return attendanceResponseModelFromJson(response.body);
  }

  Future transportExpenseController(
      { image,
      required int vehicleType,
      required String vehicleName,
      required String vehicleNo,
      required int expense,
      required String startDate,
      required String endDate}) async {


    Map<String, dynamic> bodyString = {
      "Id": 0,
      "VehicleType": 0,
      "StartLocation": "string",
      "EndLocation": "string",
      "StartTime": "2022-11-15T06:05:16.687Z",
      "EndTime": "2022-11-15T06:05:16.687Z",
      "Expense": 0,
      "ExpenseDate": "2022-11-15T06:05:16.687Z",
      "ApprovedBy": 0,
      "Attachment": image,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-11-15T06:05:16.687Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-11-15T06:05:16.687Z",
      "Token": tokenString
    };

    Uri url = Uri.parse("$base_url/expenseClaimTransport");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo ${response.body}");
    var data = jsonDecode(response.body);

    //return transportExpenseModelFromJson(response.body);
    return data;
  }


}
