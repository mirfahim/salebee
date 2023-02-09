import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Utils/my_colors.dart';

class RouteDetails extends StatefulWidget {

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<RouteDetails> {

  void intState() {
    // Future.delayed(Duration(seconds:10),(){
    //   // _addMarker(LatLng);
    // });

    super.initState();
  }





  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      // bottomNavigationBar: MyTabHomePage(),
      key: _scaffoldKey,
      backgroundColor: MyColors.appColor,
      //  drawer: CustomDrawer(),
      body: Column(
          children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "widget.routeName",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                           "No Date",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      //Text("Mar 21, 2021"),
                      Divider(
                        thickness: 1,
                      ),

                      Row(
                        children: [
                          Container(
                            height: 150,
                            width: 135,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AppLanguage.Route_Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "AppLanguage.Start_Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "AppLanguage.End_Address:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "AppLanguage.Start_Time_Date:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "AppLanguage.End_Time_Date:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "AppLanguage.Car_Number_Plate:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 155,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 " widget.name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),
                                Text(
                                  "widget.startStreet" + " "+ "widget.startCity",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),


                                Text(
                                  "widget.endStreet" + " "+ "widget.endCity",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),
                                Text(
                                   "no data",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),
                                Text(
                                  "no data",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),
                                Text(
                                   "no data",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_60),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 70,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "",
                                ),
                                Text(
                                  "",
                                ),
                                Text(
                                  "",
                                ),
                                Text(
                                  "",
                                ),
                                Text(
                                  "",
                                ),
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.grey_10,
                                      width:
                                      1, //                   <--- border width here
                                    ),
                                    color: MyColors.greenPaste,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child:
                                  Center(child: Text("widget.workStatus")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )),
                  // height: MediaQuery.of(context).size.height *0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 10,
                        itemBuilder: (context, index) {

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: MyColors.grey_10,
                                width:
                                1, //                   <--- border width here
                              ),
                              color: MyColors.appColor,
                            ),
                            child: Column(
                              children: [
                                //1stStart
                                ListTile(
                                  leading:Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        color: MyColors.deepBlue,
                                        border: Border.all(
                                          color: Colors.green,
                                          width:
                                          1, //                   <--- border width here
                                        ),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: MyColors.deepBlue,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/delivery-01.png"),
                                            )),
                                      ),
                                    ),
                                  ),

                                  title:
                                  Text(
                                    "No Data",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                              Text("Delivery"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                          color: MyColors.appColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {

                                                    },
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration:
                                                      BoxDecoration(
                                                        image: DecorationImage(
                                                            image: ExactAssetImage(
                                                                'assets/map.png'),
                                                            fit: BoxFit.fill),
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(
                                                              15),
                                                          topRight:
                                                          Radius.circular(
                                                              15),
                                                          bottomLeft:
                                                          Radius.circular(
                                                              15),
                                                          bottomRight:
                                                          Radius.circular(
                                                              15),
                                                        ),
                                                        border: Border.all(
                                                          color: Colors
                                                              .grey,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 100,
                                                width: 150,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "widget.listStop[index].houseNumber" +
                                                                "widget.listStop[index].street",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: MyColors
                                                                    .grey_60),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .calendar_today,
                                                          size: 19,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "myDate",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: MyColors
                                                                  .grey_60),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .pedal_bike_rounded,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "widget.listStop[index].visitingTime",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: MyColors
                                                                  .grey_60),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.phone,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "0541 571 450",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: MyColors
                                                                  .grey_60),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //1stEnd
                              ],
                            ),
                          );
                        }),
                  )),
            ],
          ),
        ),



      ]),
    );
  }


}
