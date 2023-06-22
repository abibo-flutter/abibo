import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*

memo-제목: '내용'

*/
void savePassword({
  required String title,
  required String memo,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('memo-$title', memo);
}

Future<String?> getPassword({
  required String title,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? memo = prefs.getString('memo-$title');
  if (memo != null) {
    return memo;
  }
  return null;
}
