// import 'package:battery_plus/battery_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:salebee/Helper/api_helper.dart';
// import 'package:salebee/Screen/Attendance/attendance_report.dart';
// import 'package:salebee/Utils/Alerts.dart';
// import 'package:salebee/Widget/clock_widget.dart';
//
// import '../../Helper/location_helper.dart';
// import '../../Utils/my_colors.dart';
//
// class CheckInOutPage extends StatefulWidget {
//   @override
//   profilePageState createState() => profilePageState();
// }
//
// class profilePageState extends State<CheckInOutPage> {
//   LocationPermission? permission;
//   GeolocatorService geolocatorService = GeolocatorService();
//   ApiService apiService = ApiService();
//   var battery = Battery();
//   bool checkIn = true;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text(
//             'Attendance',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           leading: Icon(
//             Icons.menu,
//             color: Colors.blue,
//           ),
//           actions: [
//             Icon(
//               Icons.settings,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//         body: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 50,
//               child: AppBar(
//                 backgroundColor: Colors.white,
//                 bottom: TabBar(
//                   labelColor: Colors.black,
//                   tabs: [
//                     Tab(
//                       text: "Check In-Out",
//                     ),
//                     Tab(
//                       text: "Report",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // create widgets for each tab bar here
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // first tab bar view widget
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("08:47 pm"),
//                       Text("Thursday "),
//                       Container(
//                         child: Center(
//                           child: GestureDetector(
//                             onTap: ()  {
//                               print("working 11111");
//                               _showMyDialog();
//
//
//                             },
//                             child: CircleAvatar(
//                               radius: 74,
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 72,
//                                 child: CircleAvatar(
//                                   radius: 70,
//                                   child: checkIn == true ? CustomWatch(MyColors.appColor):CustomWatch(Colors.redAccent),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       checkIn == true ? Text("Check In") :  Text("Check Out"),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.location_on_outlined),
//                           Text("Area Name"),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//
//                   // second tab bar viiew widget
//                   Container(
//                     height: 20,
//                     color: Colors.white,
//                     child: MonthsReportTab(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void changeCheckIn() {
//     print(checkIn);
//     setState(() {
//       checkIn = !checkIn;
//     });
//   }
//
//   Future<dynamic> checkInController(int id, int employeeId, DateTime logTimeIn, double lat, double lon) async {
//     print("working 1");
//     Map<String, dynamic> bodyString = {
//       "Id": id,
//       "EmployeeId": employeeId,
//       "LogTimeIn": logTimeIn.toString(),
//       "LogTimeOut": "2022-07-30T04:45:03.239Z",
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
//       "Token": "string",
//       "Active": true,
//       "CreatedBy": 0,
//       "CreatedOn": "2022-07-30T04:45:03.240Z",
//       "UpdatedBy": 0,
//       "UpdatedOn": "2022-07-30T04:45:03.240Z",
//       "IsDeleted": true
//     };
//     return
//         //  apiClient.post(url: "delivery_boy_login", body: bodyString);
//         apiService.makeApiRequest(
//             method: apiMethods.post,
//             url: "CheckIn",
//             body: bodyString); //we will fetch the overview from this request
//   }
//
//   Future<dynamic> checkOutController() async {
//     print("working chekout");
//     Map<String, dynamic> bodyString = {
//       "Token": 0,
//       "EmployeeId": 0,
//       "CheckOutDateTime": "2022-07-30T04:45:03.239Z",
//       "Location": "Striing",
//       "Latitude": 0,
//       "Longitude": 0,
//     };
//     return
//         //  apiClient.post(url: "delivery_boy_login", body: bodyString);
//         apiService.makeApiRequest(
//             method: apiMethods.post,
//             url: "Login",
//             body: bodyString); //we will fetch the overview from this request
//   }
//
//   Future<void> _showMyDialog() async {
//     changeCheckIn();
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Alert'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('Are you sure ?'),
//                 Text('You want to check in?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Approve'),
//               onPressed: () {
//                 geolocatorService.determinePosition().then((ele) {
//                   print("my position is ${ ele?.latitude}");
//                   DateTime now = DateTime.now();
//
//                   checkInController(1, 1, now, ele!.latitude, ele!.longitude);
//
//                   //     .then((value) {
//                   //   // if(value['Message'] == "ok" ) {
//                   //   //
//                   //   // }
//                   // });
//                 }
//
//                 );
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
