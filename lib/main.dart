import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:salebee/Screen/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salebee/Utils/ROute/app_pages.dart';
import 'package:salebee/utils.dart';
import 'Provider/Login/provider_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'Screen/Authentication/login_page.dart';
import 'Screen/schedule/schedule_home.dart';
import 'Screen/task/notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

// initialize hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // open a box
  await Hive.openBox("manageTask");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await SharedPreff.to.initial();
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  await LocalNotificationService().initialize();

  runApp(
      MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderManager()),
      ],
      child: GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: primaryColorLight,
            bottomAppBarTheme: BottomAppBarTheme(
              color: primaryColorLight
            ),
            bottomAppBarColor: primaryColorLight,

            appBarTheme: AppBarTheme(
                backgroundColor: primaryColorLight,
                titleTextStyle: TextStyle(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black)),
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.black),
              headline2: TextStyle(color: Colors.black),
              bodyText2: TextStyle(color: Colors.black),
              subtitle1: TextStyle(color: Colors.black),

              //primarySwatch: Colors.blue,
            )),
        home: Splash(),
      ),
    );
  }
}
