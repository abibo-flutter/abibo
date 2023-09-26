import 'dart:math';
import 'package:get/get.dart';
import 'functions/control_guarantee.dart';
import 'functions/control_platform.dart';
import 'functions/control_subscription.dart';

class HomeScreenController extends GetxController {
  String selected = 'platform';
  List<List> infos = <List>[];
  List<List> notice = <List>[];

  Future<void> select(String type) async {
    infos = [];
    selected = type;
    update();
    if (type == 'subscription') {
      infos = await getAllSubscription();
    } else if (type == 'platform') {
      infos = await getAllPlatform();
    } else if (type == 'guarantee') {
      infos = await getAllGuarantee();
    }
    update();
  }

  Future<void> searchInfo() async {
    if (selected == 'subscription') {
      infos = await getAllSubscription();
    } else if (selected == 'platform') {
      infos = await getAllPlatform();
    } else if (selected == 'guarantee') {
      infos = await getAllGuarantee();
    }
  }

  Future<void> searchNotice() async {
    List<List> arr = [];
    for (List list in await getAllSubscription()) {
      arr.add(['subscription', list]);
    }

    for (List list in await getAllGuarantee()) {
      arr.add(['guarantee', list]);
    }

    arr.sort((a, b) => a[1][1]['endDate'].compareTo(b[1][1]['endDate']));

    notice = arr.sublist(0, min(4, arr.length));
    update();
  }
}
