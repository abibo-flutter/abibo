//ResetPWScreen.dart
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/screens/firebase/login_screen.dart';
import 'package:get/get.dart';

class ResetPWScreen extends StatefulWidget {
  const ResetPWScreen({super.key});

  @override
  State<ResetPWScreen> createState() => _ResetPWScreenState();
}

void navigateToLoginScreen() {
  Get.to(() => const LoginScreen());
}

class _ResetPWScreenState extends State<ResetPWScreen> {
  final _authentication = FirebaseAuth.instance;
  String? email;
  String? pw;
  String? pwCheck;
  String errorString = ''; //login error 보려고 만든 String state
  bool isButtonPressed = false;

  //firebase auth login 함수, 이멜 + 비번으로 로그인
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
                            "비밀번호 재설정하기",
                            style: ABTextTheme.LoginMainText2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '아비보에 가입했던 이메일을 입력해주세요.\n비밀번호 재설정 이메일을 보내드립니다.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 84,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight / 844 * 30,
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white), // 입력 중 텍스트 스타일
                                decoration: InputDecoration(
                                  hintText: '이메일 입력',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontFamily: 'Pretendard',
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
                                    email = value;
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
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight / 844 * 63,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (email != null) {
                                await _authentication.setLanguageCode("ko");
                                await _authentication.sendPasswordResetEmail(
                                  email: email!,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("이메일을 입력해주세요."),
                                  ),
                                );
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
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "이메일 전송",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight / 844 * 63,
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToLoginScreen();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "로그인 하러 가기",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
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
*/