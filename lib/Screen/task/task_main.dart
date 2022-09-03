import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/expense/aproved.dart';
import 'package:salebee/Screen/expense/claimed.dart';
import 'package:salebee/Screen/expense/pending.dart';
import 'package:salebee/Screen/task/add_new_task.dart';
import 'package:salebee/Screen/task/all_task.dart';
import 'package:salebee/Screen/task/assigned_by_me.dart';
import 'package:salebee/Screen/task/assigned_to_me.dart';
import 'package:salebee/Screen/task/my_task.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/utils.dart';

enum timers { all, Follow_up_1, Follow_up_2,Follow_up_3,Follow_up_4 }
enum time { all, today, last_7,last_15 }
enum status { all, initiated, pending,Canceled,Done }

class Task extends StatefulWidget {
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  timers _site = timers.all;
  time _time = time.all;
  status _status = status.all;
  TaskRepository taskRepository = TaskRepository();
  @override
  void initState() {
    print("task page");
    //taskRepository.getTaskController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
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
        appBar: AppBar(
          title: const Text('Tasks',style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w600
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
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.filter_alt,color: primaryColor,),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            )
          ],
        ),
        endDrawer: Drawer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        IconButton(onPressed: (){
                          Get.back();
                        }, icon: Icon(Icons.close))
                      ],
                    ),
                    Text('Follow up Type',style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 10,),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('All'),
                      leading: Radio(
                        value: timers.all,
                        groupValue: _site,
                        onChanged: (timers? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Follow up 1'),
                      leading: Radio(
                        value: timers.Follow_up_1,
                        groupValue: _site,
                        onChanged: (timers? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Follow up 2'),
                      leading: Radio(
                        value: timers.Follow_up_2,
                        groupValue: _site,
                        onChanged: (timers? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Follow up 3'),
                      leading: Radio(
                        value: timers.Follow_up_3,
                        groupValue: _site,
                        onChanged: (timers? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Time',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w700
                    ),),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('All'),
                      leading: Radio(
                        value: time.all,
                        groupValue: _time,
                        onChanged: (time? value) {
                          setState(() {
                            _time = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Today'),
                      leading: Radio(
                        value: timers.Follow_up_1,
                        groupValue: _site,
                        onChanged: (timers? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Last 7 Days'),
                      leading: Radio(
                        value: time.last_7,
                        groupValue: _time,
                        onChanged: (time? value) {
                          setState(() {
                            _time = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Last 15 Days'),
                      leading: Radio(
                        value: time.last_15,
                        groupValue: _time,
                        onChanged: (time? value) {
                          setState(() {
                            _time = value!;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 20,),
                    Text('Status',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w700
                    ),),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('All'),
                      leading: Radio(
                        value: status.all,
                        groupValue: _status,
                        onChanged: (status? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Initiated'),
                      leading: Radio(
                        value: status.initiated,
                        groupValue: _status,
                        onChanged: (status? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Pending'),
                      leading: Radio(
                        value: status.pending,
                        groupValue: _status,
                        onChanged: (status? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Canceled'),
                      leading: Radio(
                        value: status.Canceled,
                        groupValue: _status,
                        onChanged: (status? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Done'),
                      leading: Radio(
                        value: status.Done,
                        groupValue: _status,
                        onChanged: (status? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
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
                        tabs: const [
                          Tab(
                            text: 'Assigned to me',
                          ),
                          Tab(
                            text: 'My Task',
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
                        child: AssignedToMe(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: MyTask(),
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
      ),
    );
  }
}
