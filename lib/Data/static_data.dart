import 'dart:typed_data';

import 'package:salebee/Model/lead/get_lead_model.dart';

import '../Model/login_model.dart';
import '../Model/prospect/get_prospectList_by_id_model.dart';

class StaticData {
  static List<ProspectResult> prosepctList= [];
  static List<LeadResult> leadList= [];
  static int assignToID = 0;
  static int todaysTask = 0;
  static String mobileNo = "";
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
  static List<String> branchList = ["All", 'Branch 1', 'Branch 2', 'Branch 3',];
  static List taskType = [
    "call",
    "mail",
    "visit",
    "Meeting",
    "SMS",
    "File"

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
