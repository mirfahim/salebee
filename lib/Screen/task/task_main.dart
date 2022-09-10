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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          height: 58 ,
          color: Color(0xFFE5E5E5),
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
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: Color(0xFFE5E5E5),
          elevation: 0,
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) {
                return InkWell(
                  onTap: (){
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('images/filter.png'),
                    ),
                  ),
                );
              }
            )
          ],
        ),
        endDrawer: Drawer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xFFF9FAFB,
                ),
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
                        color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
                      ),),
                      SizedBox(height: 10,),
                      ListTile(
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text('All',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Follow up 1',style: TextStyle(
                          fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Follow up 2',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Follow up 3',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                          color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
                      ),),
                      ListTile(
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text('All',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Today',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Last 7 Days',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Last 15 Days',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                          color: Colors.black,fontWeight: FontWeight.w700, fontSize: 10
                      ),),
                      ListTile(
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text('All',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Initiated',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Pending',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Canceled',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
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
                        title: const Text('Done',style: TextStyle(
                            fontSize: 12
                        ),),
                        leading: Radio(
                          activeColor: tabBarUnSelectedColor,
                          value: status.Done,
                          groupValue: _status,
                          onChanged: (status? value) {
                            setState(() {
                              _status = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: (){
                              // Get.to(OtherExpense());
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
                                  child: Text('Search',textAlign:TextAlign.center,style: TextStyle(
                                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Color(0xFFE5E5E5),
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
      ),
    );
  }
}
