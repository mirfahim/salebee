import 'package:flutter/material.dart';

class ProviderManager extends ChangeNotifier {
  String email = "";
  String pwd = "";
  bool loading = false;
  bool isBack = false;
  String filterData = "";
  int  filterDay = 0;

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

  filterDate(int days) {
    filterDay = days;
    print("my selected filter is $days");
    notifyListeners();
  }
}
