import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
{
  'netflix': [
    {'id': 'asdfgh', 'password': 'asdfgh'},
    {'id': 'qwerty', 'password': 'qwerty', 'deadline': 20230621},
  ],
  'spotify': [
    {'id': 'asdfgh', 'password': 'asdfgh'},
    {'id': 'qwerty', 'password': 'qwerty', 'deadline': 20230621},
  ],
}
*/
void savePassword({
  required String platform,
  required String id,
  required String password,
  int? deadline,
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
  if (deadline != null) {
    newInfo['deadline'] = deadline;
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
  int? startRange,
  int? endRange,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('services') ?? '';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> serviceList = [];
  //[{'...':object}, {'...':object, '...':object}]
  serviceList = jsonDecode(serviceJson)[platform] ?? [];

  for (var service in serviceList) {
    if ((startRange ?? 0) <= (service['deadline'] ?? 0) &&
        (service['deadline'] ?? 10e8) <= (endRange ?? 10e8)) {
      result.add(service);
    }
  }
  return result;
}
