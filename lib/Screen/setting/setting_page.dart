import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salebee/Screen/A_MenuPage/the_eye/live_tracking/map_screen.dart';
import 'package:salebee/Screen/test/test.dart';
import 'package:url_launcher/url_launcher.dart';

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
  double screenHeight = 0;
  String versionID = "";
  String buildNumber = "";
  getFcmToken() async {
    fcmtoken = await FirebaseMessaging.instance.getToken();
    print("my fcm token is setting $fcmtoken");
    return fcmtoken;
  }
  @override
void initState(){
  super.initState();
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    versionID = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }).then((value) => setState((){

  }));

}
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    print("my screen size is $size");


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
                  onTap: () {
                    _launchInWebViewWithoutJavaScript(Uri.parse("https://docs.google.com/document/d/1E2QNSS-YV4LN1JfcRHhe4GaYQGrkhcDIa2DD6b5jdJQ/edit?usp=sharing" ));
                  },
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Privacy and Policy',
                  subtitle: "Please check our privacy policy page",
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
                    _launchInWebViewWithoutJavaScript(Uri.parse("https://salebee.net/about-us/" ));

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
                  onTap: () async {
                    SharedPreff.to.prefss.remove("token");
                    SharedPreff.to.prefss.remove("loggedIN");
                    SharedPreff.to.prefss.remove("employeeID");
                    SharedPreff.to.prefss.remove("userNAME");
                    SharedPreff.to.prefss.remove("proLink");
                    await FirebaseAuth.instance.signOut();

                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(

                        builder: (BuildContext context) => Splash(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
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

                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(

                        builder: (BuildContext context) => Splash(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
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
                  onTap: () {


               Get.to(StationFood());
                  },
                  icons: CupertinoIcons.map,
                  title: "Wallet",
                  titleStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  onTap: () {


                  },
                  icons: CupertinoIcons.asterisk_circle,
                  title: "Version: $versionID + $buildNumber",
                  titleStyle: TextStyle(
                    color: Colors.black,
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
  launchURL() async {



    final String googleMapslocationUrl = "https://docs.google.com/document/d/1E2QNSS-YV4LN1JfcRHhe4GaYQGrkhcDIa2DD6b5jdJQ/edit?usp=sharing";



    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
