
import 'package:flutter/material.dart';


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
