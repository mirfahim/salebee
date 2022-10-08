import 'package:flutter/material.dart';

class ProviderManager extends ChangeNotifier {
  String email = "";
  String pwd = "";
  bool loading = false;
  bool isBack = false;
  String filterData = "";
  DateTime today = DateTime.now();

  signIN(String email, String pwd) {
    email = email;
    pwd = pwd;

    notifyListeners();
  }

  filterTask(String filter) {
    filterData = filter;
    print("my selected filter is $filter");
    notifyListeners();
  }

  filterDate(DateTime date) {
    today = date;
    print("my selected filter is $today");
    notifyListeners();
  }
}
