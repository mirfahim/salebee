// not just splash , will ask use for their name here
// Import package
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salebee/Screen/Authentication/login_page.dart';
import 'package:salebee/Screen/Authentication/sub_domain_page.dart';
import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Utils/StringsConst.dart';
import 'package:salebee/Widget/bottom_bar.dart';
import 'package:salebee/bottomNav.dart';
import 'package:salebee/repository/add_task_repository.dart';
//import 'package:location/location.dart';
import '../Data/static_data.dart';
import '../Service/sharedPref_service.dart';
import '../Utils/my_colors.dart';
import 'package:flutter/material.dart';

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
  var hiveBox = Hive.box("manageTask");
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
    StaticData.designation =SharedPreff.to.prefss.getString("designation") ?? "";
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
      todaysTaskList.addAll(ele.result!
          .where((element) => element.dueDate!.toString().substring(0,10) == DateTime.now().toString().substring(0,10)));
      print("my todays task list is ${todaysTaskList.length}");
      StaticData.todaysTask = todaysTaskList.length;
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

  getDeviceID() async {
    StaticData.deviceID = await _getId();
    print("my device id is ${StaticData.deviceID}");
  }

  domainCheck() {
    print("my sub domain data yo brooooooooooooooooo ${StaticData.subDomain}");
    if (StaticData.loggedIN == true && StaticData.subDomain != null) {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: MyColors.appColor,
      //
      body: Center(
        child: Container(
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
            "images/salbee_logo_color_1024.png",
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
