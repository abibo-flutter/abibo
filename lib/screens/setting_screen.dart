import 'package:abibo/functions/notification.dart';
import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/notice_period_screen.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/widgets/custom_switch_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

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
  bool capturepermit = false;
  bool entireNotificationenable = false;
  List infos = [];

  Future<bool> getEntireNotificationenable() async {
    prefs = await SharedPreferences.getInstance();
    entireNotificationenable =
        prefs.getBool('entireNotificationenable') ?? true;
    return entireNotificationenable;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                      widget.controller.animateTo(1);
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
              FutureBuilder(
                  future: getEntireNotificationenable(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: screenWidth / 390 * 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text(
                                    'ON',
                                    style: TextStyle(
                                      height: 1.2,
                                      letterSpacing: -0.4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      color: entireNotificationenable
                                          ? Colors.black
                                          : const Color(0xFF000000)
                                              .withOpacity(0.3),
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: screenWidth / 390 * 50,
                                    height: screenHeight / 844 * 26,
                                    child: CustomSwitchButton(
                                      value: entireNotificationenable,
                                      onChanged: (value) async {
                                        if (value) {
                                          await updatePeriod();
                                        } else {
                                          await resetNotification();
                                        }
                                        await prefs.setBool(
                                            'entireNotificationenable', value);
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
                                      color: entireNotificationenable
                                          ? Colors.black.withOpacity(0.3)
                                          : Colors.black,
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
                                  Icon(
                                    Icons.alarm_add_sharp,
                                    color: entireNotificationenable
                                        ? Colors.black
                                        : const Color(0xFFD1D1D1),
                                  ),
                                  SizedBox(width: screenWidth / 390 * 8),
                                  GestureDetector(
                                    onTap: () {
                                      if (entireNotificationenable == true) {
                                        Get.to(
                                            () => const NoticePeriodScreen());
                                      } else {
                                        Get.snackbar(
                                          '알림',
                                          '전체 알림을 허용한 후 다시 시도해주세요',
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: const Duration(seconds: 2),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: screenWidth / 390 * 88,
                                      height: screenHeight / 844 * 32,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF1F1F1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '알람 추가',
                                          style: TextStyle(
                                            color: entireNotificationenable
                                                ? Colors.black
                                                : const Color(0xFFD1D1D1),
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
                                decoration: const BoxDecoration(
                                    color: Color(0xFFCCCCCC)),
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
                                  Text(
                                    'ON',
                                    style: TextStyle(
                                      height: 1.2,
                                      letterSpacing: -0.4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      color: capturepermit
                                          ? Colors.black
                                          : Colors.black.withOpacity(0.3),
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: screenWidth / 390 * 50,
                                    height: screenHeight / 844 * 26,
                                    child: CustomSwitchButton(
                                      value: capturepermit,
                                      onChanged: (value) {
                                        setState(() {
                                          capturepermit = value;
                                          /*if (!capturepermit) {
                                          // 화면 캡쳐 비허용 설정
                                          FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                                        } else {
                                          // 화면 캡쳐 비허용 해제
                                          FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                                        }*/
                                          Get.snackbar(
                                            '알림',
                                            '화면 캡쳐 허용 기능은 개발중입니다.',
                                            snackPosition: SnackPosition.BOTTOM,
                                            duration:
                                                const Duration(seconds: 2),
                                          );
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
                                      color: capturepermit
                                          ? Colors.black.withOpacity(0.3)
                                          : Colors.black,
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
                                decoration: const BoxDecoration(
                                    color: Color(0xFFCCCCCC)),
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
                                    color: Colors.black
                                        .withOpacity(0.699999988079071),
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
                                decoration: const BoxDecoration(
                                    color: Color(0xFFCCCCCC)),
                              ),
                              const Expanded(child: SizedBox()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '어플리케이션 정보',
                                    style: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6000000238418579),
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
                                      color: Colors.black
                                          .withOpacity(0.20000000298023224),
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
                                      color: Colors.black
                                          .withOpacity(0.20000000298023224),
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
                      );
                    }
                    return const SizedBox();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
