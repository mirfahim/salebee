import 'dart:typed_data';

import '../Model/login_model.dart';

class StaticData {
  static int assignToID = 0;
  static int todaysTask = 0;
  static int department = 0;
  static String designation = "";
  static int prospectID = 0;
  static int leadID = 0;
  static int typeID = 0;
  static int priorityID = 0;
  static int employeeIDTask = 0;
  static int contactPerson = 0;
  static List statusList = [];
  static Uint8List? customMarker;
  static List<String> branchList = ["All", 'Branch 1', 'Branch 2', 'Branch 3', 'Branch 4',];
  static List taskType = [
    "call",

    "mail",
    "visit",
    "Meeting",
    "All"

  ];
  static String? subDomain = "";
  static String? deviceID = "";
  static String? proLink = "";
  static String? name = "";
  static String? token = "";
  static int? employeeID = 0;
  static bool? loggedIN;
  static bool? attendanceMenu;
  static double myLocationLat = 0.0;
  static double myLocationLon = 0.0;
  static LoginResponseModel loginData = LoginResponseModel();
  static bool? checkedIn;
}
