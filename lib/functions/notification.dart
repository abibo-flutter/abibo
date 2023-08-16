import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

final notifications = FlutterLocalNotificationsPlugin();
late List<String> _DateDiffs;
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

  _DateDiffs = prefs.getStringList('period') ?? ["0d", "1d", "3d", "1w", "1m"];
}

Future<void> registerNotification({
  required String type,
  required String name,
  required String detail,
  required String endDate,
  required String dateDiff,
  String noticeTime = '00:00',
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

  DateTime date =
      DateTime.parse("${endDate.replaceAll('/', '-')} $noticeTime:00");
  int diff = int.parse(dateDiff.substring(0, dateDiff.length - 1));

  if (dateDiff.endsWith('d')) {
    date.subtract(Duration(days: diff));
  } else if (dateDiff.endsWith('w')) {
    date.subtract(Duration(days: diff * 7));
  } else if (dateDiff.endsWith('m')) {
    date.subtract(Duration(days: diff * months[date.month - 2]));
  }

  int notificationId = '$type $name $detail $dateDiff $noticeTime'.hashCode;

  tz.initializeTimeZones();
  try {
    await notifications.zonedSchedule(
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
  } catch (e) {
    print(e);
  }
}

Future<void> registerAllNotification({
  required String type,
  required String name,
  required String detail,
  required String endDate,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _DateDiffs = prefs.getStringList('period') ?? ["0d", "1d", "3d", "1w", "1m"];

  for (String dateDiff in _DateDiffs) {
    await registerNotification(
      type: type,
      name: name,
      detail: detail,
      endDate: endDate,
      dateDiff: dateDiff,
    );
  }
}

Future<void> cancelNotification({
  required String type,
  required String name,
  required String detail,
  required String dateDiff,
}) async {
  try {
    int notificationId = '$type $name $detail $dateDiff'.hashCode;
    await notifications.cancel(notificationId);
  } catch (e) {
    print(e);
  }
}

Future<void> cancelAllNotification({
  required String type,
  required String name,
  required String detail,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _DateDiffs = prefs.getStringList('period') ?? ["0d", "1d", "3d", "1w", "1m"];
  for (String dateDiff in _DateDiffs) {
    await cancelNotification(
      type: type,
      name: name,
      detail: detail,
      dateDiff: dateDiff,
    );
  }
}

Future<void> resetNotification() async {
  notifications.cancelAll();
}
