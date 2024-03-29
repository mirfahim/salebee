import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Provider/Login/provider_manager.dart';
import 'package:salebee/Screen/expense/aproved.dart';
import 'package:salebee/Screen/expense/claimed.dart';
import 'package:salebee/Screen/expense/pending.dart';
import 'package:salebee/Screen/task/add_new_task.dart';
import 'package:salebee/Screen/task/all_task.dart';
import 'package:salebee/Screen/task/assigned_by_me.dart';
import 'package:salebee/Screen/task/assigned_to_me.dart';
import 'package:salebee/Screen/task/my_task.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/utils.dart';

import '../../Model/getListForTaskModel.dart';
import '../test_screen.dart';

enum timers { all, Follow_up_1, Follow_up_2,Follow_up_3,Follow_up_4 }
enum time { all, today, last_7,last_15 }
enum status { all, initiated, pending,Canceled,Done }
enum priorities {All, High,
Low,
Normal,
Very_High,
Very_Low }

class Task extends StatefulWidget {
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  timers _site = timers.all;
  time _time = time.all;
  List<String> allStatusList = [];
  var statusMap ;
  status _status = status.all;
   priorities _priority = priorities.High;
  TaskRepository taskRepository = TaskRepository();
  //UserAuthProvider providersss = UserAuthProvider();
  @override
  void initState() {
    print("task page");
    //taskRepository.getTaskController();
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderManager providersss = Provider.of<ProviderManager>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: primaryColorLight,
        bottomNavigationBar: Container(
          height: 58 ,
          color: primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){
                Get.to(AddNewTask());
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
                    child: Text('Add New Task',textAlign:TextAlign.center,style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(

          title:  Text('Tasks',style: TextStyle(
              color: appBarHeader,fontSize: 24
          ),),
          leading: IconButton(
            onPressed: (){
             Get.back();
             // Get.to(TestMyApp());
             // _autoCompleteTextField();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: primaryColorLight,
          elevation: 0,
          centerTitle: true,
         // actions: [
         //    Builder(
         //      builder: (context) {
         //        return InkWell(
         //          onTap: (){
         //            Scaffold.of(context).openEndDrawer();
         //          },
         //          child: Container(
         //            child: Padding(
         //              padding: const EdgeInsets.all(4.0),
         //              child: Image.asset('images/filter.png'),
         //            ),
         //          ),
         //        );
         //      }
         //    )
         // ],
        ),
        // endDrawer: Drawer(
        //   child: SafeArea(
        //     child: SingleChildScrollView(
        //       child: Container(
        //         color: Color(0xFFF9FAFB,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Container(),
        //                   IconButton(onPressed: (){
        //                     Get.back();
        //                   }, icon: Icon(Icons.close))
        //                 ],
        //               ),
        //               Text('Follow up Type',style: TextStyle(
        //                 color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
        //               ),),
        //               SizedBox(height: 10,),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('All',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: timers.all,
        //                   groupValue: _site,
        //                   onChanged: (timers? value) {
        //                     setState(() {
        //                       _site = value!;
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Follow up 1',style: TextStyle(
        //                   fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: timers.Follow_up_1,
        //                   groupValue: _site,
        //                   onChanged: (timers? value) {
        //                     setState(() {
        //                       _site = value!;
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Follow up 2',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: timers.Follow_up_2,
        //                   groupValue: _site,
        //                   onChanged: (timers? value) {
        //                     setState(() {
        //                       _site = value!;
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Follow up 3',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: timers.Follow_up_3,
        //                   groupValue: _site,
        //                   onChanged: (timers? value) {
        //                     setState(() {
        //                       _site = value!;
        //                     });
        //                   },
        //                 ),
        //               ),
        //               SizedBox(height: 20,),
        //               Text('Time',style: TextStyle(
        //                   color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
        //               ),),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('All',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: time.all,
        //                   groupValue: _time,
        //                   onChanged: (time? value) {
        //                     setState(() {
        //                       _time = value!;
        //                       int? selection = -10000;
        //                       value == time.all ?
        //                       selection = -10000 : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterDate(selection);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Today',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: time.today,
        //                   groupValue: _time,
        //                   onChanged: (time? value) {
        //                     setState(() {
        //                       _time = value!;
        //                      int? selection =0;
        //                       value == time.today ?
        //                       selection = 0 : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterDate(selection);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Last 7 Days',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: time.last_7,
        //                   groupValue: _time,
        //                   onChanged: (time? value) {
        //                     setState(() {
        //                       _time = value!;
        //                       int? selection = -7;
        //                       value == time.last_7 ?
        //                       selection = -7 : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterDate(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Last 15 Days',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: time.last_15,
        //                   groupValue: _time,
        //                   onChanged: (time? value) {
        //                     setState(() {
        //                       _time = value!;
        //                       int? selection = -15;
        //                       value == time.last_15 ?
        //                       selection = -15 : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterDate(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //
        //               SizedBox(height: 20,),
        //               Text('Priority',style: TextStyle(
        //                   color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
        //               ),),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('All',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.All,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                     // providerss.filterTask(value);
        //                     setState(() {
        //
        //                       _priority = value!;
        //                       String? selection = "";
        //                       value == priorities.All ? selection = "All" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection!);
        //
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('High',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.High,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                     // providerss.filterTask(value);
        //                     setState(() {
        //
        //                       _priority = value!;
        //                       String? selection = "";
        //                       value == priorities.High ? selection = "High" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Very High',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.Very_High,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                     // providerss.filterTask(value);
        //                     setState(() {
        //
        //
        //                       _priority = value!;
        //                       String selection = "" ;
        //                       value == priorities.Very_High ? selection = "Very High" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Normal',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.Normal,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                     // providerss.filterTask(value);
        //                     setState(() {
        //
        //                       _priority = value!;
        //                       String? selection = "Normal";
        //                       value == priorities.Normal ? selection = "Normal" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Low',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.Low,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     setState(() {
        //
        //                       _priority = value!;
        //                       String? selection = "" ;
        //                       value == priorities.Low ? selection = "Low" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        //                 title: const Text('Very Low',style: TextStyle(
        //                     fontSize: 12
        //                 ),),
        //                 leading: Radio(
        //                   activeColor: tabBarUnSelectedColor,
        //                   value: priorities.Very_Low,
        //                   groupValue: _priority,
        //                   onChanged: (priorities? value) {
        //                     setState(() {
        //
        //                       _priority = value!;
        //                       String? selection = "" ;
        //                       value == priorities.Very_Low ? selection = "Very Low" : null;
        //                       // UserAuthProvider providerss = Provider.of<UserAuthProvider>(context, listen: true);
        //                       providersss.filterTask(selection!);
        //                     });
        //                   },
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(10.0),
        //                 child: Align(
        //                   alignment: Alignment.bottomCenter,
        //                   child: InkWell(
        //                     onTap: (){
        //                       // Get.to(OtherExpense());
        //                     },
        //                     child: Container(
        //                       height: 48,
        //                       width: size.width,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(6),
        //                           color: darkBlue
        //                       ),
        //                       child: const Padding(
        //                         padding: EdgeInsets.all(8.0),
        //                         child: Center(
        //                           child: Text('Search',textAlign:TextAlign.center,style: TextStyle(
        //                               color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700
        //                           ),),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        body: FutureBuilder<GetListForTaskDataModel>(
          future:  taskRepository.getAllListForTaskController(),
          builder: (context, AsyncSnapshot<GetListForTaskDataModel> snapshot) {

            if(snapshot.data == null){
              print("error");
            } else {
              snapshot.data!.result!["SelectListTaskStatus"]!
                  .forEach((element) {

                print("yo bro ${element.text}");



                allStatusList.add(element.text);
                SharedPreff.to.prefss.setStringList("statusList", allStatusList);
                print("my status list is ${allStatusList.toString()}");
              });
            }


            if(snapshot.hasError){
              return   Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orange,

                    size: 100,
                  ));
            } if(snapshot.data == null ){
              return   Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orange,

                    size: 100,
                  ));
            } else {
              return SafeArea(
                child: Container(
                  color: primaryColorLight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TabBar(
                                indicatorColor: darkBlue,
                                labelColor: darkBlue,
                                unselectedLabelColor: Colors.grey,
                                isScrollable: true,
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                ),
                                tabs: const [
                                  Tab(
                                    text: 'My Task',
                                  ),
                                  Tab(
                                    text: 'Assigned to me',
                                  ),
                                  Tab(
                                    text: 'Assigned by me',
                                  ),
                                  Tab(
                                    text: 'All',
                                  ),
                                ],
                              ),
                            ),
                            // Expanded(child: Container())
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: MyTask(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: AssignedToMe(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: AssignedByMe(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: AllTask(),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            }

          }
        ),
      ),
    );
  }
List<String> dataList = [
  "jhjdf",
  "jnsflj"
];
  _autoCompleteTextField() {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return dataList.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
