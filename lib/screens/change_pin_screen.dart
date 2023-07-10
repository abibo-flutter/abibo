//ChangePINScreen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:abibo/screens/theme/text_theme.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                            "PIN 변경하기",
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
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                style: const TextStyle(
                                  color: Colors.white,
                                ), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '기존 PIN',
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
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                style: const TextStyle(
                                  color: Colors.white,
                                ), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '신규 PIN',
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
                                    newPIN = value;
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
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                style: const TextStyle(
                                  color: Colors.white,
                                ), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: 'PIN 확인',
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
                                    pinCheck = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 57,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight / 944 * 70,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (pin == null ||
                                  newPIN == null ||
                                  pinCheck == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("PIN을 입력해주세요."),
                                  ),
                                );
                              } else if (newPIN != pinCheck) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("PIN 확인이 올바르지 않습니다."),
                                  ),
                                );
                              } else if (pin!.length != 6 ||
                                  newPIN!.length != 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("PIN이 6자리가 아닙니다."),
                                  ),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("PIN이 올바르지 않습니다."),
                                    ),
                                  );
                                }
                              }
                            } catch (err) {
                              print(err);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("오류"),
                                ),
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
                            "PIN 변경하기",
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
      ),
    );
  }
}
