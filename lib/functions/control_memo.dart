import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
memo-제목: '내용',
memo-제목: '내용',
*/

void setPassword({
  required String title,
  required String memo,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('memo-$title', memo);
  prefs.setStringList(
    'memos',
    (prefs.getStringList('memos') ?? [])..add(title),
  );
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

Future<List> getAllMemo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> allServiceName = prefs.getStringList('memos') ?? [];
  List serviceList = [];
  for (var name in allServiceName) {
    serviceList.add(jsonDecode(prefs.getString('memo-$name')!));
  }
  return serviceList;
}
