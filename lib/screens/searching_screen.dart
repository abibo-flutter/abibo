import 'dart:ui';
import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/mainmenucard.dart';
import 'package:abibo/widgets/drawerheader.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _SearchScreenState extends State<SearchScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                Column(
                  children: [
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
                          // searching = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
