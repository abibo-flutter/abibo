import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
?사실상 무료 서비스
platform-netflix: [
  {'id': 'asdfgh', 'password': 'asdfgh'},
],
platform-spotify: [
  {'id': 'asdfgh', 'password': 'asdfgh'},
  {'id': 'qwerty', 'password': 'qwerty'},
],
*/

void setPlatform({
  required String platform,
  required String id,
  required String password,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String serviceJson = prefs.getString('platform-$platform') ?? '[]';
  List<Map<String, dynamic>> serviceList = jsonDecode(serviceJson);
  serviceList.add({'id': id, 'password': password});
  serviceJson = jsonEncode(serviceList);
  prefs.setString('platform-$platform', serviceJson);
  prefs.setStringList(
    'platforms',
    (prefs.getStringList('platforms') ?? [])..add(platform),
  );
}

Future<List<Map<String, dynamic>>> getPlatform({
  required String platform,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('platform-$platform') ?? '[]';
  List<Map<String, dynamic>> serviceList = jsonDecode(serviceJson);
  return serviceList;
}

Future<List> getAllPlatform() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> allServiceName = prefs.getStringList('platforms') ?? [];
  List serviceList = [];
  for (var name in allServiceName) {
    serviceList.add(jsonDecode(prefs.getString('platform-$name')!)); //사이트별로 그룹화
  }
  return serviceList;
}
