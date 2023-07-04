import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 128,
              bottom: 0,
              left: screenHeight / 844 * 23,
              right: screenHeight / 844 * 23,
            ),
            child: Column(
              children: [
                const Text(
                  'Abibo',
                  style: ABTextTheme.MainMainText,
                ),
                SizedBox(height: screenHeight / 844 * 98),
                const Text(
                  '아비보를 시작하기 위하여 \n지문 인식을 진행해 주세요.',
                  textAlign: TextAlign.center,
                  style: ABTextTheme.FingerPrintLoginDescription,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool canCheckBiometrics =
                        await _localAuthentication.canCheckBiometrics;
                    if (canCheckBiometrics) {
                      bool authenticated =
                          await _localAuthentication.authenticate(
                        localizedReason: '지문 인식을 사용하여 인증하세요.',
                      );
                      if (authenticated) {
                        // 인증 성공한 경우 다음 페이지로 이동하는 로직 추가
                        Get.offAll(() => const MainScreen());
                      } else {
                        // 인증 실패한 경우 메시지 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("지문 인식에 실패했습니다."),
                          ),
                        );
                      }
                    } else {
                      // 지문 인식이 지원되지 않는 기기일 경우 메시지 표시
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("지문 인식이 지원되지 않는 기기입니다."),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "지문으로 인증하기",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
