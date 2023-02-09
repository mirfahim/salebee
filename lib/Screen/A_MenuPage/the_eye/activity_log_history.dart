import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/map_screen.dart';

import '../../../utils.dart';

class ActivityLogHistory extends StatefulWidget {


  @override
  State<ActivityLogHistory> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<ActivityLogHistory> {
  List<FollowUpModel> trackingList = [
    FollowUpModel("Mirpur,DOHS, road 7", DateTime.now(), "33%"),
    FollowUpModel("Dhanmondi,kolabon, road 27", DateTime.now(), "34%"),
    FollowUpModel("Banani,K block, road 5", DateTime.now(), "65%"),
    FollowUpModel("Gulshan,DOHS, road 7", DateTime.now(), "53%"),
    FollowUpModel("Rampura,DOHS, road 7", DateTime.now(), "24%"),
    FollowUpModel("Banasree,DOHS, road 7", DateTime.now(), "76%"),
    FollowUpModel("AftabNagar,DOHS, road 7", DateTime.now(), "89%"),
    FollowUpModel("Malibag,DOHS, road 7", DateTime.now(), "34%"),
    FollowUpModel("Badda,DOHS, road 7", DateTime.now(), "78%"),
    FollowUpModel("Hatirjheel,lake road, road 7", DateTime.now(), "29%"),
    FollowUpModel("Shahbag,4rastar mor, road 7", DateTime.now(), "93%"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History of activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height -200,
              child: ListView.separated(
                itemCount: trackingList.length,
                itemBuilder: (BuildContext context, index) {
                  var data = trackingList[index];
                  return Container(

                    child: Row(
                      children: [

                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: primaryColorSecond.withOpacity(.3),
                                borderRadius:
                                BorderRadius.circular(
                                    6)),
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets
                                  .symmetric(vertical: 4.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        DateFormat('EEEE').format(data.date!).toString().substring(0,3) + ",",

                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                      Center(
                                        child: Text(
                                          " "+data.date
                                              .toString()
                                              .substring(8, 10),
                                          textAlign:
                                          TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,

                                          ),

                                        ),
                                      ),
                                      Text(DateFormat('MMM').format(data.date!).toString().substring(0,3),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold
                                        ),),


                                    ],
                                  ),
                                  Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text(
                                          DateFormat.jm().format(data.date!),
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold
                                          ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                data.location.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                data.battery.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FollowUpModel {
  String? location;
  DateTime? date;
  String? battery;
  FollowUpModel(this.location, this.date, this.battery);
}
