import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
?사실상 구독 서비스
subscription-netflix: [
  {'id': 'qwerty', 'password': 'qwerty', 'payDate': 20230621, 'endDate': 20240621, 'cost': 10000},
],
subscription-spotify: [
  {'id': 'qwerty', 'password': 'qwerty', 'payDate': 20230621, 'endDate': 20240621, 'cost': 10000},
  {'id': 'asdfgh', 'password': 'asdfgh', 'payDate': 20220621, 'endDate': 20230621, 'cost': 7000},
],
*/

void setSubscription({
  required String serviceName,
  required String id,
  required String password,
  required int payDate,
  required int endDate,
  required int cost,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson =
      prefs.getString('subscription-$serviceName') ?? '[]';

  List serviceList = jsonDecode(serviceJson);

  Map newInfo = {
    'id': id,
    'password': password,
    'payDate': payDate,
    'endDate': endDate,
    'cost': cost,
  };

  serviceList.add(newInfo);

  prefs.setString('subscription-$serviceName', jsonEncode(serviceList));
  prefs.setStringList(
    'subscriptions',
    (prefs.getStringList('subscriptions') ?? [])..add(serviceName),
  );
}

Future<List<Map<String, dynamic>>> getSubscription({
  required serviceName,
  payDateMin = 0,
  payDateMax = 10e8,
  endDateMin = 0,
  endDateMax = 10e8,
  costMin = 0,
  costMax = 10e8,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson =
      prefs.getString('subscription-$serviceName') ?? '[]';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> serviceList = [];
  //[{'...':object}, {'...':object, '...':object}]
  serviceList = jsonDecode(serviceJson);

  for (var service in serviceList) {
    if ((payDateMin < service['payDate'] && service['payDate'] < payDateMax) &&
        (endDateMin < service['endDate'] && service['endDate'] < endDateMax) &&
        (costMin < service['cost'] && service['cost'] < costMax)) {
      result.add(service);
    }
  }
  return result;
}

Future<List> getAllSubscription({sorted = true}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> allServiceName = prefs.getStringList('subscriptions') ?? [];
  List serviceList = [];
  for (var name in allServiceName) {
    if (sorted) {
      serviceList
          .addAll(jsonDecode(prefs.getString('subscription-$name')!)); //시간순 정렬
      //serviceList = [{...}, {...}, {...}]
    } else {
      serviceList
          .add(jsonDecode(prefs.getString('subscription-$name')!)); //사이트별로 그룹화
      // serviceList = [
      //   [{...}, {...}],
      //   [{...}, {...}, {...}],
      //   [{...}],
      // ]
    }
  }
  if (sorted) {
    serviceList.sort((a, b) => a.endDate.compareTo(b.endDate));
    // 일단 버블 정렬이고 필요하면 바꿀 수 있음
  }
  return serviceList;
}
