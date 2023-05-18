import 'dart:async';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
//import 'package:new_version_plus/new_version_plus.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Provider/language_provider/language_provider.dart';
import 'package:salebee/Screen/Home/dashboard_view.dart';
import 'package:salebee/Screen/Prospect/prspect_front_tab.dart';

import 'package:salebee/Screen/expense/aproved.dart';
import 'package:salebee/Screen/expense/expense_list.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';
import 'package:salebee/Screen/expense/expense_create/transport.dart';
import 'package:salebee/Screen/lead/lead_view.dart';
import 'package:salebee/Screen/notification/notification.dart';
import 'package:salebee/Screen/setting/setting_page.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/Screen/test_screen.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/StringsConst.dart';
import '../../utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Attendence_report/attendence_report.dart';
import '../leave/leave_front.dart';
import '../notification/notification_1.dart';
import '../test.dart';
import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GeolocatorService geolocatorService = GeolocatorService();
  VisitRepository visitRepository = VisitRepository();
  AttendanceRepository attendanceRepository = AttendanceRepository();

  String locationDis = "";
  var location = Location();

  var battery = Battery();
  getBattery()async{
    var bat = await  battery.batteryLevel;
    return bat;
  }
  getAddressFromLatLng( double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        locationDis =  _formattedAddress;
        return locationDis;
      }
      return locationDis;
    }


  }
  @override
  initState() {

    attendanceRepository.getAllEmployeeList().then((value) {
      AttendanceRepository.employeeList = value.results!;

      print("my emp list from pros ${AttendanceRepository.employeeList[0].employeeId} ");
    });
        print("my sub domain data yo brooooooooooooooooo ${StaticData.subDomain}");
        addLiveTracking();

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
  }
  addLiveTracking()async{
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      geolocatorService.determinePosition().then((ele) {
        getAddressFromLatLng(ele!.latitude!, ele.longitude).then((v) {
          print("my location from google api $v");

          locationDis = v;
        });
        getBattery().then((v){
          const oneSec = Duration(minutes:5);
          print("my timer strated $v lat ${ele!.latitude!}");

          Timer.periodic(oneSec, (Timer t) => visitRepository.addliveTrackController(location: locationDis, latitude: ele!.latitude!, longitude: ele.longitude, batteryStatus: v.toString(),  ));
        });
      });
    } else {
      await location.requestService();
    }
  }

  advancedStatusCheck() async {

    final newVersion = NewVersionPlus(
      //iOSId: 'com.google.Vespa',
      androidId: 'com.salebee.crm',
    );
    var status = await newVersion.getVersionStatus();
    print("version status ${status!.appStoreLink}");
    if (status.canUpdate == true) {
      newVersion.showUpdateDialog(
        launchMode: LaunchMode.externalApplication,
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available!',
        dialogText:
            'Upgrade Salebee ${status.localVersion} to Salebee ${status.storeVersion}',
      );
    }
  }

  Widget circleRow(size, option, top, left, bool badge) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          badge == true
              ? badges.Badge(
                  badgeContent: Text("${StaticData.todaysTask}"),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.greenAccent,
            ),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    // transform: Matrix4.translationValues(x, y, 0.0),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.ac_unit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: primaryColor),
                // transform: Matrix4.translationValues(x, y, 0.0),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                ),
              ),
          SizedBox(
            width: 5,
          ),
          Container(
              // transform: Matrix4.translationValues(x, y, 0.0),
              child: Text(
            '$option',
            style: const TextStyle(color: Colors.grey),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    advancedStatusCheck();
    print(
        "sub domain is ${SharedPreff.to.prefss.get("subDomain")} and my url is ${StringsConst.BASEURL}");
    Size size = MediaQuery.of(context).size;
    print(size.height);
  if(size.height < 650){
    print("size 650 ${size.height}");
    return Scaffold(

      backgroundColor: primaryColorLight,
      body: SafeArea(
        child: Consumer<LangProvider>(
          builder: (context, provider, widget) {
            return provider.themeView == 0 ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StaticData.name != null
                              ? Text(
                            StaticData.name!,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                              : Text(
                            "No name",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          StaticData.employeeID != null
                              ? Text(
                            'ID: ${StaticData.employeeID}',
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                          )
                              : Text(
                            'ID: ',
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(NotificationPage1());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150)),
                          child: badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: Colors.redAccent,
                            ),
                            badgeContent: Text('2'),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notification_important,
                                  color: darkBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: size.height / 1.2,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height / 1.4,
                            transform: Matrix4.translationValues(
                                -(size.height / 6), 0.0, 0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                              - ((size.height * 50 )/ size.width), ((size.height * 75) / size.width),0,),
                            child: StaticData.proLink!.startsWith(".", 0)
                                ? CircleAvatar(
                              radius: size.height / 6,
                              backgroundImage: NetworkImage(
                                  "${StringsConst.MAINURL}" +
                                      "${StaticData.proLink!.replaceAll("../..", "")}"),
                            )
                                : CircleAvatar(
                              radius: size.height / 6,
                              backgroundImage:
                              NetworkImage(StaticData.proLink!),
                            ),
                          ),
                          Positioned(
                            top: (size.height / 13),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to( Get.to(ExpenseList()));
                                },
                                child: circleRow(size,  provider.bangLang == true ?  "ব্যয়" :'Expenses', 20.0, 50.0, false)),
                          ),

                          Positioned(
                              top: (size.height / 6.0),
                              left: (size.width / 2.5),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(AttendenceReport());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "উপস্থিতি" :
                                      'Attendance',
                                      (size.width / 2.7),
                                      (size.height / 8),
                                      false))),
                          Positioned(
                            top: (size.height / 3.1),
                            left: (size.width / 1.9),
                            child: InkWell(
                              onTap: () {
                                Get.to(Task());
                              },
                              child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Tasks', 240.0, 210.0, true),
                            ),
                          ),

                          Positioned(
                              top: (size.height / 2.1),
                              left: (size.width / 2.3),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(LeadView());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "লিড" :
                                      'Lead',
                                      (size.width / 2.5),
                                      (size.height / 2),
                                      false))),

                          Positioned(
                            top: (size.height / 1.74),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ProspectFront());
                                },
                                child: provider.bangLang == true ? circleRow(
                                    size,
                                    'সম্ভাবনা',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false):circleRow(
                                    size,
                                    'Prospect',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false)),
                          ),
                          // circleRow(size,'E', (size.width /12), (size.height /24),),
                          //
                          // circleRow(size,'D',(size.width /2.5),(size.height /8)),
                          //
                          // circleRow(size,'C',(size.width /1.9),(size.height /3.3)),
                          //
                          // circleRow(size,'B',(size.width /2.5),(size.height /2)),
                          //
                          // circleRow(size,'A',(size.width /12),(size.height /1.7)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ) : DashboardPage();
          }
        ),
      ),
    );
  }
  else if (size.height < 800) {
    print("size 800 ${size.height}");
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Consumer<LangProvider>(
            builder: (context, provider, widget) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StaticData.name != null
                                ? Text(
                                    StaticData.name!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "No name",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              height: 2,
                            ),
                            StaticData.employeeID != null
                                ? Text(
                                    'ID: ${StaticData.employeeID}',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                                : Text(
                                    'ID: ',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NotificationPage1());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(150)),
                            child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.redAccent,
                              ),
                              badgeContent: Text("${StaticData.todaysTask}"),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notification_important,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            height: size.height / 1.3,
                            transform: Matrix4.translationValues(
                                -(size.width / 2.5), 0.0, 0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                -(size.width / 3.8), (size.height / 5.5), 0.0),
                            child: StaticData.proLink!.startsWith(".", 0)
                                ? CircleAvatar(
                                    radius: 140,
                                    backgroundImage: NetworkImage(
                                        "${StringsConst.MAINURL}" +
                                            "${StaticData.proLink!.replaceAll("../..", "")}"),
                                  )
                                : CircleAvatar(
                                    radius: 140,
                                    backgroundImage:
                                        NetworkImage(StaticData.proLink!),
                                  ),
                          ),
                          //https://app.salebee.net/UploadedFiles/app/Employee/79/Image/637990290881445074_Kamal%20Photo.jpg -- working
                          //https://app.salebee.net/UploadedFiles/app/Employee/79/Image/637990290881445074_Kamal%20Photo.jpg
                          Positioned(
                            top: (size.height / 11),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ExpenseList());
                                },
                                child: circleRow(size, provider.bangLang == true ?  "ব্যয়" :'Expenses', 20.0, 50.0, false)),
                          ),
                          Positioned(
                              top: (size.height / 6.0),
                              left: (size.width / 2.5),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(AttendenceReport());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "উপস্থিতি" :
                                      'Attendance',
                                      (size.width / 2.7),
                                      (size.height / 8),
                                      false))),
                          Positioned(
                            top: (size.height / 3.1),
                            left: (size.width / 1.9),
                            child: InkWell(
                              onTap: () {
                                Get.to(Task());
                              },
                              child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Taskss', 240.0, 210.0, true),
                            ),
                          ),
                          Positioned(
                              top: (size.height / 2.1),
                              left: (size.width / 2.3),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(LeadView());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "লিড" :
                                      'Lead',
                                      (size.width / 2.5),
                                      (size.height / 2),
                                      false))),
                          Positioned(
                            top: (size.height / 1.68),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ProspectFront());
                                },
                                child: provider.bangLang == true ?circleRow(
                                    size,
                                    'সম্ভাবনা',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false) : circleRow(
                                    size,
                                    'Prospect',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.arrow_back,
                  //             color: darkBlue,
                  //           ),
                  //           Text(
                  //             'Prev',
                  //             style: TextStyle(color: darkBlue),
                  //           )
                  //         ],
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           Get.to(AdsPage());
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Icon(
                  //               Icons.arrow_forward,
                  //               color: darkBlue,
                  //             ),
                  //             Text(
                  //               'Next',
                  //               style: TextStyle(color: darkBlue),
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              );
            }
          ),
        ),
      );
    }
    else if (size.height < 850) {
    print("size 850 ${size.height}");
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Consumer<LangProvider>(
            builder: (context, provider, widget) {
              return provider.themeView == 0 ?Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StaticData.name != null
                                ? Text(
                                    StaticData.name! ,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "No name",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              height: 2,
                            ),
                            StaticData.employeeID != null
                                ? Text(
                                    'ID: ${StaticData.employeeID}',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                                : Text(
                                    'ID: ',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NotificationPage1());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(150)),
                            child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.redAccent,
                              ),
                              badgeContent: Text('3'),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notification_important,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            height: size.height / 1.3,
                            transform: Matrix4.translationValues(
                                -(size.width / 2.5), 0.0, 0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                -(size.width / 3.8), (size.height / 5.5), 0.0),
                            child: StaticData.proLink!.startsWith(".", 0)
                                ? CircleAvatar(
                                    radius: 140,
                                    backgroundImage: NetworkImage(
                                        "${StringsConst.MAINURL}" +
                                            "${StaticData.proLink!.replaceAll("../..", "")}"),
                                  )
                                : CircleAvatar(
                                    radius: 140,
                                    backgroundImage:
                                        NetworkImage(StaticData.proLink!),
                                  ),
                          ),
                          Positioned(
                            top: (size.height / 9.5),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ExpenseList());
                                },
                                child: circleRow(size, provider.bangLang == true ?  "ব্যয়" :'Expenses', 20.0, 50.0, false)),
                          ),
                          Positioned(
                              top: (size.height / 5.0),
                              left: (size.width / 2.3),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(AttendenceReport());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "উপস্থিতি" :
                                      'Attendance',
                                      (size.width / 2.7),
                                      (size.height / 8),
                                      false))),
                          Positioned(
                            top: (size.height / 2.8),
                            left: (size.width / 1.8),
                            child: InkWell(
                              onTap: () {
                                Get.to(Task());
                              },
                              child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Tasks', 240.0, 210.0, true),
                            ),
                          ),
                          Positioned(
                              top: (size.height / 2.05),
                              left: (size.width / 2.34),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(LeadView());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "লিড" :
                                      'Lead',
                                      (size.width / 2.5),
                                      (size.height / 2),
                                      false))),
                          Positioned(
                            top: (size.height / 1.85),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ProspectFront());
                                },
                                child: provider.bangLang == true? circleRow(size, 'সম্ভাবনা',
                                    (size.width / 12), (size.height / 1.7), false): circleRow(size, 'Prospect',
                                    (size.width / 12), (size.height / 1.7), false)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ) : DashboardPage();
            }
          ),
        ),
      );
    }
    else if (size.height < 860) {
    print("size 860 ${size.height}");
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Consumer<LangProvider>(
            builder: (context, provider, widget) {
              return provider.themeView == 0 ?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StaticData.name != null
                                ? Text(
                                    StaticData.name!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "No name",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              height: 2,
                            ),
                            StaticData.employeeID != null
                                ? Text(
                                    'ID: ${StaticData.employeeID}',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                                : Text(
                                    'ID: ',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NotificationPage1());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(150)),
                            child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.redAccent,
                              ),
                              badgeContent: Text('3'),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notification_important,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            height: size.height / 1.4,
                            transform: Matrix4.translationValues(
                                -(size.width / 3), 0.0, 0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                -(size.width / 4.5), (size.height / 5.5), 0.0),
                            child: StaticData.proLink!.startsWith(".", 0)
                                ? CircleAvatar(
                                    radius: 140,
                                    backgroundImage: NetworkImage(
                                        "${StringsConst.MAINURL}" +
                                            "${StaticData.proLink!.replaceAll("../..", "")}"),
                                  )
                                : CircleAvatar(
                                    radius: 140,
                                    backgroundImage:
                                        NetworkImage(StaticData.proLink!),
                                  ),
                          ),
                          Positioned(
                            top: (size.height / 10),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ExpenseList());
                                },
                                child: circleRow(size, provider.bangLang == true ?  "ব্যয়" :'Expenses', 20.0, 50.0, false)),
                          ),
                          Positioned(
                              top: (size.height / 5.0),
                              left: (size.width / 2.3),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(AttendenceReport());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "উপস্থিতি" :
                                      'Attendance',
                                      (size.width / 2.7),
                                      (size.height / 8),
                                      false))),
                          Positioned(
                            top: (size.height / 2.8),
                            left: (size.width / 1.9),
                            child: InkWell(
                              onTap: () {
                                Get.to(Task());
                              },
                              child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Tasks', 240.0, 210.0, true),
                            ),
                          ),
                          Positioned(
                              top: (size.height / 2.1),
                              left: (size.width / 2.5),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(LeadView());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "লিড" :
                                      'Lead',
                                      (size.width / 2.5),
                                      (size.height / 2),
                                      false))),
                          Positioned(
                            top: (size.height / 1.8),
                            left: (size.width / 9),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ProspectFront());
                                },
                                child: provider.bangLang == true ? circleRow(
                                    size,
                                    'সম্ভাবনা',
                                    (size.width / 13),
                                    (size.height / 2),
                                    false): circleRow(
                                    size,
                                    'Prospect',
                                    (size.width / 13),
                                    (size.height / 2),
                                    false)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.arrow_back,
                  //             color: darkBlue,
                  //           ),
                  //           Text(
                  //             'Prev',
                  //             style: TextStyle(color: darkBlue),
                  //           )
                  //         ],
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           Get.to(AdsPage());
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Icon(
                  //               Icons.arrow_forward,
                  //               color: darkBlue,
                  //             ),
                  //             Text(
                  //               'Next',
                  //               style: TextStyle(color: darkBlue),
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ) : DashboardPage();
            }
          ),
        ),
      );

    } else if (size.height < 950) {
    print("size 950 ${size.height}");
    return Scaffold(
      backgroundColor: primaryColorLight,
      body: SafeArea(
        child: Consumer<LangProvider>(
          builder: (context, provider, widget) {
            return provider.themeView == 0 ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StaticData.name != null
                              ? Text(
                            StaticData.name!,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                              : Text(
                            "No name",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          StaticData.employeeID != null
                              ? Text(
                            'ID: ${StaticData.employeeID}',
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                          )
                              : Text(
                            'ID: ',
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(NotificationPage1());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150)),
                          child: badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: Colors.redAccent,
                            ),
                            badgeContent: Text('3'),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notification_important,
                                  color: darkBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: size.height / 1.4,
                          transform: Matrix4.translationValues(
                              -(size.width / 3), 0.0, 0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        Container(
                          transform: Matrix4.translationValues(
                              -(size.width / 4.5), (size.height / 5.5), 0.0),
                          child: StaticData.proLink!.startsWith(".", 0)
                              ? CircleAvatar(
                            radius: 140,
                            backgroundImage: NetworkImage(
                                "${StringsConst.MAINURL}" +
                                    "${StaticData.proLink!.replaceAll("../..", "")}"),
                          )
                              : CircleAvatar(
                            radius: 140,
                            backgroundImage:
                            NetworkImage(StaticData.proLink!),
                          ),
                        ),
                        Positioned(
                          top: (size.height / 10),
                          left: (size.width / 8),
                          child: InkWell(
                              onTap: () {
                                Get.to(ExpenseList());
                              },
                              child: circleRow(size, provider.bangLang == true ?  "ব্যয়" :'Expenses', 20.0, 50.0, false)),
                        ),
                        Positioned(
                            top: (size.height / 5.0),
                            left: (size.width / 2.3),
                            child: InkWell(
                                onTap: () {
                                  Get.to(AttendenceReport());
                                },
                                child: circleRow(
                                    size,
                                    provider.bangLang == true ?  "উপস্থিতি" :
                                    'Attendance',
                                    (size.width / 2.7),
                                    (size.height / 8),
                                    false))),
                        Positioned(
                          top: (size.height / 2.8),
                          left: (size.width / 1.9),
                          child: InkWell(
                            onTap: () {
                              Get.to(Task());
                            },
                            child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Tasks', 240.0, 210.0, true),
                          ),
                        ),
                        Positioned(
                            top: (size.height / 2.1),
                            left: (size.width / 2.5),
                            child: InkWell(
                                onTap: () {
                                  Get.to(LeadView());
                                },
                                child: circleRow(
                                    size,
                                    provider.bangLang == true ?  "লিড" :
                                    'Lead',
                                    (size.width / 2.5),
                                    (size.height / 2),
                                    false))),
                        Positioned(
                          top: (size.height / 1.8),
                          left: (size.width / 9),
                          child: InkWell(
                              onTap: () {

                                Get.to(ProspectFront());
                              },
                              child: provider.bangLang == true ? circleRow(
                                  size,
                                  'সম্ভাবনা',
                                  (size.width / 13),
                                  (size.height / 2),
                                  false): circleRow(
                                  size,
                                  'Prospect',
                                  (size.width / 13),
                                  (size.height / 2),
                                  false)),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.arrow_back,
                //             color: darkBlue,
                //           ),
                //           Text(
                //             'Prev',
                //             style: TextStyle(color: darkBlue),
                //           )
                //         ],
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Get.to(AdsPage());
                //         },
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.arrow_forward,
                //               color: darkBlue,
                //             ),
                //             Text(
                //               'Next',
                //               style: TextStyle(color: darkBlue),
                //             )
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ) : DashboardPage();
          }
        ),
      ),
    );

  }else if (size.height < 1200) {
    print("size 1200 ${size.height}");
      return Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Consumer<LangProvider>(
            builder: (context, provider, widget) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StaticData.name != null
                                ? Text(
                                    StaticData.name!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "No name",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              height: 2,
                            ),
                            StaticData.employeeID != null
                                ? Text(
                                    'ID: ${StaticData.employeeID}',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                                : Text(
                                    'ID: ',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NotificationPage1());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(150)),
                            child: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.redAccent,
                              ),
                              badgeContent: Text('3'),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notification_important,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            height: size.height / 1.3,
                            transform: Matrix4.translationValues(
                                -(size.width / 2.5), 0.0, 0.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                -(size.width / 3.8), (size.height / 5.5), 0.0),
                            child: StaticData.proLink!.startsWith(".", 0)
                                ? CircleAvatar(
                                    radius: 140,
                                    backgroundImage: NetworkImage(
                                        "${StringsConst.MAINURL}" +
                                            "${StaticData.proLink!.replaceAll("../..", "")}"),
                                  )
                                : CircleAvatar(
                                    radius: 140,
                                    backgroundImage:
                                        NetworkImage(StaticData.proLink!),
                                  ),
                          ),
                          Positioned(
                            top: (size.height / 22),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ExpenseList());
                                },
                                child: circleRow(size, provider.bangLang == true ?  "ব্যয়" :'Expenses', (size.width / 4),
                                    (size.height / 6), false)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(AttendenceReport());
                            },
                            child: Positioned(
                                top: (size.height / 6),
                                left: (size.width / 2.2),
                                child: circleRow(size,
                                    provider.bangLang == true ?  "উপস্থিতি" :
                                    'Attendance',
                                    (size.width / 2.7), (size.height / 8), false)),
                          ),
                          Positioned(
                            top: (size.height / 2.6),
                            left: (size.width / 1.75),
                            child: InkWell(
                              onTap: () {
                                Get.to(Task());
                              },
                              child: circleRow(size,   provider.bangLang == true ?  "কাজ" :'Tasks', 240.0, 210.0, false),
                            ),
                          ),
                          Positioned(
                              top: (size.height / 1.7),
                              left: (size.width / 2.3),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(LeadView());
                                  },
                                  child: circleRow(
                                      size,
                                      provider.bangLang == true ?  "লিড" :
                                      'Lead',
                                      (size.width / 2.5),
                                      (size.height / 2),
                                      false))),
                          Positioned(
                            top: (size.height / 1.45),
                            left: (size.width / 8),
                            child: InkWell(
                                onTap: () {
                                  Get.to(ProspectFront());
                                },
                                child: provider.bangLang == true ? circleRow(
                                    size,
                                    'সম্ভাবনা',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false): circleRow(
                                    size,
                                    'Prospect',
                                    (size.width / 12),
                                    (size.height / 1.74),
                                    false)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.arrow_back,
                  //             color: darkBlue,
                  //           ),
                  //           Text(
                  //             'Prev',
                  //             style: TextStyle(color: darkBlue),
                  //           )
                  //         ],
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           Get.to(AdsPage());
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Icon(
                  //               Icons.arrow_forward,
                  //               color: darkBlue,
                  //             ),
                  //             Text(
                  //               'Next',
                  //               style: TextStyle(color: darkBlue),
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              );
            }
          ),
        ),
      );
    }
      return Container();
    }



}
