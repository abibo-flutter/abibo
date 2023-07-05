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
  List<Map<String, dynamic>> serviceList =
      jsonDecode(serviceJson).cast<Map<String, dynamic>>();
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
  List<Map<String, dynamic>> serviceList =
      jsonDecode(serviceJson).cast<Map<String, dynamic>>();
  return serviceList;
}

Future<List<String>?> getPlatformList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? platforms = prefs.getStringList('platforms');
  return platforms;
}

Future<List> getAllPlatform() async {
  List<String> allServiceName = await getPlatformList() ?? [];
  List serviceList = [];
  for (var name in allServiceName) {
    serviceList.add(getPlatform(platform: name)); //사이트별로 그룹화
  }
  return serviceList;
}
