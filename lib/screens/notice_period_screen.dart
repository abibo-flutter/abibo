//NoticePeriodScreen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoticePeriodScreen extends StatefulWidget {
  const NoticePeriodScreen({super.key});

  @override
  State<NoticePeriodScreen> createState() => _NoticePeriodScreenState();
}

void navigateToMainScreen() {
  Get.back();
}

class _NoticePeriodScreenState extends State<NoticePeriodScreen> {
  final secureKeyboardController = SecureKeyboardController();
  final pinCodeEditor = TextEditingController();
  final textFieldFocusNode = FocusNode();
  late SharedPreferences prefs;
  String? period; //전역변수
  String? newPeriod; //신규 pin 입력

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/signup_screen.png'), // 배경화면으로 사용할 이미지 경로
              fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절하여 채우도록 설정
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 104,
              bottom: 0,
              left: screenHeight / 844 * 28,
              right: screenHeight / 844 * 28,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "발송 주기 변경하기",
                          style: ABTextTheme.LoginMainText2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 58,
                    ),
                    SizedBox(
                      height: screenHeight / 944 * 48,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 844 * 40,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors.white,
                              ), // 입력 중 텍스트 스타일
                              decoration: InputDecoration(
                                hintText: '알림 발송 날짜',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                filled: false,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  newPeriod = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 944 * 48,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight / 944 * 70,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (newPeriod == null ||
                                int.tryParse(newPeriod!) == null) {
                              Fluttertoast.showToast(
                                msg: "발송 날짜를 입력해주세요.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 20,
                              );
                            } else {
                              prefs = await SharedPreferences.getInstance();
                              prefs.setString('period', jsonEncode(newPeriod));
                              navigateToMainScreen();
                            }
                          } catch (err) {
                            print(err);
                            Fluttertoast.showToast(
                              msg: "오류가 발생했습니다, 다시 시도해주세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 20,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD08FFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "발송 주기 변경하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight / 844 * 10),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight / 944 * 70,
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(143, 199, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "뒤로가기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
