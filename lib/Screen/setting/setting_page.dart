import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:get/get.dart';

import '../../Data/static_data.dart';
import '../../Service/sharedPref_service.dart';
import '../../Utils/StringsConst.dart';
import '../../utils.dart';
import '../SplashScreen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? fcmtoken = "";
  int screenHeight = 0;
  getFcmToken() async {
    fcmtoken = await FirebaseMessaging.instance.getToken();
    print("my fcm token is setting $fcmtoken");
    return fcmtoken;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // user card
            SimpleUserCard(
              userName: StaticData.name != null ? StaticData.name! : "No name",
              userProfilePic: StaticData.proLink!.startsWith(".", 0)
                  ? NetworkImage("${StringsConst.MAINURL}" +
                      "${StaticData.proLink!.replaceAll("../..", "")}")
                  : NetworkImage(StaticData.proLink!),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: "Make Salebee'App yours",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Privacy',
                  subtitle: "Lock Salebee'App to improve your privacy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    print("working ");
                    getFcmToken();
                    print("end ");
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Salebee'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    SharedPreff.to.prefss.remove("token");
                    SharedPreff.to.prefss.remove("loggedIN");
                    SharedPreff.to.prefss.remove("employeeID");
                    SharedPreff.to.prefss.remove("userNAME");
                    SharedPreff.to.prefss.remove("proLink");

                    Get.to(Splash());
                    //SharedPreff.to.prefss.remove("key");
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {
                    SharedPreff.to.prefss.remove("token");
                    SharedPreff.to.prefss.remove("loggedIN");
                    SharedPreff.to.prefss.remove("employeeID");
                    SharedPreff.to.prefss.remove("userNAME");
                    SharedPreff.to.prefss.remove("proLink");
                    SharedPreff.to.prefss.remove("subDomain");
                    //StaticData.subDomain = "";
                    StringsConst.BASEURL = "";

                    Get.to(Splash());
                  },
                  icons: CupertinoIcons.repeat,
                  title: "Change Sub-Domain",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      SettingsItem(
        onTap: () {},
        icons: CupertinoIcons.resize_v,
        title: "Screen Size: ${screenHeight.toString()}",
        titleStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}