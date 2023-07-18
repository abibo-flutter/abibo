import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

final notifications = FlutterLocalNotificationsPlugin();
late List<String> DateDiffs;
List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

Future<void> initNotification() async {
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

  DateDiffs = jsonDecode(prefs.getString('period') ??
          "['1d', '2d', '3d', '4d', '5d', '6d', '1w', '2w', '3w', '1m', '2m', '3m']")
      .cast<String>();
}

qwerty() {}
Future<void> registerNotification({
  required String type,
  required String name,
  required String detail,
  required String endDate,
  required String dateDiff,
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
  int diff = int.parse(dateDiff.substring(0, dateDiff.length - 1));

  if (dateDiff.endsWith('d')) {
    date.subtract(Duration(days: diff));
  } else if (dateDiff.endsWith('w')) {
    date.subtract(Duration(days: diff * 7));
  } else if (dateDiff.endsWith('m')) {
    date.subtract(Duration(days: diff * months[date.month - 2]));
  }

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

Future<void> cancelNotification({
  required String type,
  required String name,
  required String detail,
}) async {
  for (String dateDiff in DateDiffs) {
    int notificationId = '$type $name $detail $dateDiff'.hashCode;
    notifications.cancel(notificationId);
  }
}
