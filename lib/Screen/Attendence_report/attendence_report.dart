import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Attendence_report/report.dart';

import '../../utils.dart';
import 'check_in_out.dart';

class AttendenceReport extends StatelessWidget {
   AttendenceReport({Key? key}) : super(key: key);
  final selectedDate = DateTime.now().obs;
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
          backgroundColor: primaryColorLight,
          centerTitle: true,
          title: const Text('Attendance',style: TextStyle(
            color: Colors.black
          ),),
          actions: [
            IconButton(onPressed: (){
              _dialogOpen(context,'');
            }, icon: Icon(Icons.help, color: primaryColor,))
          ],
        ),
        body: Column(
          children:  [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                color: primaryColorLight,
                child: Row(
                  children: [
                     Expanded(
                      flex: 4,
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
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: (){
                    //       _selectDate(context);
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all(color: primaryColorSecond)
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                    //         child: Row(
                    //
                    //           children: [
                    //             Icon(Icons.calendar_today,color: primaryColorSecond,size: 14,),
                    //             const SizedBox(width: 10,),
                    //             Obx(()=>Text('${selectedDate.value.year}',style: TextStyle(
                    //                 color: primaryColorSecond
                    //             ),))
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Expanded(
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
  void _dialogOpen(BuildContext context, String message) {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext cxt) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 300,
              child: Material(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\u2022',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.55,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'No Location Found due to phone\'s poor GPS reciever',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\u2022',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'No Location Found due to phone\'s poor GPS reciever',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\u2022',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'No Location Found due to phone\'s poor GPS reciever',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\u2022',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              'No Location Found due to phone\'s poor GPS reciever',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
