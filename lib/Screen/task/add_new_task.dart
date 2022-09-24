import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/task/notification_service.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../Service/sharedPref_service.dart';
List<String> type = <String>['Call', 'Mail', 'Visit', 'Online Meeting'];
List<String> priority = <String>['High', 'Low', 'Normal', 'Very High', 'Very Low'];
List<String> repeat = <String>['No Repeat', 'Daily', 'Weekly', 'Monthly'];
List<String> prospect = <String>['Group 1', 'Group 2', 'Group 3', 'Group 4'];
List<String> contact_person = <String>['One', 'Two', 'Three', 'Four'];
List<String> lead = <String>['CCTV', 'CRM', 'Others', 'Lead for fire'];
List<String> assign_to = <String>['Superadmin1 test', 'superadmin2 test', 'Superadmin3 test', 'Superadmin4 test'];
List<String> status = <String>['Cancelled', 'Done', 'Incomplete',
  'Initiated', 'Need More Time', 'Need Others help','Partially done'];
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

  var startDateController = TextEditingController();
  var startTimeController = TextEditingController();
  var dueDateController = TextEditingController();
  var dueTimeController = TextEditingController();
  bool loader = false ;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int dropdownValueType = 0;
  int dropdownValuePriority = 0;
  int dropdownValueRepeat = 0;
  int dropdownValueProspect = 0;
  int dropdownValueContact_person = 0;
  int dropdownValueLead = 0;
  int dropdownValueLeadAssigned = 0;
  int dropdownValueLeadStatus = 0;
  DateTime notiDate = DateTime.now();
  late final LocalNotificationService service;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
   int _typeI = 0 ;

@override
  void initState() {
    // TODO: implement initState

    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:  Text('Add New Task',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 70),
                child: ListView(
                  children: [
                    Text('Task Title',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400,color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        controller: textTitleController,
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          hintText: 'Enter a task title',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Description',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        controller: textDescriptionController,
                        maxLines: 7,
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          hintText: 'Enter a task description',
                          // icon:
                          hintStyle:
                          TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Type',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueType == null ? null :  type[dropdownValueType],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),

                          items: type.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // This is called when the user selects an item.
                            setState(() {
                             // dropdownValuePriority = value!;
                              dropdownValueType = type.indexOf(value!);
                              print("selected index of type is ________________ $dropdownValueType");
                            });
                          },
                        ),
                      )
                    ),
                    SizedBox(height: 20,),
                    Text('Priority',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValuePriority == null ? null : priority[dropdownValuePriority],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValuePriority = priority.indexOf(value!);
                            });
                          },
                          items: priority.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                     Text('Start',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: borderColor, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              controller: startDateController,
                              readOnly: true,
                              onTap: (){
                                DatePicker.showDateTimePicker(context, showTitleActions: true,
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours.toString());
                                    }, onConfirm: (date) {
                                  String myDate = DateTime(date.year, date.month, date.day).toString() ;
                                  String myTime = DateTime(date.hour, date.minute,).toString() ;

                                  startDateController.text = myDate.substring(0, 10);
                                  startTimeController.text = myTime.substring(2, 7);
                                  notiDate = date ;
                                      print('confirm $date');
                                    },
                                    currentTime: DateTime.now());
                              },
                              onChanged: (value) {

                              },
                             // keyboardType: TextInputType.er,
                              decoration:   InputDecoration(
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Start Date',
                                suffixIcon: Icon(Icons.date_range_sharp, color: Color(0xFF7C8DB5),size: 14,),

                                hintStyle:
                                TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: borderColor, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              controller: startTimeController,
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                suffixIcon: Icon(Icons.access_time,color: Color(0xFF7C8DB5), size: 14,),
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Enter Time',
                                // icon:

                                hintStyle:
                                TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                     Text('Due',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: borderColor, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              controller: dueDateController,
                              readOnly: true,
                              onTap: (){
                                DatePicker.showDateTimePicker(context, showTitleActions: true,
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours.toString());
                                    }, onConfirm: (date) {
                                      String myDate = DateTime(date.year, date.month, date.day).toString() ;
                                      String myTime = DateTime(date.hour, date.minute,).toString() ;

                                      dueDateController.text = myDate.substring(0, 10);
                                      dueTimeController.text = myTime.substring(2, 7);
                                      print('confirm $date');
                                    },
                                    currentTime: DateTime.now());
                              },
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Due Date',
                                suffixIcon: Icon(Icons.date_range_rounded, color: Color(0xFF7C8DB5),size: 14,),

                                hintStyle:
                                TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: borderColor, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              controller: dueTimeController,
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                suffixIcon: Icon(
                                  Icons.access_time, color: Color(0xFF7C8DB5),
                                size: 14,),
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Enter Time',
                                // icon:

                                hintStyle:
                                TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('Reminder',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async{
                          await service.showScheduleNotification(id: 0, title: "fahim", body: "testing", sec: notiDate);
                        },
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                       // keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'No Reminder',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Repeat',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueRepeat == null ? null : repeat[dropdownValueRepeat],

                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValueRepeat = repeat.indexOf(value!);
                            });
                          },
                          items: repeat.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Prospect',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueProspect == null ? null : prospect[dropdownValueProspect],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {

                              dropdownValueProspect = prospect.indexOf(value!);
                            });
                          },
                          items: prospect.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Contact Person',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueContact_person == null ? null : contact_person[dropdownValueContact_person],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValueContact_person = contact_person.indexOf(value!);
                            });
                          },
                          items: contact_person
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Lead',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueLead == null ? null : lead[dropdownValueLead],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValueLead = lead.indexOf(value!);
                            });
                          },
                          items: lead.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Assign to',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueLeadAssigned == null ? null: assign_to[dropdownValueLeadAssigned],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValueLeadAssigned = assign_to.indexOf(value!);
                            });
                          },
                          items: assign_to.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Visible to',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Who can see',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text('Status',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400, color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValueLeadStatus == null ? null : status[dropdownValueLeadStatus],
                          icon:Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValueLeadStatus = status.indexOf(value!);
                            });
                          },
                          items: status.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        loader = true;
                      });
                      String? token = SharedPreff.to.prefss.getString("token");
                      if(textTitleController.text.isEmpty && textDescriptionController.text.isEmpty ) {
                        print("empty check title des${textTitleController.text}" + "${textTitleController.text}");
                        _showSnack("Please Fill the form!");
                      } else {
                        taskRepository.taskAddController(token: token!, title: textTitleController.text,
                            description: textDescriptionController.text, type: dropdownValueType , repeat: dropdownValueRepeat,
                            priority: dropdownValuePriority, status: dropdownValueLeadStatus ).then((value) {
                          if(value.isSuccess == true){
                            _showSnack(value.message!);
                            setState(() {
                              loader = false ;
                            });
                           // Get.to(OtherExpense());
                          } else {
                            _showSnack(value.message!);
                            setState(() {
                              loader = false ;
                            });
                          }
                        });
                      }


                    },
                    child: Container(
                      height: 48,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkBlue
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Create',textAlign:TextAlign.center,style: TextStyle(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700
                          ),),
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
