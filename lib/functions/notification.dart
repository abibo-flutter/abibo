import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

final notifications = FlutterLocalNotificationsPlugin();
late List<String> dateDiffs;
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

  dateDiffs = prefs.getStringList('period') ?? ["0d", "1d", "3d", "1w", "1m"];

  PermissionStatus status = await Permission.notification.status;
  if (status.isPermanentlyDenied || status.isGranted) return;
  await Permission.notification.request();
}

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
  String text = '';

  if (diff == 0) {
    text = '$detail  ${(type == 'guarantee') ? '만료' : '해지'}일이에요!';
  } else if (dateDiff.endsWith('d')) {
    date.subtract(Duration(days: diff));
    text = '$detail  $diff일 남았어요!';
  } else if (dateDiff.endsWith('w')) {
    date.subtract(Duration(days: diff * 7));
    text = '$detail  $diff주 남았어요!';
  } else if (dateDiff.endsWith('m')) {
    date.subtract(Duration(days: diff * months[date.month - 2]));
    text = '$detail  $diff개월 남았어요!';
  }

  int notificationId = '$type $name $detail $dateDiff'.hashCode;

  tz.initializeTimeZones();
  try {
    await notifications.zonedSchedule(
      notificationId,
      name,
      text,
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
  dateDiffs = prefs.getStringList('period') ?? [];

  for (String dateDiff in dateDiffs) {
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
  dateDiffs = prefs.getStringList('period') ?? [];
  for (String dateDiff in dateDiffs) {
    await cancelNotification(
      type: type,
      name: name,
      detail: detail,
      dateDiff: dateDiff,
    );
  }
}

Future<void> resetNotification() async {
  try {
    await notifications.cancelAll();
  } catch (e) {
    print(e);
  }
}

Future<void> updatePeriod() async {
  List<List> infos = [];
  for (List list in await getAllSubscription()) {
    infos.add(['subscription', list[0], list[1]]);
  }

  for (List list in await getAllGuarantee()) {
    infos.add(['guarantee', list[0], list[1]]);
  }
  for (var info in infos) {
    await cancelAllNotification(
      type: info[0],
      name: info[1],
      detail: info[2][(info[0] == 'guarantee') ? 'name' : 'id'],
    );
    await registerAllNotification(
      type: info[0],
      name: info[1],
      detail: info[2][(info[0] == 'guarantee') ? 'name' : 'id'],
      endDate: info[2]['endDate'],
    );
  }
}
