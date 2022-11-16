// import 'dart:ffi';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:salebee/Data/static_data.dart';
// import 'package:salebee/Model/getListForTaskModel.dart';
// import 'package:salebee/Screen/task/notification_service.dart';
// import 'package:salebee/repository/add_task_repository.dart';
// import 'package:salebee/utils.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../../Service/sharedPref_service.dart';
//
// List<String> type = <String>['Call', 'Mail', 'Visit', 'Online Meeting'];
// List<String> priority = <String>[
//   'High',
//   'Low',
//   'Normal',
//   'Very High',
//   'Very Low'
// ];
// List<String> repeat = <String>['No Repeat', 'Daily', 'Weekly', 'Monthly'];
// List<String> prospect = <String>['Group 1', 'Group 2', 'Group 3', 'Group 4'];
// List<String> contact_person = <String>['One', 'Two', 'Three', 'Four'];
// List<String> lead = <String>['CCTV', 'CRM', 'Others', 'Lead for fire'];
// List<String> assign_to = <String>[
//   'Superadmin1 test',
//   'superadmin2 test',
//   'Superadmin3 test',
//   'Superadmin4 test'
// ];
// List<String> status = <String>[
//   'Cancelled',
//   'Done',
//   'Incomplete',
//   'Initiated',
//   'Need More Time',
//   'Need Others help',
//   'Partially done'
// ];
// bool colorSelect = true;
//
// class CreateProspect extends StatefulWidget {
//   @override
//   State<CreateProspect> createState() => _AddNewTaskState();
// }
//
// class _AddNewTaskState extends State<CreateProspect> {
//   final selectedDate = DateTime.now().obs;
//   TaskRepository taskRepository = TaskRepository();
//
//   final pickedDate = ''.obs;
//   var textTitleController = TextEditingController();
//   var textDescriptionController = TextEditingController();
//   var textNoteController = TextEditingController();
//   int typeIndex = 1;
//   var startDateController = TextEditingController();
//   var startTimeController = TextEditingController();
//   var dueDateController = TextEditingController();
//   var dueTimeController = TextEditingController();
//   bool loader = false;
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//   int typeId = 0;
//   String? newType = "Select";
//   int priorityId = 0;
//   List concernPersonList = [];
//   List leadList = [];
//   String concernPerson = "";
//   String leadName = "";
//
//   String? newPriority;
//   int repeatId = 0;
//   String? newRepeat = "Select";
//   int prospectId = 0;
//   String? newProspect = "Select";
//   List prospectList = [];
//   // String? newStatus = "Select";
//   // String? newStatus = "Select";
//   int contact_personId = 0;
//   String? newCantactPerson;
//   int leadId = 0;
//   String? newLead;
//   int employeeId = 0;
//   String? newEmployee;
//   int leadAssignedId = 01;
//   final secondaryOpen = false.obs;
//   final optionalOpen = false.obs;
//   int assignToID = 01;
//   String? newLeadAssign = "Select";
//   int statusId = 0;
//   String? newStatus;
//   //TaskRepository taskRepository = TaskRepository();
//   DateTime notiDate = DateTime.now();
//   late final LocalNotificationService service;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   int _typeI = 0;
//   DateTime now1 = DateTime.now();
//   List<String> allList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     startDateController.text = DateTime.now().toString().substring(0, 10);
//     startTimeController.text = DateTime(now1.hour, now1.minute)
//         .toString()
//         .substring(2, 7)
//         .replaceAll("-", ".");
//     service = LocalNotificationService();
//     taskRepository.getAllListForTaskController().then((value) {
//       newStatus = value.result!["SelectListTaskStatus"]![4].text;
//       newLead = value.result!["SelectListLeads"]![0].text;
//       newCantactPerson = value.result!["SelectListEmployee"]![0].text;
//       newEmployee = value.result!["SelectListEmployee"]![0].text;
//       newProspect = value.result!["SelectListProspects"]![0].text;
//       newPriority = value.result!["SelectListPriority"]![0].text;
//       //prospectList = value.result!["SelectListProspects"]!;
//     });
//     service.initialize();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final orientation = MediaQuery.of(context).orientation;
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       key: _scaffoldkey,
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         title: Text(
//           'Create Prospect',
//           style: TextStyle(color: appBarHeader, fontSize: 24),
//         ),
//         automaticallyImplyLeading: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           height: size.height,
//           color: Colors.grey.shade200,
//           child: Stack(
//             children: [
//               Padding(
//                 padding:
//                 const EdgeInsets.only(left: 10.0, right: 10, bottom: 70),
//                 child: FutureBuilder<GetListForTaskDataModel>(
//                     future: taskRepository.getAllListForTaskController(),
//                     builder: (context, snapshot) {
//                       snapshot.data!
//                           .result!["SelectListProspects"]!
//                           .forEach((element) {
//
//                         allList.add(element.text);
//                       });
//
//
//                       if (snapshot.hasError) {
//                         return ListView(
//                           children: [
//                             Text(
//                               'Task Title',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.red),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: TextFormField(
//                                 controller: textTitleController,
//                                 onChanged: (value) {
//                                   // _productController.searchProduct(value);
//                                 },
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   prefix: Container(
//                                     width: 20,
//                                   ),
//                                   hintText: 'Enter a task title',
//                                   // icon:
//
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.0,
//                                       fontFamily: 'Roboto',
//                                       color: tabBarUnSelectedColor),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Description',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: TextFormField(
//                                 controller: textDescriptionController,
//                                 maxLines: 7,
//                                 onChanged: (value) {
//                                   // _productController.searchProduct(value);
//                                 },
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   prefix: Container(
//                                     width: 20,
//                                   ),
//                                   hintText: 'Enter a task description',
//                                   // icon:
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.0,
//                                       fontFamily: 'Roboto',
//                                       color: tabBarUnSelectedColor),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Type',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: borderColor, width: 1),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10.0))),
//                                 child: Padding(
//                                   padding:
//                                   const EdgeInsets.only(left: 8, right: 8),
//                                   child: DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: typeId == null ? null : type[typeId],
//                                     icon: Icon(Icons.arrow_drop_down_outlined),
//                                     elevation: 16,
//                                     style: const TextStyle(
//                                         color: Colors.deepPurple),
//                                     underline: Container(
//                                       height: 2,
//                                       color: Colors.transparent,
//                                     ),
//                                     items: type.map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         // dropdownValuePriority = value!;
//                                         typeId = type.indexOf(value!);
//                                         print(
//                                             "selected index of type is ________________ $typeId");
//                                       });
//                                     },
//                                   ),
//                                 )),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Priority',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: leadAssignedId == null
//                                       ? null
//                                       : assign_to[leadAssignedId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       leadAssignedId =
//                                           assign_to.indexOf(value!);
//                                     });
//                                   },
//                                   items: assign_to
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Start',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                             color: borderColor, width: 1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(10.0))),
//                                     child: TextFormField(
//                                       controller: startDateController,
//                                       readOnly: true,
//                                       onTap: () {
//                                         DatePicker.showDateTimePicker(context,
//                                             showTitleActions: true,
//                                             onChanged: (date) {
//                                               print('change $date in time zone ' +
//                                                   date.timeZoneOffset.inHours
//                                                       .toString());
//                                             }, onConfirm: (date) {
//                                               String myDate = DateTime(date.year,
//                                                   date.month, date.day)
//                                                   .toString();
//                                               String myTime = DateTime(
//                                                 date.hour,
//                                                 date.minute,
//                                               ).toString();
//
//                                               startDateController.text =
//                                                   myDate.substring(0, 10);
//                                               startTimeController.text =
//                                                   myTime.substring(2, 7);
//                                               notiDate = date;
//                                               print('confirm $date');
//                                             }, currentTime: DateTime.now());
//                                       },
//                                       onChanged: (value) {},
//                                       // keyboardType: TextInputType.er,
//                                       decoration: InputDecoration(
//                                         prefix: Container(
//                                           width: 20,
//                                         ),
//                                         hintText: 'Start Date',
//                                         suffixIcon: Icon(
//                                           Icons.date_range_sharp,
//                                           color: Color(0xFF7C8DB5),
//                                           size: 14,
//                                         ),
//                                         hintStyle: TextStyle(
//                                             fontSize: 12.0,
//                                             fontFamily: 'Roboto',
//                                             color: tabBarUnSelectedColor),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                             color: borderColor, width: 1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(10.0))),
//                                     child: TextFormField(
//                                       controller: startTimeController,
//                                       onChanged: (value) {
//                                         // _productController.searchProduct(value);
//                                       },
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                         suffixIcon: Icon(
//                                           Icons.access_time,
//                                           color: Color(0xFF7C8DB5),
//                                           size: 14,
//                                         ),
//                                         prefix: Container(
//                                           width: 20,
//                                         ),
//                                         hintText: 'Enter Time',
//                                         // icon:
//
//                                         hintStyle: TextStyle(
//                                             fontSize: 12.0,
//                                             fontFamily: 'Roboto',
//                                             color: tabBarUnSelectedColor),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'Due',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                             color: borderColor, width: 1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(10.0))),
//                                     child: TextFormField(
//                                       controller: dueDateController,
//                                       readOnly: true,
//                                       onTap: () {
//                                         DatePicker.showDateTimePicker(context,
//                                             showTitleActions: true,
//                                             onChanged: (date) {
//                                               print('change $date in time zone ' +
//                                                   date.timeZoneOffset.inHours
//                                                       .toString());
//                                             }, onConfirm: (date) {
//                                               String myDate = DateTime(date.year,
//                                                   date.month, date.day)
//                                                   .toString();
//                                               String myTime = DateTime(
//                                                 date.hour,
//                                                 date.minute,
//                                               ).toString();
//
//                                               dueDateController.text =
//                                                   myDate.substring(0, 10);
//                                               dueTimeController.text =
//                                                   myTime.substring(2, 7);
//                                               print('confirm $date');
//                                             }, currentTime: DateTime.now());
//                                       },
//                                       onChanged: (value) {
//                                         // _productController.searchProduct(value);
//                                       },
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                         prefix: Container(
//                                           width: 20,
//                                         ),
//                                         hintText: 'Due Date',
//                                         suffixIcon: Icon(
//                                           Icons.date_range_rounded,
//                                           color: Color(0xFF7C8DB5),
//                                           size: 14,
//                                         ),
//                                         hintStyle: TextStyle(
//                                             fontSize: 12.0,
//                                             fontFamily: 'Roboto',
//                                             color: tabBarUnSelectedColor),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                             color: borderColor, width: 1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(10.0))),
//                                     child: TextFormField(
//                                       controller: dueTimeController,
//                                       onChanged: (value) {
//                                         // _productController.searchProduct(value);
//                                       },
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                         suffixIcon: Icon(
//                                           Icons.access_time,
//                                           color: Color(0xFF7C8DB5),
//                                           size: 14,
//                                         ),
//                                         prefix: Container(
//                                           width: 20,
//                                         ),
//                                         hintText: 'Enter Time',
//                                         // icon:
//
//                                         hintStyle: TextStyle(
//                                             fontSize: 12.0,
//                                             fontFamily: 'Roboto',
//                                             color: tabBarUnSelectedColor),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Reminder',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 onTap: () async {
//                                   await service.showScheduleNotification(
//                                       id: 0,
//                                       title: "fahim",
//                                       body: "testing",
//                                       sec: notiDate);
//                                 },
//                                 onChanged: (value) {
//                                   // _productController.searchProduct(value);
//                                 },
//                                 // keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   prefix: Container(
//                                     width: 20,
//                                   ),
//                                   suffixIcon:
//                                   Icon(Icons.arrow_drop_down_outlined),
//                                   hintText: 'No Reminder',
//                                   // icon:
//
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.0,
//                                       fontFamily: 'Roboto',
//                                       color: tabBarUnSelectedColor),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Repeat',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: repeatId == null
//                                       ? null
//                                       : repeat[repeatId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       repeatId = repeat.indexOf(value!);
//                                     });
//                                   },
//                                   items: repeat.map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Prospect',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: prospectId == null
//                                       ? null
//                                       : prospect[prospectId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       prospectId = prospect.indexOf(value!);
//                                     });
//                                   },
//                                   items: prospect.map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Contact Person',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: leadAssignedId == null
//                                       ? null
//                                       : assign_to[leadAssignedId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       leadAssignedId =
//                                           assign_to.indexOf(value!);
//                                     });
//                                   },
//                                   items: assign_to
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Lead',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: leadAssignedId == null
//                                       ? null
//                                       : assign_to[leadAssignedId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       leadAssignedId =
//                                           assign_to.indexOf(value!);
//                                     });
//                                   },
//                                   items: assign_to
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Assign to',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: leadAssignedId == null
//                                       ? null
//                                       : assign_to[leadAssignedId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       leadAssignedId =
//                                           assign_to.indexOf(value!);
//                                     });
//                                   },
//                                   items: assign_to
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'Visible to',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: TextFormField(
//                                 onChanged: (value) {
//                                   // _productController.searchProduct(value);
//                                 },
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   prefix: Container(
//                                     width: 20,
//                                   ),
//                                   suffixIcon:
//                                   Icon(Icons.arrow_drop_down_outlined),
//                                   hintText: 'Who can see',
//                                   // icon:
//
//                                   hintStyle: TextStyle(
//                                       fontSize: 12.0,
//                                       fontFamily: 'Roboto',
//                                       color: tabBarUnSelectedColor),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Text(
//                               'Status',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: text),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border:
//                                   Border.all(color: borderColor, width: 1),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10.0))),
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 8, right: 8),
//                                 child: DropdownButton<String>(
//                                   isExpanded: true,
//                                   value: leadAssignedId == null
//                                       ? null
//                                       : assign_to[leadAssignedId],
//                                   icon: Icon(Icons.arrow_drop_down_outlined),
//                                   elevation: 16,
//                                   style:
//                                   const TextStyle(color: Colors.deepPurple),
//                                   underline: Container(
//                                     height: 2,
//                                     color: Colors.transparent,
//                                   ),
//                                   onChanged: (String? value) {
//                                     // This is called when the user selects an item.
//                                     setState(() {
//                                       leadAssignedId =
//                                           assign_to.indexOf(value!);
//                                     });
//                                   },
//                                   items: assign_to
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         );
//                       } else if (snapshot.data != null) {
//                         print(
//                             "my all list is __________________________${snapshot.data!.result!["SelectListProspects"]![0].text}");
//                         print(
//                             "my all list is __________________________${snapshot.data!.result!["SelectListEmployee"]![0].text}");
//                         var dropdownValueSelectListEmployee = snapshot
//                             .data!.result!["SelectListEmployee"]![0].text;
//                         var dropdownValueSelectListLead =
//                         snapshot.data!.result!["SelectListLeads"]!;
//                         var statusList =
//                         snapshot.data!.result!["SelectListTaskStatus"]!;
//                         var dropdownValueSelectListSelectListStatus = snapshot
//                             .data!.result!["SelectListTaskStatus"]![0].text;
//                         var dropdownValueSelectListSelectListPriority = snapshot
//                             .data!.result!["SelectListPriority"]![0].text;
//                         return ExpandableNotifier(
//                           child: ListView(
//                             children: [
//                               Text(
//                                 'Task Title',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: text),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: borderColor, width: 1),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10.0))),
//                                 child: TextFormField(
//                                   controller: textTitleController,
//                                   onChanged: (value) {
//                                     // _productController.searchProduct(value);
//                                   },
//                                   keyboardType: TextInputType.text,
//                                   decoration: InputDecoration(
//                                     prefix: Container(
//                                       width: 20,
//                                     ),
//                                     hintText: 'Enter a task title',
//                                     // icon:
//
//                                     hintStyle: TextStyle(
//                                         fontSize: 12.0,
//                                         fontFamily: 'Roboto',
//                                         color: tabBarUnSelectedColor),
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 'Description',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: text),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: borderColor, width: 1),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10.0))),
//                                 child: TextFormField(
//                                   controller: textDescriptionController,
//                                   maxLines: 5,
//                                   onChanged: (value) {
//                                     // _productController.searchProduct(value);
//                                   },
//                                   keyboardType: TextInputType.text,
//                                   decoration: InputDecoration(
//                                     prefix: Container(
//                                       width: 15,
//                                     ),
//                                     hintText: 'Enter a task description',
//                                     // icon:
//                                     hintStyle: TextStyle(
//                                         fontSize: 12.0,
//                                         fontFamily: 'Roboto',
//                                         color: tabBarUnSelectedColor),
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 'Type',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: text),
//                               ),
//                               SizedBox(
//                                 height: 05,
//                               ),
//                               Container(
//                                 height: 60,
//                                 child: GridView.builder(
//                                     gridDelegate:
//                                     const SliverGridDelegateWithMaxCrossAxisExtent(
//                                         maxCrossAxisExtent: 100,
//                                         childAspectRatio: 6 / 2,
//                                         crossAxisSpacing: 10,
//                                         mainAxisSpacing: 10),
//                                     itemCount: type.length,
//                                     itemBuilder: (BuildContext ctx, index) {
//                                       return InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             typeIndex = index;
//                                             typeId = typeIndex;
//                                             //cat = incomeList[index];
//                                           });
//                                         },
//                                         child:  Expanded(
//                                           child: Container(
//
//                                             decoration:
//                                             BoxDecoration(
//                                               color: typeIndex == index ? Colors.blue :primaryColor,
//                                               borderRadius: const BorderRadius
//                                                   .only(
//                                                   topLeft: Radius
//                                                       .circular(
//                                                       30),
//                                                   topRight: Radius
//                                                       .circular(
//                                                       30),
//                                                   bottomLeft: Radius
//                                                       .circular(
//                                                       30),
//                                                   bottomRight: Radius
//                                                       .circular(
//                                                       30)),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                               const EdgeInsets
//                                                   .symmetric(
//                                                   horizontal:
//                                                   8.0,
//                                                   vertical:
//                                                   3),
//                                               child: Row(
//                                                 children:  [
//                                                   Icon(
//                                                     Icons.map,
//                                                     size: 12,
//                                                     color: Colors
//                                                         .white,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5,
//                                                   ),
//                                                   Text(
//                                                     type[index],
//                                                     overflow: TextOverflow.clip,
//                                                     style: TextStyle(
//
//                                                         fontSize: 12,
//                                                         color: Colors
//                                                             .white),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                               ),
//                               // Container(
//                               //     decoration: BoxDecoration(
//                               //         color: Colors.white,
//                               //         border: Border.all(
//                               //             color: borderColor, width: 1),
//                               //         borderRadius: const BorderRadius.all(
//                               //             Radius.circular(10.0))),
//                               //     child: Padding(
//                               //       padding: const EdgeInsets.only(
//                               //           left: 8, right: 8),
//                               //       child: DropdownButton<String>(
//                               //         isExpanded: true,
//                               //         value:
//                               //             typeId == null ? null : type[typeId],
//                               //         icon:
//                               //             Icon(Icons.arrow_drop_down_outlined),
//                               //         elevation: 16,
//                               //         style: const TextStyle(
//                               //             color: Colors.deepPurple),
//                               //         underline: Container(
//                               //           height: 2,
//                               //           color: Colors.transparent,
//                               //         ),
//                               //         items: type.map((String value) {
//                               //           return DropdownMenuItem<String>(
//                               //             value: value,
//                               //             child: Text(value),
//                               //           );
//                               //         }).toList(),
//                               //         onChanged: (value) {
//                               //           // This is called when the user selects an item.
//                               //           setState(() {
//                               //             // dropdownValuePriority = value!;
//                               //             typeId = type.indexOf(value!);
//                               //             print(
//                               //                 "selected index of type is ________________ $typeId");
//                               //           });
//                               //         },
//                               //       ),
//                               //     )),
//
//                               Text(
//                                 'Assign to',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: text),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: borderColor, width: 1),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10.0))),
//                                 child: Padding(
//                                   padding:
//                                   const EdgeInsets.only(left: 8, right: 8),
//                                   child: DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: newEmployee,
//                                     icon: Icon(Icons.arrow_drop_down_outlined),
//                                     elevation: 16,
//                                     style: const TextStyle(
//                                         color: Colors.deepPurple),
//                                     underline: Container(
//                                       height: 2,
//                                       color: Colors.transparent,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         newEmployee = value!;
//                                         snapshot.data!
//                                             .result!["SelectListEmployee"]!
//                                             .forEach((element) {
//                                           print("${element.text}" +
//                                               "$newEmployee");
//                                           if (element.text == newEmployee) {
//                                             StaticData.assignToID =
//                                                 int.parse(element.value);
//                                             print(
//                                                 "my assign id is ${StaticData.assignToID}");
//                                           } else {
//                                             // _showSnack("Task Assign to ${StaticData.assignToID}");
//                                             // print("no match in assign to");
//                                           }
//                                         });
//                                         // assignToID = snapshot
//                                         //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
//                                       });
//                                     },
//                                     items: snapshot
//                                         .data!.result!["SelectListEmployee"]!
//                                         .map((value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value.text.toString(),
//                                         child: Text(value.text.toString()),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 'Due',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: text),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: TextFormField(
//                                         controller: dueDateController,
//                                         readOnly: true,
//                                         onTap: () {
//                                           DatePicker.showDateTimePicker(context,
//                                               showTitleActions: true,
//                                               onChanged: (date) {
//                                                 print('change $date in time zone ' +
//                                                     date.timeZoneOffset.inHours
//                                                         .toString());
//                                               }, onConfirm: (date) {
//                                                 String myDate = DateTime(date.year,
//                                                     date.month, date.day)
//                                                     .toString();
//                                                 String myTime = DateTime(
//                                                   date.hour,
//                                                   date.minute,
//                                                 ).toString();
//
//                                                 dueDateController.text =
//                                                     myDate.substring(0, 10);
//                                                 dueTimeController.text =
//                                                     myTime.substring(2, 7);
//                                                 print('confirm $date');
//                                               }, currentTime: DateTime.now());
//                                         },
//                                         onChanged: (value) {
//                                           // _productController.searchProduct(value);
//                                         },
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           prefix: Container(
//                                             width: 20,
//                                           ),
//                                           hintText: 'Due Date',
//                                           suffixIcon: Icon(
//                                             Icons.date_range_rounded,
//                                             color: Color(0xFF7C8DB5),
//                                             size: 14,
//                                           ),
//                                           hintStyle: TextStyle(
//                                               fontSize: 12.0,
//                                               fontFamily: 'Roboto',
//                                               color: tabBarUnSelectedColor),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: TextFormField(
//                                         controller: dueTimeController,
//                                         onChanged: (value) {
//                                           // _productController.searchProduct(value);
//                                         },
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           suffixIcon: Icon(
//                                             Icons.access_time,
//                                             color: Color(0xFF7C8DB5),
//                                             size: 14,
//                                           ),
//                                           prefix: Container(
//                                             width: 20,
//                                           ),
//                                           hintText: 'Enter Time',
//                                           // icon:
//
//                                           hintStyle: TextStyle(
//                                               fontSize: 12.0,
//                                               fontFamily: 'Roboto',
//                                               color: tabBarUnSelectedColor),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ), //SelectListProspects
//
//                               Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(6),
//                                     color: primaryColorSecond.withOpacity(.4)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         'Secondary Information',
//                                         style: TextStyle(fontWeight: FontWeight.w600),
//                                       ),
//                                       Obx(() => InkWell(
//                                           onTap: () {
//                                             if (secondaryOpen.value == false) {
//                                               secondaryOpen.value = true;
//                                             } else {
//                                               secondaryOpen.value = false;
//                                             }
//                                           },
//                                           child:
//                                           secondaryOpen.value == false
//                                               ? Icon(Icons.keyboard_arrow_down_rounded)
//                                               : Icon(Icons.keyboard_arrow_up)))
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 height: 20,
//                               ), //SelectListProspects
//
//                               Obx(() => secondaryOpen.value == true ? Container(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Prospect',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                             color: text),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                   color: borderColor, width: 1),
//                                               borderRadius: const BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8, right: 8),
//                                             child:  DropdownButtonHideUnderline(
//                                               child: DropdownSearch<String>(
//                                                 popupProps: PopupProps.menu(
//                                                   showSearchBox: true,
//                                                   showSelectedItems: true,
//                                                   disabledItemFn: (String s) => s.startsWith('I'),
//                                                 ),
//                                                 items: allList,
//                                                 dropdownDecoratorProps: DropDownDecoratorProps(
//                                                   dropdownSearchDecoration: InputDecoration(
//
//                                                     hintText: "country in menu mode",
//                                                   ),
//                                                 ),
//                                                 onChanged:(String? value) {
//                                                   // This is called when the user selects an item.
//                                                   print('taxGroup $value');
//
//                                                   setState(() {
//                                                     newProspect = value;
//                                                     snapshot.data!
//                                                         .result!["SelectListProspects"]!
//                                                         .forEach((element) {
//                                                       // print("${element.text}"+"$newLead");
//                                                       if (element.text == newProspect) {
//                                                         StaticData.prospectID =
//                                                             int.parse(element.value);
//                                                         print(
//                                                             "my assign id is ${StaticData.prospectID}");
//                                                       } else {
//                                                         // _showSnack("Task Assign to ${StaticData.assignToID}");
//                                                         // print("no match in assign to");
//                                                       }
//                                                     });
//                                                   });
//
//                                                   taskRepository
//                                                       .getProspectLeadandConcern(
//                                                       StaticData.prospectID)
//                                                       .then((value) {
//                                                     for (var element in value.result!) {
//                                                       for (var con in element.contact!) {
//                                                         setState(() {
//
//                                                           concernPersonList.clear();
//
//                                                           //concernPersonList.add("select");
//                                                           concernPersonList.add(
//
//                                                             con.name,
//
//                                                           );
//
//                                                           print("my concern person list is ${concernPersonList.length.toString()}");
//                                                           concernPerson = concernPersonList[0];
//                                                         });
//
//
//                                                       }
//                                                       for (var lead in element.lead!) {
//                                                         setState(() {
//
//                                                           leadList.clear();
//
//                                                           //concernPersonList.add("select");
//                                                           leadList.add(  lead!.leadName!);
//
//                                                           print("my leadlist list is ${leadList.length.toString()}");
//                                                           leadName = leadList[0];
//                                                         });
//
//
//                                                       }
//                                                     }
//                                                   });
//                                                 },
//                                                 selectedItem: allList[0],
//                                               ),
//                                             ),
//                                           )),
//
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'Contact Person',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                             color: text),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                   color: borderColor, width: 1),
//                                               borderRadius: const BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8, right: 8),
//                                             child: DropdownButton<String>(
//                                               isExpanded: true,
//                                               value: concernPerson,
//                                               icon:
//                                               Icon(Icons.arrow_drop_down_outlined),
//                                               elevation: 16,
//                                               style: const TextStyle(
//                                                   color: Colors.deepPurple),
//                                               underline: Container(
//                                                 height: 2,
//                                                 color: Colors.transparent,
//                                               ),
//                                               onChanged: (String? value) {
//                                                 // This is called when the user selects an item.
//                                                 print('taxGroup $value');
//
//                                                 setState(() {
//                                                   concernPerson = value!;
//                                                   concernPersonList
//                                                       .forEach((element) {
//                                                     // print("${element.text}"+"$newLead");
//                                                     if (element ==
//                                                         concernPerson) {
//                                                       StaticData.contactPerson =
//                                                           int.parse(element);
//                                                       print(
//                                                           "my assign id is ${StaticData.contactPerson}");
//                                                     } else {
//                                                       // _showSnack("Task Assign to ${StaticData.assignToID}");
//                                                       // print("no match in assign to");
//                                                     }
//                                                   });
//                                                 });
//                                               },
//                                               items:
//
//                                               concernPersonList
//                                                   .map((value) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value.toString(),
//                                                   child: Text(value.toString()),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           )),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'Lead',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                             color: text),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               border: Border.all(
//                                                   color: borderColor, width: 1),
//                                               borderRadius: const BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8, right: 8),
//                                             child: DropdownButton<String>(
//                                               isExpanded: true,
//                                               value: leadName ?? "select",
//                                               icon:
//                                               Icon(Icons.arrow_drop_down_outlined),
//                                               elevation: 16,
//                                               style: const TextStyle(
//                                                   color: Colors.deepPurple),
//                                               underline: Container(
//                                                 height: 2,
//                                                 color: Colors.transparent,
//                                               ),
//                                               onChanged: (String? value) {
//                                                 // This is called when the user selects an item.
//                                                 setState(() {
//                                                   newLead = value!;
//                                                   snapshot
//                                                       .data!.result!["SelectListLeads"]!
//                                                       .forEach((element) {
//                                                     // print("${element.text}"+"$newLead");
//                                                     if (element.text == newLead) {
//                                                       StaticData.leadID =
//                                                           int.parse(element.value);
//                                                       print(
//                                                           "my lead id is ${StaticData.leadID}");
//                                                     } else {
//                                                       // _showSnack("Task Assign to ${StaticData.assignToID}");
//                                                       // print("no match in assign to");
//                                                     }
//                                                   });
//                                                 });
//                                               },
//                                               items:leadList
//                                                   .map((value) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value.toString(),
//                                                   child: Text(value.toString()),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           )),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                     ],
//                                   )
//
//                               ): Container(),),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(6),
//                                     color: primaryColorSecond.withOpacity(.4)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         'Optional Information',
//                                         style: TextStyle(fontWeight: FontWeight.w600),
//                                       ),
//                                       Obx(() => InkWell(
//                                           onTap: () {
//                                             if (optionalOpen.value == false) {
//                                               optionalOpen.value = true;
//                                             } else {
//                                               optionalOpen.value = false;
//                                             }
//                                           },
//                                           child:
//                                           optionalOpen.value == false
//                                               ? Icon(Icons.keyboard_arrow_down_rounded)
//                                               : Icon(Icons.keyboard_arrow_up)))
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 height: 20,
//                               ), //SelectListProspects
//
//                               Obx(() => optionalOpen.value == true ? Container(
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Priority',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: text),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                                 color: borderColor, width: 1),
//                                             borderRadius:
//                                             const BorderRadius.all(
//                                                 Radius.circular(10.0))),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 8, right: 8),
//                                           child: DropdownButton<String>(
//                                             isExpanded: true,
//                                             value: newPriority,
//                                             icon: Icon(Icons
//                                                 .arrow_drop_down_outlined),
//                                             elevation: 16,
//                                             style: const TextStyle(
//                                                 color: Colors.deepPurple),
//                                             underline: Container(
//                                               height: 2,
//                                               color: Colors.transparent,
//                                             ),
//                                             onChanged: (String? value) {
//                                               // This is called when the user selects an item.
//                                               print('taxGroup $value');
//
//                                               setState(() {
//                                                 newPriority = value;
//                                                 snapshot
//                                                     .data!
//                                                     .result![
//                                                 "SelectListPriority"]!
//                                                     .forEach((element) {
//                                                   // print("${element.text}"+"$newLead");
//                                                   if (element.text ==
//                                                       newPriority) {
//                                                     StaticData.priorityID =
//                                                         int.parse(
//                                                             element.value);
//                                                     print(
//                                                         "my priority id is ${StaticData.priorityID}");
//                                                   } else {
//                                                     // _showSnack("Task Assign to ${StaticData.assignToID}");
//                                                     // print("no match in assign to");
//                                                   }
//                                                 });
//                                               });
//                                             },
//                                             items: snapshot
//                                                 .data!
//                                                 .result![
//                                             "SelectListPriority"]!
//                                                 .map((value) {
//                                               return DropdownMenuItem<String>(
//                                                 value: value.text.toString(),
//                                                 child: Text(
//                                                     value.text.toString()),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         )),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'Reminder',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: text),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius:
//                                           const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: TextFormField(
//                                         readOnly: true,
//                                         onTap: () async {
//                                           print(
//                                               "started working local on reminder");
//                                           await service
//                                               .showScheduleNotification(
//                                               id: 0,
//                                               title: "fahim",
//                                               body: "testing",
//                                               sec: notiDate);
//                                         },
//                                         onChanged: (value) {
//                                           // _productController.searchProduct(value);
//                                         },
//                                         // keyboardType: TextInputType.text,
//                                         decoration: InputDecoration(
//                                           prefix: Container(
//                                             width: 20,
//                                           ),
//                                           suffixIcon: Icon(
//                                               Icons.arrow_drop_down_outlined),
//                                           hintText: 'No Reminder',
//                                           // icon:
//
//                                           hintStyle: TextStyle(
//                                               fontSize: 12.0,
//                                               fontFamily: 'Roboto',
//                                               color: tabBarUnSelectedColor),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text(
//                                       'Repeat',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: text),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius:
//                                           const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8, right: 8),
//                                         child: DropdownButton<String>(
//                                           isExpanded: true,
//                                           value: repeatId == null
//                                               ? null
//                                               : repeat[repeatId],
//                                           icon: Icon(
//                                               Icons.arrow_drop_down_outlined),
//                                           elevation: 16,
//                                           style: const TextStyle(
//                                               color: Colors.deepPurple),
//                                           underline: Container(
//                                             height: 2,
//                                             color: Colors.transparent,
//                                           ),
//                                           onChanged: (String? value) {
//                                             // This is called when the user selects an item.
//                                             setState(() {
//                                               repeatId =
//                                                   repeat.indexOf(value!);
//                                             });
//                                           },
//                                           items: repeat
//                                               .map<DropdownMenuItem<String>>(
//                                                   (String value) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList(),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       'Visible to',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: text),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius:
//                                           const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8, right: 8),
//                                         child: DropdownButton<String>(
//                                           isExpanded: true,
//                                           value: newEmployee,
//                                           icon: Icon(
//                                               Icons.arrow_drop_down_outlined),
//                                           elevation: 16,
//                                           style: const TextStyle(
//                                               color: Colors.deepPurple),
//                                           underline: Container(
//                                             height: 2,
//                                             color: Colors.transparent,
//                                           ),
//                                           onChanged: (String? value) {
//                                             // This is called when the user selects an item.
//                                             setState(() {
//                                               newEmployee = value!;
//                                             });
//                                           },
//                                           items: snapshot.data!
//                                               .result!["SelectListEmployee"]!
//                                               .map((value) {
//                                             return DropdownMenuItem<String>(
//                                               value: value.text.toString(),
//                                               child:
//                                               Text(value.text.toString()),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ),
//
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Text(
//                                       'Status',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: text),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color: borderColor, width: 1),
//                                           borderRadius:
//                                           const BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8, right: 8),
//                                         child: DropdownButton<String>(
//                                           isExpanded: true,
//                                           icon: Icon(
//                                               Icons.arrow_drop_down_outlined),
//                                           elevation: 16,
//                                           style: const TextStyle(
//                                               color: Colors.deepPurple),
//                                           underline: Container(
//                                             height: 2,
//                                             color: Colors.transparent,
//                                           ),
//                                           items: snapshot
//                                               .data!
//                                               .result![
//                                           "SelectListTaskStatus"]!
//                                               .map((e) {
//                                             return DropdownMenuItem<String>(
//                                               value: e.text.toString(),
//                                               child: Text(e.text.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (String? value) {
//                                             setState(() {
//                                               newStatus = value!;
//                                             });
//                                           },
//                                           value: newStatus,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                               ): Container(),),
//
//
//
//
//                             ],
//                           ),
//                         );
//                       }
//                       return Container();
//                     }),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: InkWell(
//                     onTap: () {
//                       taskRepository.getAllListForTaskController();
//                       setState(() {
//                         loader = true;
//                       });
//                       String? token = SharedPreff.to.prefss.getString("token");
//                       if (textTitleController.text.isEmpty &&
//                           textDescriptionController.text.isEmpty) {
//                         print(
//                             "empty check title des${textTitleController.text}" +
//                                 "${textTitleController.text}");
//                         _showSnack("Please Fill the form!");
//                       } else {
//                         taskRepository
//                             .taskAddController(
//                             token: token!,
//                             title: textTitleController.text,
//                             description: textDescriptionController.text,
//                             type: typeId,
//                             repeat: repeatId,
//                             priority: StaticData.priorityID,
//                             status: statusId,
//                             leadID: StaticData.leadID,
//                             assignaTo: StaticData.assignToID)
//                             .then((value) {
//                           if (value.isSuccess == true) {
//                             _showSnack(value.message!);
//                             _showSnack("Task Assign to $newEmployee");
//                             setState(() {
//                               loader = false;
//                             });
//                             // Get.to(OtherExpense());
//                           } else {
//                             _showSnack(value.message!);
//
//                             setState(() {
//                               loader = false;
//                             });
//                           }
//                         });
//                       }
//                     },
//
//                     child: Container(
//                       height: 48,
//                       // width: size.width,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(6),
//                           color: darkBlue),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(
//                           child: Text(
//                             'Create',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSnack(String msg) {
//     final _snackBarContent = SnackBar(content: Text(msg));
//     ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
//         .showSnackBar(_snackBarContent);
//   }
//
//   _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value,
//       firstDate: DateTime(2015, 8),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate.value) {
//       selectedDate.value = picked;
//       pickedDate.value = DateFormat.yMMMd().format(picked);
//     }
//   }
// }
// class MyContact {
//   String? name;
//   int? id;
//
//   MyContact({
//     this.name,
//     this.id,
//   });
// }