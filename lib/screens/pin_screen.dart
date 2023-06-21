import 'package:abibo/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';

class PINScreen extends StatefulWidget {
  const PINScreen({Key? key}) : super(key: key);

  @override
  State<PINScreen> createState() => _PINScreenState();
}

class _PINScreenState extends State<PINScreen> {
  final secureKeyboardController = SecureKeyboardController();
  final pinCodeEditor = TextEditingController();
  final textFieldFocusNode = FocusNode();
  late SharedPreferences prefs;
  String? PIN;
  String? pin;

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

    return WithSecureKeyboard(
      controller: secureKeyboardController,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/second_login_screen.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight / 844 * 38,
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
                        readOnly: true,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        obscuringCharacter: '●',
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        controller: pinCodeEditor,
                        focusNode: textFieldFocusNode,
                        onTap: () {
                          pinCodeEditor.text = '';
                          secureKeyboardController.show(
                            maxLength: 6,
                            type: SecureKeyboardType.NUMERIC,
                            focusNode: textFieldFocusNode,
                            onKeyPressed: (value) {
                              if (value.text != null) {
                                pinCodeEditor.text += value.text!;
                              }
                            },
                            onDoneKeyPressed: (List<int> charCodes) {
                              pinCodeEditor.text =
                                  String.fromCharCodes(charCodes);
                              pin = pinCodeEditor.text;
                            },
                          );
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
                              Get.offAll(const MainScreen());
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
                    height: screenHeight / 844 * 22,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'PIN 번호를 분실했습니까?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
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
