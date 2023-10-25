import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CounterController extends GetxController {
  var objectCount = 0.obs;

  void objectCountincrease() {
    objectCount.value++;
    if (objectCount.value == 1) {
      Get.defaultDialog(
        title: "더 많은 정보 등록하기",
        middleText: "아비보+를 결재해 더 많은 정보를 등록해보세요",
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // 다이얼로그 닫기
            },
            child: const Text("확인"),
          ),
        ],
      );
    }
  }

  void objectCountdecrease() {
    objectCount.value--;
  }
}
