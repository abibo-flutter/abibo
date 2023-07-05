import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/cards.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/control_memo.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<List> todos = []; //[[type, name, object], [],]

  @override
  void initState() {
    super.initState();
  }

  Future<List<List>> searchTodos(String inputText) async {
    List<List> arr = [];
    for (String name in await getPlatformList() ?? []) {
      if (!name.contains(inputText)) continue;
      for (var obj in await getPlatform(platform: name)) {
        arr.add(['platform', name, obj]);
      }
    }

    for (String name in await getSubscriptionList() ?? []) {
      if (!name.contains(inputText)) continue;
      for (var obj in await getSubscription(serviceName: name)) {
        arr.add(['subscription', name, obj]);
      }
    }

    for (String name in await getMemoList() ?? []) {
      if (!name.contains(inputText)) continue;
      arr.add(['memo', name, await getMemo(title: name)]);
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    String searching = "";
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight / 844 * 52,
        bottom: 0,
        left: screenHeight / 844 * 23,
        right: screenHeight / 844 * 23,
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Abibo',
                style: ABTextTheme.MainMainText,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 844 * 32,
          ),
          TextField(
            decoration: InputDecoration(
              //입력 전 디자인
              hintText: "원하는 정보를 입력하세요.",
              hintStyle: ABTextTheme.SearchingText,
              suffixIcon: const Icon(Icons.search),
              suffixIconColor: Colors.white, // 검색 아이콘
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(18.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(18.5),
              ),
            ),
            style: ABTextTheme.SearchingText,
            onChanged: (value) async {
              searching = value.toLowerCase().removeAllWhitespace;
              if (searching.isEmpty) {
                todos = [];
              } else {
                todos = await searchTodos(searching);
              }
              setState(() {});
              print(todos);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white30),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  String type = todos[index][0];
                  String name = todos[index][1];
                  dynamic obj = todos[index][2];

                  if (type == 'platform') {
                    return PlatformCard(
                      name: name,
                      obj: obj,
                    );
                  }
                  if (type == 'memo') {
                    return MemoCard(
                      name: name,
                      text: obj,
                    );
                  }
                  if (type == 'subscription') {
                    return SubscriptionCard(
                      name: name,
                      obj: obj,
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
