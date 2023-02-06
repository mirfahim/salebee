// not just splash , will ask use for their name here
// Import package
import 'dart:convert';
import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/Authentication/login_page.dart';
import 'package:salebee/Screen/Authentication/sub_domain_page.dart';
import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Utils/StringsConst.dart';
import 'package:salebee/Widget/bottom_bar.dart';
import 'package:salebee/bottomNav.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:salebee/utils.dart';
//import 'package:location/location.dart';
import '../Data/static_data.dart';
import '../Helper/location_helper.dart';
import '../Service/sharedPref_service.dart';
import '../Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import 'package:new_version_plus/new_version_plus.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //late LocationData locationData;
  //
  //DbHelper dbHelper = DbHelper();
  TaskRepository taskRepository = TaskRepository();
  AttendanceRepository attendanceRepository = AttendanceRepository();
  ProspectRepository prospectRepository = ProspectRepository();
  var hiveBox = Hive.box("manageTask");
  var _today = HijriCalendar.now();
  List<dynamic> todaysTaskList = [];

  @override
  void initState() {
    super.initState();

    getDeviceID();
    StaticData.subDomain = SharedPreff.to.prefss.getString("subDomain");
    StaticData.loggedIN = SharedPreff.to.prefss.getBool("loggedIN");
    StaticData.attendanceMenu = SharedPreff.to.prefss.getBool("attendanceMenu");
    StaticData.name = SharedPreff.to.prefss.getString("userNAME") ?? "";
    StaticData.proLink = SharedPreff.to.prefss.getString("proLink");
    StaticData.token = SharedPreff.to.prefss.getString("token");
    StaticData.designation =
        SharedPreff.to.prefss.getString("designation") ?? "";
    StaticData.employeeID = SharedPreff.to.prefss.getInt("employeeID") ?? 0;
    setState(() {
      StaticData.subDomain = SharedPreff.to.prefss.getString("subDomain");
      StringsConst.MAINURL =
          "https://${StaticData.subDomain}" + ".salebee.net/";
      StringsConst.BASEURL = "${StringsConst.MAINURL}" + "api/Salebee/";
    });

    print(
        " my subdomain is ++++${StaticData.subDomain} api url is ${StringsConst.BASEURL}");

    getAllTask();

    Timer(Duration(seconds: 4), () {
      saveDataToHive();

      domainCheck();
      // local();

      print(" my image link is ${SharedPreff.to.prefss.getString("proLink")}");
    });
  }

  getAllTask() {
    todaysTaskList.clear();
    taskRepository.getAssignedToMeTaskController().then((ele) {
      todaysTaskList.addAll(ele.result!.where((element) =>
          element.dueDate!.toString().substring(0, 10) ==
          DateTime.now().toString().substring(0, 10)));
      print("my todays task list is ${todaysTaskList.length}");
      StaticData.todaysTask = todaysTaskList.length;
    });
    prospectRepository.getAllProspectListByUserIdController().then((value) {
      print("prospect data from splash $value");
      return value.result!;
    });
  }

  saveDataToHive() {
    print("hive started working");
    taskRepository.getAllListForTaskController().then((value) {
      hiveBox.put("manageTask", value);
      print("hive started working 11");
      print("my hive data is ${hiveBox.get("manageTask")}");
    });
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;

      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.brand; // unique ID on Android
    }
  }

  GeolocatorService geolocatorService = GeolocatorService();
  VisitRepository visitRepository = VisitRepository();
  String locationDis = "";
  var battery = Battery();
  getBattery() async {
    var bat = await battery.batteryLevel;
    return bat;
  }

  getDeviceID() async {
    StaticData.deviceID = await _getId();
    print("my device id is ${StaticData.deviceID}");
  }

  getAddressFromLatLng(double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        locationDis = _formattedAddress;
        return locationDis;
      }
      return locationDis;
    }
  }

  domainCheck() {
    print("my sub domain data yo brooooooooooooooooo ${StaticData.subDomain}");

    if (StaticData.loggedIN == true && StaticData.subDomain != null) {
      print("prospect data from splash");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNav(
            menuPage: false,
          ),
        ),
      );
    } else if (SharedPreff.to.prefss.getString("subDomain") == '' ||
        SharedPreff.to.prefss.getString("subDomain") == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SubDomainPage(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
    // local() async {
    //   //Location location = new Location();
    //
    // //  locationData = await location.getLocation();
    //   print("MY LOCATION from splash__________$locationData");
    //   print(locationData.latitude);
    //   print(locationData.longitude);
    //   StaticData.myLocationLat = locationData.latitude;
    //   StaticData.myLocationLon = locationData.longitude;
    //   print("MY----user----location-----${StaticData.myLocationLat}");
    //   return locationData;
    //
    // }
  }

  //
  @override
  Widget build(BuildContext context) {
    checkIndicator(delay: 2);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: primaryColorLight,
      //
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "images/salbee_logo_color_1024.png",
                width: 100.0,
                height: 100.0,
              ),
            ),
            Text("Today's date:"),
            Container(
              decoration: BoxDecoration(
                color: MyColors.appColor,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "images/Icons/calendar.png",
                width: 100.0,
                height: 100.0,
              ),
            ),
            Text("${DateFormat.yMd().format(DateTime.now())}"),
            //day, month and year is optional parameter! Uses provide values or current date if not provided!
            Text(
              '${BanglaUtility.getBanglaMonthName(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year)}' +
                  ', ${BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year).toString().substring(0, 2)}',
              style: TextStyle(
                  fontSize: 16,
                  color: MyColors.brown,
                  fontWeight: FontWeight.bold),
            ),

            Text(
              _today.toFormat("MMMM dd yyyy"),
              style: TextStyle(
                  fontSize: 14,
                  color: MyColors.customRed,
                  fontWeight: FontWeight.bold),
            ), //Ramadan 14 1439
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.green,
                strokeWidth: 3,
                value: _value,
                semanticsLabel: "10",
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _value = 0;
  void checkIndicator({delay = 2}) {
    new Timer.periodic(Duration(milliseconds: delay * 500), (Timer timer) {
      setState(() {
        if (_value == 1) {
          timer.cancel();
          performFunction();
        } else {
          _value = _value + 0.1;
        }
      });
    });
  }

  void performFunction() {
    //call your function after the loading
  }
}
