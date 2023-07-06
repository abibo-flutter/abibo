import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
memo-제목: '내용',
memo-제목: '내용',
*/

Future<void> setMemo({
  required String title,
  required String memo,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('memo-$title', memo);
  if (!(await getMemoList() ?? []).contains(title)) {
    prefs.setStringList(
      'memos',
      (prefs.getStringList('memos') ?? [])..add(title),
    );
  }
}

Future<void> updateMemo({
  required String title,
  required String memo,
}) async {
  await removeMemo(title: title);
  await setMemo(title: title, memo: memo);
}

Future<void> removeMemo({
  required String title,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> nameList = (await getMemoList() ?? []).cast<String>();
  nameList.remove(title);
  await prefs.setStringList(
    'memos',
    nameList,
  );
  await prefs.remove('memo-$title');
}

Future<String?> getMemo({
  required String title,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? memo = prefs.getString('memo-$title');
  if (memo != null) {
    return memo;
  }
  return null;
}

Future<List?> getMemoList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List? memo = prefs.getStringList('memos');
  return memo;
}

Future<List> getAllMemo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> allServiceName = prefs.getStringList('memos') ?? [];
  List serviceList = [];
  for (var name in allServiceName) {
    serviceList.add([name, await getMemo(title: name)]);
  }
  return serviceList;
}
