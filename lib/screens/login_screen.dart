//LoginScreen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/screens/main_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _ScreenLoginState();
}

void navigateToMainScreen(User user) {
  Get.to(() => MainScreen(user: user));
}

class _ScreenLoginState extends State<LoginScreen> {
  final _authentication = FirebaseAuth.instance;
  String? email;
  String? pw;
  String errorString = ''; //login error 보려고 만든 String state

  //firebase auth login 함수, 이멜 + 비번으로 로그인
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isButtonPressed = false;
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
                    'assets/images/login_screen.png'), // 배경화면으로 사용할 이미지 경로
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
                      const Text(
                        "Abibo",
                        style: ABTextTheme.LoginMainText1,
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 26,
                      ),
                      const Text(
                        "환영합니다!",
                        style: ABTextTheme.LoginMainText2,
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 58,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '아이디:',
                              style: ABTextTheme.LoginHintText,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: screenHeight / 844 * 40,
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white), // 입력 중 텍스트 스타일
                                decoration: const InputDecoration(
                                  filled: false,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
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
                        height: screenHeight / 944 * 32,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '비밀번호:',
                              style: ABTextTheme.LoginHintText,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: screenHeight / 844 * 40,
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.white), // 입력 중 텍스트 스타일
                                decoration: const InputDecoration(
                                  filled: false,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pw = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight / 944 * 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isButtonPressed = true;
                                  });
                                  // 로그인 상태 유지 버튼 기능
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 2),
                                  decoration: BoxDecoration(
                                    color: isButtonPressed
                                        ? Colors.purple
                                        : Colors.transparent, // 배경색
                                  ),
                                  child: Icon(
                                    isButtonPressed
                                        ? Icons.check_circle_rounded
                                        : Icons.check_circle_outline_outlined,
                                    size: 16, // 아이콘 크기 설정
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 0),
                              const Text(
                                '로그인 상태 유지',
                                style: ABTextTheme.LoginStateMaintain,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isButtonPressed =
                                        !isButtonPressed; // 버튼 상태 변경
                                  });
                                  // 로그인 상태 유지 버튼 기능
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                    color: isButtonPressed
                                        ? Colors.purple
                                        : Colors.transparent, // 배경색
                                  ),
                                  child: const Icon(
                                    Icons.warning_amber_outlined,
                                    size: 16, // 아이콘 크기 설정
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 0),
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    '비밀번호를 잊으셨나요?',
                                    style: ABTextTheme.LoginStateMaintain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 24,
                      ),
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          height: screenHeight / 944 * 70,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (email != null && pw != null) {
                                  final userCredential = await _authentication
                                      .signInWithEmailAndPassword(
                                    email: email!,
                                    password: pw!,
                                  );
                                  final User? currentUser = userCredential.user;
                                  if (currentUser != null) {
                                    navigateToMainScreen(currentUser);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("이메일과 비밀번호를 입력해주세요."),
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
                              backgroundColor: const Color(0xFFD08FFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "로그인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 944 * 100,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "계정이 없으신가요?",
                            style: ABTextTheme.QuestionNoAccount1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "회원가입하기",
                            style: ABTextTheme.QuestionNoAccount2,
                          ),
                        ],
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
