import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/* 
[
  'netflix::  {id:qwerty password:qwerty startDate:20230620}  {id:asdfgh password:asdfgh}'
  'spotify::  {id:qwerty password:qwerty}'
]
*/
void savePassword({
  required String platform,
  required String id,
  required String password,
  String? startDate,
  String? endDate,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> serviceList = prefs.getStringList('services') ?? [];
  String newInfo = '  {id:$id password:$password';
  if (startDate != null) {
    newInfo += ' startDate:$startDate';
  }
  if (endDate != null) {
    newInfo += ' endDate:$endDate';
  }
  newInfo += '}';
  for (int i = 0; i < serviceList.length; i++) {
    if (serviceList[i].substring(0, platform.length) == platform) {
      if (serviceList[i].contains(newInfo) == false) {
        serviceList[i] += newInfo;
      }
      prefs.setStringList('services', serviceList);
      return;
    }
  }
  prefs.setStringList(
    'services',
    [
      '$platform::$newInfo',
    ],
  );
}

/*
[
  {
    id:'qwerty',
    password:'qwerty',
  },
  {
    id:'asdfgh',
    password:'asdfgh',
  },
]
*/
Future<List<Map<String, String>>?> getPassword({
  String platform = '',
  String? startDate = '',
  String? endDate = '',
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> serviceList = prefs.getStringList('services') ?? [];
  List<String>? result;
  for (int i = 0; i < serviceList.length; i++) {
    if (serviceList[i].substring(0, platform.length) == platform) {
      //원하는 플랫폼일 경우
      result =
          serviceList[i].split('  ').sublist(1); //{...} 단위로 분류한 후 platform 제거
      return strToMapList(result);
    }
  }
  return null;
}

List<Map<String, String>> strToMapList(List<String> str) {
  Map<String, String> map = {};
  List<Map<String, String>> result = [];
  for (var block in str) {
    //{...} 한개씩 추출
    block = block.substring(1, block.length - 1); //중괄호 제거
    for (dynamic property in block.split(' ')) {
      //'':'' 한개씩 추출
      property = property.split(':');
      map[property[0]] = property[1]; //map에 '':'' 추가
    }
    result.add(map); //결과에 map 추가
  }
  return result; //[{'':'', '':'',}, {'':'',},] 형태로 반환
}
