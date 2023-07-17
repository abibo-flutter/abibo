import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

final notifications = FlutterLocalNotificationsPlugin();

initNotification() async {
  AndroidInitializationSettings androidSetting =
      const AndroidInitializationSettings('notification_icon');

  DarwinInitializationSettings iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );
  await notifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload) {},
  );
}

showNotification({
  required String type,
  required String name,
  required String detail,
  required String endDate,
  required int dateDiff,
}) async {
  var androidDetails = const AndroidNotificationDetails(
    'ID',
    'NAME',
    priority: Priority.high,
    importance: Importance.max,
    color: Color(0xFF7000FF),
  );

  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  DateTime date = DateTime.parse(endDate.replaceAll('/', '-'));
  date.subtract(Duration(minutes: dateDiff));
  // date.subtract(Duration(days: dateDiff));
  int notificationId = '$type $name $detail'.hashCode;

  tz.initializeTimeZones();

  notifications.zonedSchedule(
    notificationId,
    name,
    '$detail  $dateDiff일 남았어요!',
    tz.TZDateTime.from(date, tz.local),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

cancelNotification({
  required String type,
  required String name,
  required String detail,
}) async {
  int notificationId = '$type $name $detail'.hashCode;
  notifications.cancel(notificationId);
}
