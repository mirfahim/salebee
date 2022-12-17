import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/Map/map_screen.dart';

import '../../../../utils.dart';

class AllVisitTrackPage extends StatefulWidget {
 String? employeeName;
 AllVisitTrackPage(this.employeeName);

  @override
  State<AllVisitTrackPage> createState() => _AllVisitTrackPageState();
}

class _AllVisitTrackPageState extends State<AllVisitTrackPage> {
  List<TrackModel> trackingList = [
    TrackModel("Mirpur,DOHS, road 7", DateTime.now(), "33%"),
    TrackModel("Dhanmondi,kolabon, road 27", DateTime.now(), "34%"),
    TrackModel("Banani,K block, road 5", DateTime.now(), "65%"),
    TrackModel("Gulshan,DOHS, road 7", DateTime.now(), "53%"),
    TrackModel("Rampura,DOHS, road 7", DateTime.now(), "24%"),
    TrackModel("Banasree,DOHS, road 7", DateTime.now(), "76%"),
    TrackModel("AftabNagar,DOHS, road 7", DateTime.now(), "89%"),
    TrackModel("Malibag,DOHS, road 7", DateTime.now(), "34%"),
    TrackModel("Badda,DOHS, road 7", DateTime.now(), "78%"),
    TrackModel("Hatirjheel,lake road, road 7", DateTime.now(), "29%"),
    TrackModel("Shahbag,4rastar mor, road 7", DateTime.now(), "93%"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.employeeName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              child: MapScreen(),
            ),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height -400,
              child: ListView.separated(
                itemCount: trackingList.length,
                itemBuilder: (BuildContext context, index) {
                  var data = trackingList[index];
                  return Container(

                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 20,
                              width: 5,
                              color: Colors.lightBlue,
                            ),
                            CircleAvatar(
                              radius: 5,

                            ),
                            Container(
                              height: 20,
                              width: 5,
                              color: Colors.lightBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
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

class TrackModel {
  String? location;
  DateTime? date;
  String? battery;
  TrackModel(this.location, this.date, this.battery);
}
