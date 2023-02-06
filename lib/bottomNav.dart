import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Charts/funnel_chart.dart';
import 'package:salebee/Screen/notification/notification_1.dart';
import 'package:salebee/Screen/setting/setting_page.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/drawer.dart';
import 'package:salebee/utils.dart';
import 'package:get/get.dart';
import 'Screen/Home/home.dart';
import 'Screen/MenuPage/manus_page.dart';
import 'Screen/notification/notification.dart';


class BottomNav extends StatefulWidget {
bool menuPage = true;
BottomNav({required this.menuPage});


  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  int currentTab = 0;
  final storage = const FlutterSecureStorage();
  static  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const NotificationPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: primaryColorLight,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.menu, color: darkBlue,),
          onPressed: () {
            Get.to(() =>  MenusScreen());

            //drawer(context);
          },
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: Container(

          height: 60,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = HomePage();
                      currentTab = 0;
                    });
                  },
                  child: Center(
                    child: Icon(Icons.home,color: currentTab == 0 ? primaryColor : Colors.grey,
                    size: 30,),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = SettingPage();
                      currentTab = 1;
                    });
                  },
                  child: Center(
                    child: Icon(Icons.settings,color: currentTab == 1 ? primaryColor : Colors.grey,
                    size: 30,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: _pageStorageBucket,
      ),
    );
  }
}
