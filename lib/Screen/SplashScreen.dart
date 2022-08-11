// not just splash , will ask use for their name here
// Import package
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salebee/Screen/Authentication/login_page.dart';
import 'package:salebee/Screen/Authentication/sub_domain_page.dart';
import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Widget/bottom_bar.dart';
import 'package:salebee/bottomNav.dart';
//import 'package:location/location.dart';
import '../Data/static_data.dart';
import '../Service/sharedPref_service.dart';
import '../Utils/my_colors.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //late LocationData locationData;
  //
  //DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    StaticData.subDomain = SharedPreff.to.prefss.getString("subDomain");
    StaticData.loggedIN = SharedPreff.to.prefss.getBool("loggedIN");
    StaticData.name = SharedPreff.to.prefss.getString("userNAME") ?? "";
    StaticData.proLink = SharedPreff.to.prefss.getString("proLink") ;
    StaticData.proLink = SharedPreff.to.prefss.getString("token") ;
    StaticData.employeeID = SharedPreff.to.prefss.getInt("employeeID") ?? 0;

    Timer(Duration(seconds: 4), () {
      domainCheck();
     // local();
      print(" my subdomain is ${SharedPreff.to.prefss.getString("subDomain")}");
    });

  }
  // local() async {
  //   //Location location = new Location();
  //
  // //  locationData = await location.getLocation();
  //   print("MY LOCATION from splash__________$locationData");
  //   print(locationData.latitude);
  //   print(locationData.longitude);
  //   StaticData.myLocationLat = locationData.latitude;
  //   StaticData.myLocationLon = locationData.longitude;
  //   print("MY----user----location-----${StaticData.myLocationLat}");
  //   return locationData;
  //
  // }
  domainCheck()  {
    if(StaticData.loggedIN == true){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
    } else if (StaticData.subDomain == '' || StaticData.subDomain == null ){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SubDomainPage(),
        ),
      );

  } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }


  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: MyColors.appColor,
      //
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.appColor,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Image.asset(
            "images/tap.png",
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
