import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
?사실상 구독 서비스
serviceName-netflix: [
  {'id': 'qwerty',  'endDate': 20240621, 'moreMemo': stringtextabcdefg},
],

*/

Future<void> setGurantee({
  required String serviceName,
  required String id,
  required int endDate,
  required String moreMemo,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('gurantee-$serviceName') ?? '[]';

  List serviceList = jsonDecode(serviceJson);

  Map newInfo = {
    'id': id,
    'endDate': endDate,
  };

  if (!serviceList.map((e) => e['id']).contains(id)) {
    serviceList.add(newInfo);
  }

  prefs.setString('gurantee-$serviceName', jsonEncode(serviceList));
  prefs.setStringList(
    'gurantees',
    (prefs.getStringList('gurantees') ?? [])..add(serviceName),
  );
}

Future<void> removeGurantee({
  required String serviceName,
  required dynamic obj,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List serviceList = await getGurnatee(serviceName: serviceName);
  serviceList.removeWhere(
    (item) => (obj['id'] == item['id']),
  );
  if (serviceList.isEmpty) {
    List<String> nameList = (await getGurnateeList() ?? []);
    nameList.remove(serviceName);
    await prefs.setStringList(
      'gurantees',
      nameList,
    );
    await prefs.remove('gurantee-$serviceName');
    return;
  }

  String serviceJson = jsonEncode(serviceList);
  await prefs.setString('gurantee-$serviceName', serviceJson);
}

Future<void> updateGurnatee({
  required String serviceName,
  required dynamic obj,
  required dynamic newObj,
}) async {
  await removeGurantee(serviceName: serviceName, obj: obj);
  await setGurantee(
    serviceName: serviceName,
    id: newObj['id'],
    endDate: newObj['endDate'],
    moreMemo: text,
  );
}

Future<List<Map<String, dynamic>>> getGurnatee({
  required serviceName,
  endDateMin = 0,
  endDateMax = 10e8,
  costMin = 0,
  costMax = 10e8,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String serviceJson = prefs.getString('gurantee-$serviceName') ?? '[]';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> serviceList = [];
  //[{'...':object}, {'...':object, '...':object}]
  serviceList = jsonDecode(serviceJson).cast<Map<String, dynamic>>();

  for (var service in serviceList) {
    if ((endDateMin < service['endDate'] && service['endDate'] < endDateMax) &&
        (costMin < service['cost'] && service['cost'] < costMax)) {
      result.add(service);
    }
  }
  return result;
}

Future<List<String>?> getGurnateeList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? gurantees = prefs.getStringList('gurantees');
  return gurantees;
}

Future<List> getAllGurantee({sorted = true}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List allServiceName = prefs.getStringList('gurantees') ?? [];
  List<List> serviceList = [];
  List service = [];
  for (var name in allServiceName) {
    if (sorted) {
      service = await getGurnatee(serviceName: name);
      serviceList.addAll(List.generate(
          service.length, (index) => [name, service[index]])); //시간순 정렬
      //serviceList = [{...}, {...}, {...}]
    } else {
      serviceList.add([name, await getGurnatee(serviceName: name)]); //사이트별로 그룹화
      // serviceList = [
      //   [{...}, {...}],
      //   [{...}, {...}, {...}],
      //   [{...}],
      // ]
    }
  }
  if (sorted) {
    serviceList.sort((a, b) => a[1]['endDate'].compareTo(b[1]['endDate']));
    // 일단 버블 정렬이고 필요하면 바꿀 수 있음
  }
  return serviceList;
}
