import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/SplashScreen.dart';
import 'package:salebee/Service/sharedPref_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            SharedPreff.to.prefss.remove("token");
            SharedPreff.to.prefss.remove("loggedIN");
            SharedPreff.to.prefss.remove("employeeID");
            SharedPreff.to.prefss.remove("userNAME");
            SharedPreff.to.prefss.remove("proLink");

            Get.to( Splash());
            //SharedPreff.to.prefss.remove("key");
          },

            child: Text("Log Out")),
      ),
    );
  }
}
