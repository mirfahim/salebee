


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LocalNotification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () async {
              var scheduledNotificationDateTime =
              DateTime.now().add(Duration(seconds: 5));
              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  importance: Importance.high, priority: Priority.high, ticker: 'ticker');
              var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
              var platformChannelSpecifics = NotificationDetails(
                  android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

              // Step 5: Show the notification
              await FlutterLocalNotificationsPlugin().schedule(
                  0,
                  'plain title',
                  'plain body',
                  scheduledNotificationDateTime,
                  platformChannelSpecifics);
            },
            child: Container(

              child: Text('Show notification'),
            ),
          ),
        ),
      ),
    );
  }
}