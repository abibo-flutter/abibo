import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/theme/color_theme.dart';
import 'package:abibo/widgets/custon_switch_button.dart';
// import 'package:abibo/screens/notice_period_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

// void navigateToNoticePeriodScreen() {
//   Get.to(() => const NoticePeriodScreen());
// }

class _SettingScreenState extends State<SettingScreen> {
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
    bool entireNotificationenable = false;
    bool capturepermit = false;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 60,
            bottom: 0,
            left: screenWidth / 390 * 26,
            right: screenWidth / 390 * 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 24,
                      color: ABColors.MAIN_THEME,
                    ),
                  ),
                  const Text(
                    '설정',
                    style: ABTextTheme.SettingMainText,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 844 * 70,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenWidth / 390 * 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '전체알림',
                          style: ABTextTheme.SettingMenuTitle,
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 16,
                        ),
                        Row(
                          children: [
                            const Text(
                              'ON',
                              style: TextStyle(
                                height: 1.2,
                                letterSpacing: -0.4,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: screenWidth / 390 * 50,
                              height: screenHeight / 844 * 26,
                              child: CustomSwitchButton(
                                value: entireNotificationenable,
                                onChanged: (bool val) {
                                  setState(() {
                                    entireNotificationenable = val;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'OFF',
                              style: TextStyle(
                                height: 1.2,
                                letterSpacing: -0.4,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 31,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.alarm_add_sharp,
                              ),
                              onTap: () {},
                            ),
                            SizedBox(width: screenWidth / 390 * 8),
                            Container(
                              width: screenWidth / 390 * 88,
                              height: screenHeight / 844 * 32,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF1F1F1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '알람 추가',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 46,
                        ),
                        Container(
                          width: screenWidth,
                          height: 1,
                          decoration:
                              const BoxDecoration(color: Color(0xFFCCCCCC)),
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 24,
                        ),
                        const Text(
                          '화면 캡쳐 비용',
                          style: ABTextTheme.SettingMenuTitle,
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 16,
                        ),
                        Row(
                          children: [
                            const Text(
                              'ON',
                              style: TextStyle(
                                height: 1.2,
                                letterSpacing: -0.4,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: screenWidth / 390 * 50,
                              height: screenHeight / 844 * 26,
                              child: CustomSwitchButton(
                                value: capturepermit,
                                onChanged: (bool val) {
                                  setState(() {
                                    capturepermit = val;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'OFF',
                              style: TextStyle(
                                height: 1.2,
                                letterSpacing: -0.4,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 24,
                        ),
                        Container(
                          width: screenWidth,
                          height: 1,
                          decoration:
                              const BoxDecoration(color: Color(0xFFCCCCCC)),
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 24,
                        ),
                        const Text(
                          '보안 설정',
                          style: ABTextTheme.SettingMenuTitle,
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 22,
                        ),
                        GestureDetector(
                          onTap: () async {
                            prefs = await SharedPreferences.getInstance();
                            PIN = prefs.getString('PIN');
                            if (PIN != null) {
                              navigateToChangePINScreen();
                            } else {
                              navigateToInitPINScreen();
                            }
                          },
                          child: Text(
                            'PIN 번호 변경',
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.699999988079071),
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 12,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            '전체 삭제 / 초기화',
                            style: TextStyle(
                              color: Color(0xFFE50303),
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
