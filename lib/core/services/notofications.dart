import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("test");

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    try {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      print('error initializing notofication');
      print(e);
    }
  }

  Future instantNotification() async {
    var android = const AndroidNotificationDetails(
      "id",
      "channel",
      largeIcon: DrawableResourceAndroidBitmap('test'),
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('test'),
      ),
    );

    var platform = NotificationDetails(android: android);
    try {
      await _flutterLocalNotificationsPlugin.show(
          0,
          "New Exam is uploaded. check it out",
          "tap to check out the new exam",
          platform,
          payload: "Welcome to demo app");
    } catch (e) {
      print('error showing instant notofication');
      print(e);
    }
  }
}
