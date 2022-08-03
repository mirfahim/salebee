import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salebee/Model/login_model.dart';
import 'package:salebee/Service/api_service_dio.dart';

import '../../Utils/ApiUrl.dart';

class UserAuthProvider extends ChangeNotifier {
  String email = "";
  String pwd = "";
bool loading = false ;
bool isBack = false ;


 signIN(String email, String pwd) {
    email = email;
    pwd = pwd;

    notifyListeners();
  }



}
