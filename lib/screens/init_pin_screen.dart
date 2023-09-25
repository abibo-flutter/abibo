//InitPINScreen.dart
import 'package:abibo/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:abibo/widgets/custom_text.dart';

class InitPINScreen extends StatefulWidget {
  const InitPINScreen({super.key});

  @override
  State<InitPINScreen> createState() => _InitPINScreenState();
}

void navigateToMainScreen() {
  Get.back();
}

class _InitPINScreenState extends State<InitPINScreen> {
  late SharedPreferences prefs;
  String? pin;
  String? pinCheck;
  bool pinVisible = false;
  bool pinCheckVisible = false;
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
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      const CustomText(
                        text: 'PIN 설정하기',
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
                    height: screenHeight / 844 * 10,
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenWidth / 390 * 5),
                      const CustomText(
                        text: '잠금해제에 사용할 PIN을 설정해보세요\nPIN은 언제든 변경할 수 있습니다',
                        style: TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 944 * 80,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 844 * 40,
                          child: TextField(
                            obscureText: !pinVisible,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            maxLength: 6,
                            style: const TextStyle(
                              color: Colors.black,
                            ), // 입력 중 텍스트 스타일
                            decoration: InputDecoration(
                              hintText: 'PIN',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                              ),
                              filled: false,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  pinVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      pinVisible = !pinVisible;
                                    },
                                  );
                                },
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
                            obscureText: !pinCheckVisible,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  pinVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      pinCheckVisible = !pinCheckVisible;
                                    },
                                  );
                                },
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
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight / 944 * 70,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (pin == null || pinCheck == null) {
                            Get.snackbar(
                              '알림',
                              'PIN과 PIN확인을 입력하세요.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          } else if (pin!.length != 6) {
                            Get.snackbar(
                              '알림',
                              'PIN이 6글자가 아닙니다.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          } else if (pin != pinCheck) {
                            Get.snackbar(
                              '알림',
                              'PIN 재확인이 올바르지 않습니다.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          } else if (int.tryParse(pin!) != null) {
                            prefs = await SharedPreferences.getInstance();
                            prefs.setString('PIN', pin!);
                            navigateToMainScreen();
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
                      child: const CustomText(
                        text: "PIN 변경하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 844 * 40,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
