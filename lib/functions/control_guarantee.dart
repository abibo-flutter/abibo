import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 데이터 형식
/*
guarantee-apple: [
  {'name': 'qwerty',  'endDate': 20240621, 'note': stringtextabcdefg},
],

*/

Future<void> setGuarantee({
  required String brand,
  required String productName,
  required int endDate,
  required String note,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String productJson = prefs.getString('guarantee-$brand') ?? '[]';

  List productList = jsonDecode(productJson);

  Map newInfo = {
    'name': productName,
    'endDate': endDate,
    'note': note,
  };

  productList.add(newInfo);

  prefs.setString('guarantee-$brand', jsonEncode(productList));

  if (!(await getGuaranteeList() ?? []).contains(brand)) {
    prefs.setStringList(
      'guarantees',
      (prefs.getStringList('guarantees') ?? [])..add(brand),
    );
  }
}

Future<void> removeGuarantee({
  required String brand,
  required dynamic obj,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List productList = await getGuarantee(brand: brand);
  productList.removeWhere(
    (item) =>
        (obj['name'] == item['name'] && obj['endDate'] == item['endDate']),
  );
  if (productList.isEmpty) {
    List<String> brandList = (await getGuaranteeList() ?? []);
    brandList.remove(brand);
    await prefs.setStringList(
      'guarantees',
      brandList,
    );
    await prefs.remove('guarantee-$brand');
    return;
  }

  String productJson = jsonEncode(productList);
  await prefs.setString('guarantee-$brand', productJson);
}

Future<void> updateGuarantee({
  required String brand,
  required dynamic obj,
  required dynamic newObj,
}) async {
  await removeGuarantee(brand: brand, obj: obj);
  await setGuarantee(
    brand: brand,
    productName: newObj['name'],
    endDate: newObj['endDate'],
    note: newObj['note'],
  );
}

Future<List<Map<String, dynamic>>> getGuarantee({
  required brand,
  endDateMin = 0,
  endDateMax = 10e8,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String productJson = prefs.getString('guarantee-$brand') ?? '[]';
  List<Map<String, dynamic>> result = [];

  List<Map<String, dynamic>> productList = [];
  //[{'...':object}, {'...':object, '...':object}]
  productList = jsonDecode(productJson).cast<Map<String, dynamic>>();

  for (var product in productList) {
    if (endDateMin < product['endDate'] && product['endDate'] < endDateMax) {
      result.add(product);
    }
  }
  return result;
}

Future<List<String>?> getGuaranteeList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? guarantees = prefs.getStringList('guarantees');
  return guarantees;
}

Future<List<List>> getAllGuarantee() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List allproductBrand = prefs.getStringList('guarantees') ?? [];
  List<List> productList = [];
  List product = [];
  for (var brand in allproductBrand) {
    product = await getGuarantee(brand: brand);
    productList.addAll(List.generate(
        product.length, (index) => [brand, product[index]])); //시간순 정렬
    //productList = [{...}, {...}, {...}]
  }
  productList.sort((a, b) => a[1]['endDate'].compareTo(b[1]['endDate']));
  // 일단 버블 정렬이고 필요하면 바꿀 수 있음
  return productList;
}
