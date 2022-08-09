import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/notification/notification_1.dart';
import 'package:salebee/drawer.dart';
import 'package:salebee/utils.dart';
import 'package:get/get.dart';
import 'Screen/Home/home.dart';
import 'Screen/notification/notification.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

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
            drawer(context);
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
                      currentScreen = const NotificationPage1();
                      currentTab = 1;
                    });
                  },
                  child: Center(
                    child: Icon(Icons.notifications,color: currentTab == 1 ? primaryColor : Colors.grey,
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
