//LoginScreen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _ScreenLoginState();
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 944 * 84,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "아비보 가입하기",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight / 944 * 74,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '아이디 (Email)',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFC9C9C9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 944 * 40,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: '비밀번호',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          )),
                      onChanged: (value) {
                        setState(() {
                          pw = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 944 * 20,
                  ),
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      height: screenHeight / 944 * 72,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (email != null && pw != null) {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                email: email!,
                                password: pw!,
                              );
                              if (newUser.user != null) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("회원가입 성공!"),
                                    ),
                                  );
                                }
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
                          backgroundColor: const Color(0xFF6B19DC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "회원가입",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(errorString),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
