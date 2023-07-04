import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/screens/platforms.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight / 844 * 38,
        bottom: 0,
        left: screenHeight / 844 * 23,
        right: screenHeight / 844 * 23,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Image(
                  image: AssetImage('assets/images/button/menu.png'),
                ),
                iconSize: 20,
              );
            }),
          ),
          const Row(
            children: [
              Text(
                'Abibo',
                style: ABTextTheme.MainMainText,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 844 * 54,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            const Platforms()); // 다음페이지에는 이동하려는 페이지 위젯을 넣어주세요
                      },
                      child: const Text('플랫폼'),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 390 * 6,
                  ),
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            const Platforms()); // 다음페이지에는 이동하려는 페이지 위젯을 넣어주세요
                      },
                      child: const Text('OTT'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 844 * 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            const Platforms()); // 다음페이지에는 이동하려는 페이지 위젯을 넣어주세요
                      },
                      child: const Text('보증서'),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 390 * 6,
                  ),
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            const Platforms()); // 다음페이지에는 이동하려는 페이지 위젯을 넣어주세요
                      },
                      child: const Text('메모'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
