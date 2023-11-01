import 'package:abibo/functions/notification.dart';
import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/notice_period_screen.dart';
import 'package:abibo/screens/webview_screen.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/widgets/custom_switch_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:abibo/static.dart';
import 'package:abibo/widgets/custom_text.dart';

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
              Get.back();
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
              Get.back();
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
                  const CustomText(
                    text: '설정',
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
                              const CustomText(
                                text: '전체 알림',
                                style: ABTextTheme.SettingMenuTitle,
                              ),
                              SizedBox(
                                height: screenHeight / 844 * 16,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: 'ON',
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
                                  CustomSwitchButton(
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
                                  const SizedBox(width: 10),
                                  CustomText(
                                    text: 'OFF',
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
                                        child: CustomText(
                                          text: '알람 추가',
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
                              const CustomText(
                                text: '보안 설정',
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
                                child: CustomText(
                                  text: 'PIN 번호 설정 / 변경',
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
                                child: const CustomText(
                                  text: '전체 삭제 / 초기화',
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
                                  CustomText(
                                    text: '어플리케이션 정보',
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
                                  CustomText(
                                    text: '버전 : ${ABStatic.AppVersion}',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.2),
                                      fontSize: 10,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomText(
                                    text: '고객센터 : devdoyun@gmail.com',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.2),
                                      fontSize: 10,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const WebviewScreen());
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: '개인정보처리방침 및 법률정보',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.2),
                                          fontSize: 9,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Colors.black.withOpacity(0.2),
                                          decorationThickness: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 844 * 56,
                                  ),
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
