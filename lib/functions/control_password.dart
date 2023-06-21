import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
{
  'netflix': [
    {'id': 'asdfgh', 'password': 'asdfgh'},
    {'id': 'qwerty', 'password': 'qwerty', 'Subscribe': 20230621},
  ],
  'spotify': [
    {'id': 'asdfgh', 'password': 'asdfgh'},
    {'id': 'qwerty', 'password': 'qwerty', 'Subscribe': 20230621},
  ],
}
*/
void savePassword({
  required String platform,
  required String id,
  required String password,
  int? payDate,
  int? endDate,
  int? cost,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('services') ?? '';

  Map<String, List<Map<String, dynamic>>> serviceList =
      {}; //{platform: [{'...':object}, {'...':object, '...':object}]}
  serviceList = jsonDecode(serviceJson);

  Map<String, dynamic> newInfo = {
    'id': id,
    'password': password,
  };
  if (payDate != null) {
    newInfo['payDate'] = payDate;
  }
  if (endDate != null) {
    newInfo['endDate'] = endDate;
  }
  if (cost != null) {
    newInfo['cost'] = cost;
  }

  if (serviceList[platform] != null) {
    serviceList[platform]!.add(newInfo);
  } else {
    serviceList[platform] = [newInfo];
  }
  prefs.setString('services', jsonEncode(serviceList));
}

Future<List<Map<String, dynamic>>> getPassword({
  String platform = '',
  int? payDateMin,
  int? payDateMax,
  int? endDateMin,
  int? endDateMax,
  int? costMin,
  int? costMax,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('services') ?? '';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> serviceList = [];
  //[{'...':object}, {'...':object, '...':object}]
  serviceList = jsonDecode(serviceJson)[platform] ?? [];

  for (var service in serviceList) {
    if ((payDateMin ?? 0) > (service['payDate'] ?? 0) ||
        (service['payDate'] ?? 10e8) > (payDateMax ?? 10e8)) {
      continue;
    }
    if ((endDateMin ?? 0) > (service['endDate'] ?? 0) ||
        (service['endDate'] ?? 10e8) > (endDateMax ?? 10e8)) {
      continue;
    }
    if ((costMin ?? 0) > (service['cost'] ?? 0) ||
        (service['cost'] ?? 10e8) > (costMax ?? 10e8)) {
      continue;
    }
    result.add(service);
  }
  return result;
}
