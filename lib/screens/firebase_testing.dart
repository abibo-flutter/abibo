//ScreenLogin.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _authentication = FirebaseAuth.instance;
  String? email;
  String? pw;
  String errorString = ''; //login error 보려고 만든 String state

  //firebase auth login 함수, 이멜 + 비번으로 로그인
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: const Text(
                    "회원가입 페이지",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'EMAIL입력칸',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
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
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'PW입력칸',
                        hintStyle: TextStyle(
                          fontSize: 15,
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
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
                      child: const Text("회원가입"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(errorString),
                  ),
                ),
              ]),
            ),
            Container(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: const Text(
                    "로그인 페이지",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'EMAIL입력칸',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'PW입력칸',
                        hintStyle: TextStyle(
                          fontSize: 15,
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          if (email != null && pw != null) {
                            final newUser = await _authentication
                                .signInWithEmailAndPassword(
                              email: email!,
                              password: pw!,
                            );
                            if (newUser.user != null) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("로그인 성공!"),
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
                      child: const Text("로그인"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(errorString),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
