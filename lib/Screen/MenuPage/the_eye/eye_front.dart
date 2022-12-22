import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Screen/MenuPage/the_eye/live_tracking/live_tracking_location_by_emp.dart';
import 'package:salebee/Screen/MenuPage/the_eye/follow_up_activity.dart';
import 'package:salebee/Screen/MenuPage/the_eye/map_for_all/map_view.dart';
import 'package:salebee/Screen/MenuPage/the_eye/markrting_activity.dart';
import 'package:salebee/Screen/MenuPage/the_eye/visit/person_visit_log_tab.dart';
import 'package:salebee/Screen/MenuPage/the_eye/live_tracking/live_tracking_screen.dart';
import 'package:salebee/Screen/Prospect/individual_prospect.dart';
import 'package:salebee/Screen/Prospect/organization_prospect.dart';
import 'package:salebee/utils.dart';
import 'package:salebee/Screen/leave/granted.dart';
import 'package:salebee/Screen/leave/applied.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salebee/utils.dart';

class TheEyeFront extends StatefulWidget {
  const TheEyeFront({Key? key}) : super(key: key);

  @override
  State<TheEyeFront> createState() => _TheEyeFrontState();
}

class _TheEyeFrontState extends State<TheEyeFront> {
  Iterable markers = [];

  Future<Uint8List> getBytesFromAsset({String? path,int? width})async {
    ByteData data = await rootBundle.load(path!);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))!
        .buffer.asUint8List();
  }
  getImage() async {
    StaticData.customMarker = await getBytesFromAsset(
        path:'images/marker.png', //paste the custom image path
        width: 50 // size of custom image as marker
    );
    return StaticData.customMarker;

  }

  @override
  Widget build(BuildContext context) {
    getImage();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(


          title:  Text('The Eye',style: TextStyle(
              color: appBarHeader,fontSize: 24
          ),),
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: primaryColorLight,
          elevation: 0,
          centerTitle: true,

        ),
        body: Container(
          color: primaryColorLight,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child: TabBar(
                          indicatorColor: darkBlue,
                          labelColor: darkBlue,
                          unselectedLabelColor: tabBarUnSelectedColor,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 12
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600
                          ),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: 'Live tracking',
                            ),
                            Tab(
                              text: 'Visit',
                            ),
                            Tab(
                              text: 'Map view',
                            ),
                            Tab(
                              text: 'Follow Up Activity',
                            ),
                            Tab(
                              text: 'Marketing Activity',
                            ),

                          ],
                        ),
                      ),
                      Expanded(child: Container(

                      ))
                    ],
                  ),
                ),
                 Expanded(
                  child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: LiveTrackingScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: VisitLog(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: EyeMapScreeen(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FollowUpActivity(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: MarketingActivity(),
                        ),
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
