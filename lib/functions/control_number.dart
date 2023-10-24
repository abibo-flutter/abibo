import 'package:get/get.dart';

class CounterController extends GetxController {
  var objectCount = 0.obs;

  void objectCountincrease() {
    objectCount.value++;
  }

  void objectCountdecrease() {
    objectCount.value--;
  }
}
