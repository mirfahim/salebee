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
import 'package:geocoding/geocoding.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Widget/clock_widget.dart';
import 'package:intl/intl.dart';
class CheckInOut extends StatefulWidget {
  CheckInOut({Key? key}) : super(key: key);

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  //final checkIn = false.obs;
  String checkInTime = "";
  AttendanceRepository attendanceRepository = AttendanceRepository();
  LocationPermission? permission;
  CheckinResponse checkinResponse = CheckinResponse();
  GeolocatorService geolocatorService = GeolocatorService();
  ApiService apiService = ApiService();
  var battery = Battery();
  String locationDis = "";
  String checkOutTime = "";
  bool checkIn = true;
  final checkOut = false.obs;
  int percentage = 0;
  final circularProgressIndicatorValue = 0.0.obs;
  RxBool status = true.obs;
  final end = 0.0.obs;
   String totalhrs = "";
  Timer? _timer;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
 // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
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
                Text(locationDis, maxLines: 2, style: TextStyle(fontSize: 10),)
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
                           Text(
                            checkInTime,
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
                           Text(
                            checkOutTime,
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
                           Text(
                            totalhrs,
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
      ),
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
              //  _getLocation();

                print("working chekout ${SharedPreff.to.prefss.getString("token")}");
                String? token = SharedPreff.to.prefss.getString("token");

                geolocatorService.determinePosition().then((ele) {
                  getAddressFromLatLong(ele!);
                  print("my position is ${ele!.latitude}");
                  // DateTime now = DateTime.now();
                  // Timestamp myTimeStamp = Timestamp.fromDate(now);
                  // String time = myTimeStamp.toString();
                  final DateTime now = DateTime.now();
                  final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
                  final String formatted = formatter.format(now);
                  print("my date is $formatted");
                  var inputFormat = DateFormat('yyyy/MM/dd HH:mm');
                  var inputDate = inputFormat.parse(formatted); // <-- dd/MM 24H format

                  var outputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
                  var outputDate = outputFormat.format(inputDate);
                  print(outputDate);
                  print("my location is +++++++++++++++++ before cheked $locationDis");

                  checkIn == false ?

                  attendanceRepository.checkInController(
                     id: 1, employeeId: 1, logTimeIn: formatted, lat: ele!.latitude, lon: ele!.longitude, battery: percentage, location: locationDis ).then((e){
                      print("my resposne check in is ++++++++${e.isSuccess}");

                        if(e.isSuccess == true){
                          print("my respons ei s  ________________________${e
                              .isSuccess}");
                          String? str = e.result!.logTimeIn!;

                          final endIndex = str!.indexOf(":00", 0);

                           print("my check in time is $endIndex"); // Cars
                          const snackBar = SnackBar(
                            content: Text('Already checked in!'),
                          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState((){
                            checkInTime =  str.substring(11, endIndex) ;
                            print("my check IN time is +++++++++$checkInTime");
                          });
                        } else if(e.isSuccess == false) {
                          _showSnack("Already Checked IN");
                        }



                  })
                  : attendanceRepository.checkOutController(token!, 1, formatted, locationDis, ele!.latitude, ele!.longitude).then((e){
                    duration(e.result!.logTimeIn,e.result!.logTimeOut );
                      String str = e.result!.logTimeOut;

                      final endIndex = str.indexOf(":00", 0);
                    String strlogIn = e.result!.logTimeIn;

                    final endIndexLogIn = str.indexOf(":00", 0);

                    //  print(str.substring(11, endIndex)); // Cars

                    setState((){
                      checkOutTime =  str.substring(11, endIndex) ;
                      checkInTime = strlogIn.substring(11, endIndexLogIn) ;

                      print("my checkout time is +++++++++$checkOutTime");
                    });
                    _showSnack("Checked Out");

                  });


                });
               // GetAddressFromLatLong();
                changeCheckIn();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> getAddressFromLatLong(Position position) async {
    print("++++++++++++=GetAddressFromLatLong ++++++ working + ${position.latitude}");
    List<Placemark> _placemarksList = await placemarkFromCoordinates(position.latitude, position.longitude);

    print(_placemarksList);
    Placemark place = _placemarksList[0];
    String address = '${place.name},${place.street},${place.thoroughfare},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    print("my address is ++++++++++++ $address");
    setState((){
      locationDis = address;
    });

  }
duration(checkin, checkout){
  final DateTime checkInTime1 = DateTime.parse(checkin);
  final DateTime checkOutTime1 = DateTime.parse(checkout);

  final hours = checkOutTime1.difference(checkInTime1).inHours;
  final minutes= checkOutTime1.difference(checkInTime1).inMinutes;
  final totalWorkingHours = '$hours.${(minutes - (hours*60))} hrs';
  print("hours  "+totalWorkingHours);
  print("duration check in  "+checkInTime1.toString());
  setState((){
    totalhrs = totalWorkingHours ;
  }
  );

}
  void _showSnack(String msg) {
    final _snackBarContent = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
        .showSnackBar(_snackBarContent);
  }

// _getLocation() async
  // {
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   debugPrint('location: ${position.latitude}');
  //   final coordinates = new Coordinates(position.latitude, position.longitude);
  //   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   print("my address is +++++++++++++++++++++++++++++++++${first.featureName} : ${first.addressLine}");
  // }
}
