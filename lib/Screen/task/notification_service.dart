import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
    // #1
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // #2
    final initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _localNotificationsPlugin
        .initialize(initSettings,)
        .then((_) {
      print('setupPlugin: setup success');
    }).catchError((Object error) {
      print('Error: $error');
    });
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails();
    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }
// plain notification ;
  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _notificationDetails();
    await _localNotificationsPlugin.show(id, title, body, details);
  }
// end
  
  
  // schedule notification 
  Future<void> showScheduleNotification(
      {required int id, required String title, required String body, required DateTime sec}) async {
    final details = await _notificationDetails();
    await _localNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(sec, tz.local),
    details,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
void onDidREcieveLocalNotification(int? id,){

}
  void onSelectNotification(String? payload) {
   // print("payload $payload");
  }
}
