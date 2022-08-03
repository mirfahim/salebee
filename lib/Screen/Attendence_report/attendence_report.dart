import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Attendence_report/report.dart';

import '../../utils.dart';
import 'check_in_out.dart';

class AttendenceReport extends StatelessWidget {
  const AttendenceReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Attendance',style: TextStyle(
            color: Colors.black
          ),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.help, color: primaryColor,))
          ],
        ),
        body: ListView(
          children:  [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: TabBar(
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            text: 'Check-in-out',
                          ),
                          Tab(
                            text: 'Report',
                          )
                        ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: primaryColorSecond)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today,color: primaryColorSecond,size: 14,),
                            const SizedBox(width: 5,),
                            Text('2022',style: TextStyle(
                                color: primaryColorSecond
                            ),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
             SizedBox(
              height: 500,
              child: TabBarView(
                  children: [
                    CheckInOut(),
                    Report()
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
