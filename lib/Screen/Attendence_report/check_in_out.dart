import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/api_helper.dart';
import 'package:salebee/Model/checkin_model.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:salebee/repository/attendance_repository.dart';
import '../../Helper/location_helper.dart';
import '../../Utils/my_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/utils.dart';

import '../../Widget/clock_widget.dart';

class CheckInOut extends StatefulWidget {
  CheckInOut({Key? key}) : super(key: key);

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  //final checkIn = false.obs;
  AttendanceRepository attendanceRepository = AttendanceRepository();
  LocationPermission? permission;
  CheckinResponse checkinResponse = CheckinResponse();
  GeolocatorService geolocatorService = GeolocatorService();
  ApiService apiService = ApiService();
  var battery = Battery();
  bool checkIn = true;
  final checkOut = false.obs;
  int percentage = 0;
  final circularProgressIndicatorValue = 0.0.obs;
  RxBool status = true.obs;
  final end = 0.0.obs;

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('hh:mm').format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('a').format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.EEEE().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat.yMd().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(() => TweenAnimationBuilder(
              duration: Duration(seconds: 3),
              tween: Tween(begin: 0.0, end: end.value),
              builder: (context, double value, _) {
                circularProgressIndicatorValue.value = value;
                return Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          color: end.value == 1 ? Colors.blue : Colors.amber,
                          value: circularProgressIndicatorValue.value,
                          backgroundColor: Colors.grey,
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          end.value = 1;
                          _showMyDialog();
                        },
                        onLongPressCancel: () {
                          end.value = 0;
                        },
                        child: Obx(() => Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: status.value == true
                                      ? Colors.blue
                                      : Colors.amber),
                              child: Padding(
                                padding: const EdgeInsets.all(70.0),
                                child: Image.asset(
                                  'images/tap.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                );
              },
            )),

        SizedBox(
          height: 10,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined),
              SizedBox(
                width: 10,
              ),
              Text('Central park')
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        const Text(
                          '10:26',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Check In',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.person_add_alt,
                          color: primaryColor,
                        ),
                        const Text(
                          '--:--',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Check Out',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_circle_right,
                          color: primaryColor,
                        ),
                        const Text(
                          '08:26',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Working Hour',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
              child: Container(),
            )
          ],
        )
      ],
    );
  }

  void changeCheckIn() {
    print("my battery level$percentage");
    setState(() {
      checkIn = !checkIn;
      status.value = !status.value;
    });
  }

  // Future<dynamic> checkInController(int id, int employeeId, DateTime logTimeIn,
  //     double lat, double lon) async {
  //   print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");
  //   Map<String, dynamic> bodyString = {
  //
  //       "Id": 0,
  //       "EmployeeId": employeeId,
  //       "LogTimeIn": logTimeIn.toString(),
  //       "LogTimeOut": "2022-08-17T04:41:39.650Z",
  //       "IsLogIn": true,
  //       "IsLogFromPhone": true,
  //       "Latitude": lat,
  //       "Longitude": lon,
  //       "LocationDescription": "string",
  //       "Remark": "string",
  //       "IsLate": true,
  //       "IsEarlyOut": true,
  //       "IsHalfDay": true,
  //       "IsExtremeLate": true,
  //       "IsExtremeEarlyOut": true,
  //       "LatitudeOut": 0,
  //       "LongitudeOut": 0,
  //       "LocationDescriptionOut": "string",
  //       "BatteryStatus": "12",
  //       "Absent": 0,
  //       "OnLeave": 0,
  //       "WorkingDays": 0,
  //       "OnTime": 0,
  //       "Token": SharedPreff.to.prefss.get("token"),
  //       "Active": true,
  //       "CreatedBy": 0,
  //       "CreatedOn": "2022-08-17T04:41:39.650Z",
  //       "UpdatedBy": 0,
  //       "UpdatedOn": "2022-08-17T04:41:39.650Z",
  //       "IsDeleted": true
  //
  //     // "Id": 0,
  //     // "EmployeeId": employeeId,
  //     // "LogTimeIn": logTimeIn.toString(),
  //     // "LogTimeOut": "2022-07-30T04:45:03.239Z",
  //     // "IsLogIn": true,
  //     // "IsLogFromPhone": true,
  //     // "Latitude": 0,
  //     // "Longitude": 0,
  //     // "LocationDescription": "string",
  //     // "Remark": "string",
  //     // "IsLate": true,
  //     // "IsEarlyOut": true,
  //     // "IsHalfDay": true,
  //     // "IsExtremeLate": true,
  //     // "IsExtremeEarlyOut": true,
  //     // "LatitudeOut": 0,
  //     // "LongitudeOut": 0,
  //     // "LocationDescriptionOut": "string",
  //     // "Token": SharedPreff.to.prefss.get("token"),
  //     // "Active": true,
  //     // "CreatedBy": 0,
  //     // "CreatedOn": "2022-07-30T04:45:03.240Z",
  //     // "UpdatedBy": 0,
  //     // "UpdatedOn": "2022-07-30T04:45:03.240Z",
  //     // "IsDeleted": true
  //
  //   };
  //   return
  //       //  apiClient.post(url: "delivery_boy_login", body: bodyString);
  //       apiService.makeApiRequest(
  //           method: apiMethods.post,
  //           url: "CheckIn",
  //           body: bodyString); //we will fetch the overview from this request
  // }



  void getBatteryPerentage() async {
    final level = await battery.batteryLevel;
    percentage = level;
  }

  Future<void> _showMyDialog() async {
    getBatteryPerentage();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure ?'),
                checkIn == true
                    ? Text('You want to check in?')
                    : Text('You want to check out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                geolocatorService.determinePosition().then((ele) {
                  print("my position is ${ele!.latitude}");
                  DateTime now = DateTime.now();

                  checkIn == false ?
                  attendanceRepository.checkInController(
                      1, 1, now, ele!.latitude, ele!.longitude, percentage)
                  : attendanceRepository.checkOutController("ss", 1, now, "location", ele!.latitude, ele!.longitude);


                });
                changeCheckIn();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
