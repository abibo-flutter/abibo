import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/screens/finger_print_screen.dart';
import 'package:get/get.dart';

class PINScreen extends StatefulWidget {
  const PINScreen({Key? key}) : super(key: key);

  @override
  State<PINScreen> createState() => _PINScreenState();
}

class _PINScreenState extends State<PINScreen> {
  final pinCodeEditor = TextEditingController();
  final textFieldFocusNode = FocusNode();
  late SharedPreferences prefs;
  String? PIN;
  String? pin;
  bool onKeyboard = false;

  Future<String?> getPIN() async {
    prefs = await SharedPreferences.getInstance();
    PIN = prefs.getString('PIN');
    return PIN;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/second_login_screen.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight / 844 * 30,
                  bottom: 0,
                  left: screenHeight / 844 * 23,
                  right: screenHeight / 844 * 23,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 844 * 83,
                    ),
                    const Text(
                      'Abibo',
                      style: ABTextTheme.LoginMainText1,
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 12,
                    ),
                    const Text(
                      'PIN 번호 6자리를 입력해주세요!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 63,
                    ),
                    Container(
                      width: double.infinity,
                      height: screenHeight / 844 * 60,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          obscureText: true,
                          obscuringCharacter: '●',
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: pinCodeEditor,
                          focusNode: textFieldFocusNode,
                          onTap: () {
                            setState(() {
                              onKeyboard = true;
                            });
                          },
                          onTapOutside: (event) {
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              setState(() {
                                pin = pinCodeEditor.text;
                              });
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight / 844 * 70,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (pin == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("PIN을 입력해주세요."),
                                ),
                              );
                            } else if (pin!.length != 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("PIN이 6자리가 아닙니다."),
                                ),
                              );
                            } else if (int.tryParse(pin!) != null) {
                              prefs = await SharedPreferences.getInstance();
                              PIN = prefs.getString('PIN');
                              if (PIN == pin) {
                                Get.offAll(() => const MainScreen());
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
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "메인으로",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 26,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: const Text(
                          'PIN 번호를 분실했습니까?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight / 844 * 16),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => const FingerPrintScreen());
                      },
                      child: const Text(
                        '생체인식을 이용하여 보안 인증하기',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              if (onKeyboard)
                KeyBoard(
                  controller: pinCodeEditor,
                  enterFunc: () {
                    setState(() {
                      onKeyboard = false;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
