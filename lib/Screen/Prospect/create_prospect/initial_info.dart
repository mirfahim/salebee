import 'dart:ffi';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/getListForTaskModel.dart';
import 'package:salebee/Screen/task/notification_service.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../Service/sharedPref_service.dart';

List<String> type = <String>['Call', 'Mail', 'Visit', 'Online Meeting'];
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

class CreateInitialProspect extends StatefulWidget {
  @override
  State<CreateInitialProspect> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<CreateInitialProspect> {
  final selectedDate = DateTime.now().obs;
  TaskRepository taskRepository = TaskRepository();
  ProspectRepository prospectRepository = ProspectRepository();

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
      newStatus = value.result!["SelectListTaskStatus"]![4].text;
      newLead = value.result!["SelectListLeads"]![0].text;
      newCantactPerson = value.result!["SelectListEmployee"]![0].text;
      newEmployee = value.result!["SelectListEmployee"]![0].text;
      newProspect = value.result!["SelectListProspects"]![0].text;
      newPriority = value.result!["SelectListPriority"]![0].text;
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
      backgroundColor: primaryColorLight,
      body: SafeArea(
        child: Container(
          height: size.height,
          color:primaryColorLight,
          child: Stack(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 70),
                child: FutureBuilder<GetListForTaskDataModel>(
                    future: taskRepository.getAllListForTaskController(),
                    builder: (context, snapshot) {
                      if(snapshot.data == null){
                          print("error in prospect initial");
                      }else {
                        snapshot.data!.result!["SelectListProspects"]!
                            .forEach((element) {
                          allList.add(element.text);
                        });
                        print(
                            "my all list is __________________________${snapshot.data!.result!["SelectListProspects"]![0].text}");
                        print(
                            "my all list is __________________________${snapshot.data!.result!["SelectListEmployee"]![0].text}");
                        var dropdownValueSelectListEmployee = snapshot
                            .data!.result!["SelectListEmployee"]![0].text;
                        var dropdownValueSelectListLead =
                        snapshot.data!.result!["SelectListLeads"]!;
                        var statusList =
                        snapshot.data!.result!["SelectListTaskStatus"]!;
                        var dropdownValueSelectListSelectListStatus = snapshot
                            .data!.result!["SelectListTaskStatus"]![0].text;
                        var dropdownValueSelectListSelectListPriority = snapshot
                            .data!.result!["SelectListPriority"]![0].text;
                      }


                      if (snapshot.hasError) {
                        return Container(
                          child: Text("No Data"),
                        );
                      } else if (snapshot.data != null) {

                        return ExpandableNotifier(
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Organization Name',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: TextFormField(
                                  controller: textTitleController,
                                  onChanged: (value) {
                                    // _productController.searchProduct(value);
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefix: Container(
                                      width: 20,
                                    ),
                                    hintText: 'Enter a task title',
                                    // icon:

                                    hintStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Roboto',
                                        color: tabBarUnSelectedColor),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Organization Short Name',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: TextFormField(
                                  controller: textTitleController,
                                  onChanged: (value) {
                                    // _productController.searchProduct(value);
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefix: Container(
                                      width: 20,
                                    ),
                                    hintText: 'Enter a task title',
                                    // icon:

                                    hintStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Roboto',
                                        color: tabBarUnSelectedColor),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),






                              Text(
                                'Industry Type',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Interested Item',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Information Source',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Prospect Assign to',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Organization Type',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Prospect Status',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Campaign',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: text),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: newEmployee,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        newEmployee = value!;
                                        snapshot.data!
                                            .result!["SelectListEmployee"]!
                                            .forEach((element) {
                                          print("${element.text}" +
                                              "$newEmployee");
                                          if (element.text == newEmployee) {
                                            StaticData.assignToID =
                                                int.parse(element.value);
                                            print(
                                                "my assign id is ${StaticData.assignToID}");
                                          } else {
                                            // _showSnack("Task Assign to ${StaticData.assignToID}");
                                            // print("no match in assign to");
                                          }
                                        });
                                        // assignToID = snapshot
                                        //     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                      });
                                    },
                                    items: snapshot
                                        .data!.result!["SelectListEmployee"]!
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.text.toString(),
                                        child: Text(value.text.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ), //SelectListProspects





                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      print("prospect add");
                      prospectRepository.prospectAddController(prospectName: textTitleController.text);
                    },
                    child: Container(
                      height: 48,
                      // width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkBlue),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Create',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
