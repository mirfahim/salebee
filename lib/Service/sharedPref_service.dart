import 'package:shared_preferences/shared_preferences.dart';



class SharedPreff {

  static bool appLoginStatus = false;
  static SharedPreff to = SharedPreff();
  late SharedPreferences prefss;
  initial()async{
    prefss = await SharedPreferences.getInstance();
  }
}