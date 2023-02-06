import 'dart:ffi';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/getListForTaskModel.dart';
import 'package:salebee/Screen/task/add_task_form.dart';
import 'package:salebee/Screen/task/notification_service.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../Service/sharedPref_service.dart';

List<String> type = ['Call', 'Mail', 'Visit', 'Meeting'];
List<String> priority = <String>[
  'High',
  'Low',
  'Normal',
  'Very High',
  'Very Low'
];
List<String> repeat = <String>['No Repeat', 'Daily', 'Weekly', 'Monthly'];
List<String> prospect = <String>['Group 1', 'Group 2', 'Group 3', 'Group 4'];
List<String> contact_person = <String>['One', 'Two', 'Three', 'Four'];
List<String> lead = <String>['CCTV', 'CRM', 'Others', 'Lead for fire'];
List<String> assign_to = <String>[
  'Superadmin1 test',
  'superadmin2 test',
  'Superadmin3 test',
  'Superadmin4 test'
];
List<String> status = <String>[
  'Cancelled',
  'Done',
  'Incomplete',
  'Initiated',
  'Need More Time',
  'Need Others help',
  'Partially done'
];
bool colorSelect = true;

class AddNewTask extends StatefulWidget {
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final selectedDate = DateTime.now().obs;
  TaskRepository taskRepository = TaskRepository();

  final pickedDate = ''.obs;
  var textTitleController = TextEditingController();
  var textDescriptionController = TextEditingController();
  var textNoteController = TextEditingController();
  int typeIndex = 1;
  var startDateController = TextEditingController();
  var startTimeController = TextEditingController();
  var dueDateController = TextEditingController();
  var dueTimeController = TextEditingController();
  bool loader = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int typeId = 0;
  String? newType = "Select";
  int priorityId = 0;
  List concernPersonList = [];
  List leadList = [];
  String concernPerson = "";
  String leadName = "";

  String? newPriority;
  int repeatId = 0;
  String? newRepeat = "Select";
  int prospectId = 0;
  String? newProspect = "Select";
  List prospectList = [];
  // String? newStatus = "Select";
  // String? newStatus = "Select";
  int contact_personId = 0;
  String? newCantactPerson;
  int leadId = 0;
  String? newLead;
  int employeeId = 0;
  String? newEmployee;
  int leadAssignedId = 01;
  final secondaryOpen = false.obs;
  final optionalOpen = false.obs;
  int assignToID = 01;
  String? newLeadAssign = "Select";
  int statusId = 0;
  String? newStatus;
  //TaskRepository taskRepository = TaskRepository();
  DateTime notiDate = DateTime.now();
  late final LocalNotificationService service;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _typeI = 0;
  DateTime now1 = DateTime.now();
  List<String> allList = [];

  @override
  void initState() {
    // TODO: implement initState
    startDateController.text = DateTime.now().toString().substring(0, 10);
    startTimeController.text = DateTime(now1.hour, now1.minute)
        .toString()
        .substring(2, 7)
        .replaceAll("-", ".");
    service = LocalNotificationService();
    taskRepository.getAllListForTaskController().then((value) {
      if(value.result == null){
      print("some error++");
      }else{
        newStatus = value.result!["SelectListTaskStatus"]![4].text;
        newLead = value.result!["SelectListLeads"]![0].text;
        newCantactPerson = value.result!["SelectListEmployee"]![0].text;
        newEmployee = value.result!["SelectListEmployee"]![0].text;
        newProspect = value.result!["SelectListProspects"]![0].text;
        newPriority = value.result!["SelectListPriority"]![0].text;
      }

      //prospectList = value.result!["SelectListProspects"]!;
    });
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Add New Task',
          style: TextStyle(color: appBarHeader, fontSize: 24),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: primaryColorLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: AddTaskForm(followUp: false,),
      ),
    );
  }

  void _showSnack(String msg) {
    final _snackBarContent = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
        .showSnackBar(_snackBarContent);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      pickedDate.value = DateFormat.yMMMd().format(picked);
    }
  }
}
class MyContact {
  String? name;
  int? id;

  MyContact({
     this.name,
    this.id,
  });
}