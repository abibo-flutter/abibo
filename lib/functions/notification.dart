import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

final notifications = FlutterLocalNotificationsPlugin();
late List<int> DateDiffs;

initNotification() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

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

  DateDiffs =
      jsonDecode(prefs.getString('period') ?? '[1, 7, 14, 30]').cast<int>();
}

registerNotification({
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

  DateTime date = DateTime.now();
  // DateTime date = DateTime.parse(endDate.replaceAll('/', '-'));
  date = date.add(Duration(minutes: dateDiff));
  // date.subtract(Duration(days: dateDiff));
  int notificationId = '$type $name $detail $dateDiff'.hashCode;

  tz.initializeTimeZones();

  notifications.zonedSchedule(
    notificationId,
    name,
    '$detail  $dateDiff일 남았어요!',
    tz.TZDateTime.from(date, tz.local),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

cancelNotification({
  required String type,
  required String name,
  required String detail,
}) async {
  for (int dateDiff in DateDiffs) {
    int notificationId = '$type $name $detail $dateDiff'.hashCode;
    notifications.cancel(notificationId);
  }
}
