import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SharedPreferences prefs;
  List<List<String>> todos = []; //[[type, name], [],]

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    String searching = "";
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_screen.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
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
                onChanged: (value) {
                  setState(() {
                    searching = value.toLowerCase();
                    if (searching.isNotEmpty) {}
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    String type = todos[index][0];
                    String name = todos[index][1];
                    if (searching.isEmpty ||
                        !name.toLowerCase().contains(searching)) {
                      return const SizedBox.shrink(); // 검색어가 포함되지 않은 항목 숨기기
                    }

                    if (type == 'platform') {
                      return PlatformCard(
                        type: type,
                        name: name,
                      );
                    }
                    if (type == 'memo') {
                      return MemoCard(
                        type: type,
                        name: name,
                      );
                    }
                    if (type == 'subscription') {
                      return SubscriptionCard(
                        type: type,
                        name: name,
                      );
                    }
                    // if (todo[0] == 'platform') {
                    //   return Card(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius:
                    //           BorderRadius.circular(10), // 원하는 라운드 모서리 반지름 값 설정
                    //     ),
                    //     color: const Color(0xff0000ff), //kBgColor),
                    //     child: ListTile(
                    //       title: Text(
                    //         todo[1],
                    //       ),
                    //     ),
                    //   );
                    // }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
