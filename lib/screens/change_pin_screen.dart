//ChangePINScreen.dart
import 'package:abibo/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:get/get.dart';

class ChangePINScreen extends StatefulWidget {
  const ChangePINScreen({super.key});

  @override
  State<ChangePINScreen> createState() => _ChangePINScreenState();
}

void navigateToMainScreen() {
  Get.back();
}

class _ChangePINScreenState extends State<ChangePINScreen> {
  final secureKeyboardController = SecureKeyboardController();
  final pinCodeEditor = TextEditingController();
  final textFieldFocusNode = FocusNode();
  late SharedPreferences prefs;
  String? PIN; //전역변수
  String? pin; //기존 pin 입력
  String? newPIN; //신규 pin 입력
  String? pinCheck; //신규 pin 확인
  String errorString = ''; //error 보려고 만든 String state

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
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 90,
              bottom: 0,
              left: screenHeight / 844 * 32,
              right: screenHeight / 844 * 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: screenWidth / 390 * 3),
                        const Text(
                          'PIN 변경하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 130,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 844 * 40,
                            child: TextField(
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              style: const TextStyle(
                                color: Colors.black,
                              ), // 입력 중 텍스트 스타일
                              decoration: InputDecoration(
                                hintText: '기존 PIN',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                filled: false,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  pin = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 48,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 844 * 40,
                            child: TextField(
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              style: const TextStyle(
                                color: Colors.black,
                              ), // 입력 중 텍스트 스타일
                              decoration: InputDecoration(
                                hintText: '신규 PIN',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                filled: false,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  newPIN = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 48,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 844 * 40,
                            child: TextField(
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              style: const TextStyle(
                                color: Colors.black,
                              ), // 입력 중 텍스트 스타일
                              decoration: InputDecoration(
                                hintText: 'PIN 확인',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                filled: false,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFD9D9D9), width: 2),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  pinCheck = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: screenHeight / 844 * 220),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight / 844 * 64,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (pin == null ||
                                newPIN == null ||
                                pinCheck == null) {
                              Get.snackbar(
                                '알림',
                                'PIN을 입력해주세요.',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            } else if (newPIN != pinCheck) {
                              Get.snackbar(
                                '알림',
                                'PIN 재확인이 올바르지 않습니다.',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            } else if (pin!.length != 6 ||
                                newPIN!.length != 6) {
                              Get.snackbar(
                                '알림',
                                'PIN이 6자리가 아닙니다.',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            } else if (int.tryParse(pin!) != null &&
                                int.tryParse(newPIN!) != null) {
                              prefs = await SharedPreferences.getInstance();
                              PIN = prefs.getString('PIN');
                              if (PIN == pin) {
                                prefs = await SharedPreferences.getInstance();
                                prefs.setString('PIN', newPIN!);
                                navigateToMainScreen();
                              } else {
                                Get.snackbar(
                                  '알림',
                                  'PIN이 올바르지 않습니다.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            }
                          } catch (err) {
                            print(err);
                            Get.snackbar(
                              '알림',
                              '오류가 발생했습니다, 다시 시도해주세요.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ABColors.MAIN_THEME,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "PIN 변경하기",
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
