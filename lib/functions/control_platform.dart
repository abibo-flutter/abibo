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

Future<void> setPlatform({
  required String platform,
  required String id,
  required String password,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String serviceJson = prefs.getString('platform-$platform') ?? '[]';
  List serviceList = jsonDecode(serviceJson);

  Map newInfo = {
    'id': id,
    'password': password,
  };

  if (!serviceList.map((e) => e["id"]).contains(id)) {
    serviceList.add(newInfo);
  }

  serviceJson = jsonEncode(serviceList);
  await prefs.setString('platform-$platform', serviceJson);

  if (!(await getPlatformList() ?? []).contains(platform)) {
    await prefs.setStringList(
      'platforms',
      (await getPlatformList() ?? [])..add(platform),
    );
  }
}

Future<void> updatePlatform({
  required String platform,
  required Map obj,
  required Map newObj,
}) async {
  await removePlatform(platform: platform, obj: obj);
  await setPlatform(
    platform: platform,
    id: newObj['id'],
    password: newObj['password'],
  );
}

Future<void> removePlatform({
  required String platform,
  required dynamic obj,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List platformList = await getPlatform(platform: platform);
  platformList.removeWhere(
    (item) => (obj['id'] == item['id']),
  );
  if (platformList.isEmpty) {
    List<String> nameList = (await getPlatformList() ?? []);
    nameList.remove(platform);
    await prefs.setStringList(
      'platforms',
      nameList,
    );
    await prefs.remove('platform-$platform');
    return;
  }

  String serviceJson = jsonEncode(platformList);
  await prefs.setString('platform-$platform', serviceJson);
}

Future<List> getPlatform({
  required String platform,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('platform-$platform') ?? '[]';
  List serviceList = jsonDecode(serviceJson);
  return serviceList;
}

Future<List<String>?> getPlatformList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? platforms = prefs.getStringList('platforms');
  return platforms;
}

Future<List<List>> getAllPlatform() async {
  List allServiceName = await getPlatformList() ?? [];
  List<List> serviceList = [];
  List platform;
  for (var name in allServiceName) {
    platform = await getPlatform(platform: name);
    serviceList.addAll(
        List.generate(platform.length, (index) => [name, platform[index]]));
  }
  return serviceList;
}
