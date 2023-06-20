import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
//* netflix:: userid1:password1 (2024-02-27)userid2:password2

void savePassword({
  required String platform,
  required String id,
  required String password,
  String? date,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> serviceList = prefs.getStringList('services') ?? [];
  String newInfo;
  if (date == null) {
    newInfo = '$id:$password ';
  } else {
    newInfo = '($date)$id:$password ';
  }
  for (int i = 0; i < serviceList.length; i++) {
    if (serviceList[i].contains('$platform:: ')) {
      serviceList[i] += newInfo;
      prefs.setStringList('services', serviceList);
      return;
    }
  }
  prefs.setStringList(
    'services',
    [
      '$platform:: $id:$password ',
    ],
  );
}
