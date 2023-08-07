import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/screens/finger_print_screen.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'theme/color_theme.dart';

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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: ABColors.MAIN_THEME),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: screenHeight / 844 * 157,
                  bottom: 0,
                  left: screenWidth / 390 * 30,
                  right: screenWidth / 390 * 30,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Abibo',
                      style: ABTextTheme.LoginMainText1,
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 12,
                    ),
                    const Text(
                      'PIN 번호를 입력해주세요!',
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
                              Fluttertoast.showToast(
                                msg: "PIN을 입력해주세요.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 20,
                              );
                            } else if (pin!.length != 6) {
                              Fluttertoast.showToast(
                                msg: "PIN이 6자리가 아닙니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 20,
                              );
                            } else if (int.tryParse(pin!) != null) {
                              prefs = await SharedPreferences.getInstance();
                              PIN = prefs.getString('PIN');
                              if (PIN == pin) {
                                Get.offAll(() => const MainScreen());
                              } else {
                                Fluttertoast.showToast(
                                  msg: "PIN이 올바르지 않습니다.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 20,
                                );
                              }
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
                      height: screenHeight / 844 * 16,
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
                    SizedBox(height: screenHeight / 844 * 10),
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
                )),
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
            SizedBox(height: screenHeight / 844 * 44),
          ],
        ),
      ),
    );
  }
}
