import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/notice_period_screen.dart';
import 'package:abibo/screens/theme/color_theme.dart';
import 'package:abibo/widgets/custon_switch_button.dart';
// import 'package:abibo/screens/notice_period_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

Future<void> resetSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

void _showAlert(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("초기화"),
        content: const Text("PIN을 포함한 \n모든 데이터를 삭제하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("예"),
            onPressed: () {
              resetSharedPreferences();
              Navigator.of(context).pop();
              Get.snackbar(
                '알림',
                '초기화가 완료되었습니다.',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          ),
          CupertinoDialogAction(
            child: const Text("아니요"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
    bool capturepermit = false;
    bool entireNotificationenable = false;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 60,
            bottom: 0,
            left: screenWidth / 390 * 26,
            right: 0,
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
                padding: EdgeInsets.only(left: screenWidth / 390 * 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '전체 알림',
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
                                color: Colors
                                    .black, //!아래 버튼 눌렀을 떄 entireNotificationenable에 따라 text색이 바껴야 하는데 deadcode로 뜸
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: screenWidth / 390 * 50,
                              height: screenHeight / 844 * 26,
                              child: CustomSwitchButton(
                                value: entireNotificationenable,
                                onChanged: (value) {
                                  setState(() {
                                    entireNotificationenable = value;
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
                            const Icon(
                              Icons.alarm_add_sharp,
                            ),
                            SizedBox(width: screenWidth / 390 * 8),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const NoticePeriodScreen());
                              },
                              child: Container(
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
                          '화면 캡쳐 허용',
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
                          onTap: () {
                            _showAlert(context);
                          },
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
                        SizedBox(
                          height: screenHeight / 844 * 22,
                        ),
                        Container(
                          width: screenWidth,
                          height: 1,
                          decoration:
                              const BoxDecoration(color: Color(0xFFCCCCCC)),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight / 844 * 110),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '어플리케이션 정보',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 7,
                        ),
                        Text(
                          '버전 : 1.0.0\n개인정보처리방침 및 법률정보',
                          style: TextStyle(
                            color:
                                Colors.black.withOpacity(0.20000000298023224),
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 844 * 5,
                        ),
                        Text(
                          '고객센터 : 02-XXXX-XXXX\n                 abibo@gmail.com',
                          style: TextStyle(
                            color:
                                Colors.black.withOpacity(0.20000000298023224),
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        )
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
