import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_expense_food_model.dart';
import 'package:salebee/Model/expense/get_other_expense_model.dart';
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
      "MealType": mealType,
      "DishName": "string",
      "Expense": expense,
      "ExpenseDate": date,
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
      "ExpenseName": expenseName,
      "Description": discription,
      "Expense": expense,
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
      { required image,
      required int vehicleType,
        description,
      required String vehicleName,
      required String vehicleNo,
      required int expense,
      required String startDate,
        required String startLocation,
        required String endLocation,
      required String endDate}) async {


    Map<String, dynamic> bodyString = {
      "Id": 0,
      "VehicleType": vehicleType,
      "StartLocation": startLocation,
      "EndLocation": endLocation,
      "StartTime": DateTime.now().toString(),
      "EndTime": "2022-11-15T06:05:16.687Z",
      "Expense": expense,
      "ExpenseDate": "2022-11-15T06:05:16.687Z",
      "ApprovedBy": 0,
      "Attachment": image,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": DateTime.now().toString(),
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
  Future<GetFoodExpenseModel> getFoodExpense() async {
    Map<String, dynamic> bodyString =
    {
      "Token": tokenString,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 1,
      "SupportID": 0,
      "FollowupID": 0
    };

    Uri url = Uri.parse("$base_url/GetUserFoodExpenseClaim");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo for get Food expense list${response.body}");
    var data = jsonDecode(response.body);


    try{
      Map<String, dynamic> bodyString =
      {
        "Token": tokenString,
        "ProspectID": 0,
        "LeadID": 0,
        "TaskID": 0,
        "EmployeeID": 1,
        "SupportID": 0,
        "FollowupID": 0
      };

      Uri url = Uri.parse("$base_url/GetUserFoodExpenseClaim");
      final response = await http.post(
        url,
        body: jsonEncode(bodyString),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo for get Food expense list${response.body}");
      var data = jsonDecode(response.body);

      return getFoodExpenseModelFromJson(response.body);
    }catch(e){

      print("my get Food list errr is ${e.toString()}");
    }

    return getFoodExpenseModelFromJson(response.body);
  }
  Future<GetOtherExpenseModel> getOtherExpense() async {
    Map<String, dynamic> bodyString =
    {
      "Token": tokenString,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 1,
      "SupportID": 0,
      "FollowupID": 0
    };

    Uri url = Uri.parse("$base_url/GetUserOthersExpenseClaim");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo for get Other expense list${response.body}");
    var data = jsonDecode(response.body);


    try{
      Map<String, dynamic> bodyString =
      {
        "Token": tokenString,
        "ProspectID": 0,
        "LeadID": 0,
        "TaskID": 0,
        "EmployeeID": 1,
        "SupportID": 0,
        "FollowupID": 0
      };

      Uri url = Uri.parse("$base_url/GetUserOthersExpenseClaim");
      final response = await http.post(
        url,
        body: jsonEncode(bodyString),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo for get Other expense list${response.body}");
      var data = jsonDecode(response.body);

      return getOtherExpenseModelFromJson(response.body);
    }catch(e){
      print("my get Other list errr is ${e.toString()}");
    }

    return getOtherExpenseModelFromJson(response.body);
  }
  Future<GetTransportExpenseModel> getTransportExpense() async {
    Map<String, dynamic> bodyString =
    {
      "Token": tokenString,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 1,
      "SupportID": 0,
      "FollowupID": 0
    };

    Uri url = Uri.parse("$base_url/GetUserTransportExpenseClaim");
    final response = await http.post(
      url,
      body: jsonEncode(bodyString),
      headers: {
        "Content-Type": "application/json",
      },
    );

    print("my resposnse repo for get transport expense list${response.body}");
    var data = jsonDecode(response.body);


    try{
      Map<String, dynamic> bodyString =
      {
        "Token": tokenString,
        "ProspectID": 0,
        "LeadID": 0,
        "TaskID": 0,
        "EmployeeID": 1,
        "SupportID": 0,
        "FollowupID": 0
      };

      Uri url = Uri.parse("$base_url/GetUserTransportExpenseClaim");
      final response = await http.post(
        url,
        body: jsonEncode(bodyString),
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("my resposnse repo for get transport expense list${response.body}");
      var data = jsonDecode(response.body);

      return getTransportExpenseModelFromJson(response.body);
    }catch(e){
      print("my get other list errr is ${e.toString()}");
    }

    return getTransportExpenseModelFromJson(response.body);
  }
}
