import 'dart:convert';
import 'package:abibo/functions/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
subscription-netflix: [
  {'id': 'qwerty', 'password': 'qwerty', 'endDate': 2024/06/21, 'cost': 10000},
],
subscription-spotify: [
  {'id': 'qwerty', 'password': 'qwerty', 'endDate': 2024/06/21, 'cost': 10000},
  {'id': 'asdfgh', 'password': 'asdfgh', 'endDate': 2023/06/21, 'cost': 7000},
],
*/

Future<void> setSubscription({
  required String serviceName,
  required String id,
  required String password,
  required String endDate,
  required int cost,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson =
      prefs.getString('subscription-$serviceName') ?? '[]';

  List serviceList = jsonDecode(serviceJson);

  Map newInfo = {
    'id': id,
    'password': password,
    'endDate': endDate,
    'cost': cost,
  };

  if (!serviceList.map((e) => e['id']).contains(id)) {
    serviceList.add(newInfo);
  }

  List DateDiffs =
      prefs.getStringList('periods') ?? ['0d', '1d', '3d', '7d', '1m'];

  for (String date in DateDiffs) {
    await registerNotification(
      type: "subscription",
      name: serviceName,
      detail: id,
      endDate: endDate,
      dateDiff: date,
    );
  }

  await prefs.setString('subscription-$serviceName', jsonEncode(serviceList));

  if (!(await getSubscriptionList() ?? []).contains(serviceName)) {
    prefs.setStringList(
      'subscriptions',
      (prefs.getStringList('subscriptions') ?? [])..add(serviceName),
    );
  }
}

Future<void> removeSubscription({
  required String serviceName,
  required dynamic obj,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List serviceList = await getSubscription(serviceName: serviceName);
  serviceList.removeWhere(
    (item) => (obj['id'] == item['id']),
  );

  cancelAllNotification(
    type: "subscription",
    name: serviceName,
    detail: obj["id"],
  );

  if (serviceList.isEmpty) {
    List<String> nameList = (await getSubscriptionList() ?? []);
    nameList.remove(serviceName);
    await prefs.setStringList(
      'subscriptions',
      nameList,
    );
    await prefs.remove('subscription-$serviceName');
    return;
  }

  String serviceJson = jsonEncode(serviceList);
  await prefs.setString('subscription-$serviceName', serviceJson);
}

Future<void> updateSubscription({
  required String serviceName,
  required dynamic obj,
  required dynamic newObj,
}) async {
  await removeSubscription(serviceName: serviceName, obj: obj);
  await setSubscription(
    serviceName: serviceName,
    id: newObj['id'],
    password: newObj['password'],
    endDate: newObj['endDate'],
    cost: newObj['cost'],
  );
}

Future<List<Map<String, dynamic>>> getSubscription({
  required serviceName,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson =
      prefs.getString('subscription-$serviceName') ?? '[]';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> serviceList = [];
  //[{'...':object}, {'...':object, '...':object}]
  serviceList = jsonDecode(serviceJson).cast<Map<String, dynamic>>();

  for (var service in serviceList) {
    result.add(service);
  }
  return result;
}

Future<List<String>?> getSubscriptionList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? subscriptions = prefs.getStringList('subscriptions');
  return subscriptions;
}

Future<List<List>> getAllSubscription() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List allServiceName = prefs.getStringList('subscriptions') ?? [];
  List<List> serviceList = [];
  List service = [];
  for (var name in allServiceName) {
    service = await getSubscription(serviceName: name);
    serviceList.addAll(List.generate(
        service.length, (index) => [name, service[index]])); //시간순 정렬
    /*
    serviceList = [
      [name, {...}], 
      [name, {...}], 
      [name, {...}], 
      ]
    */
  }
  serviceList.sort((a, b) => a[1]['endDate'].compareTo(b[1]['endDate']));
  // 일단 버블 정렬이고 필요하면 바꿀 수 있음
  return serviceList;
}
