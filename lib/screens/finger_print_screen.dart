import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/screens/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
  }

  Future<void> authenticateWithFingerprint(BuildContext context) async {
    final bool canAuthenticateWithBiometrics =
        await _localAuthentication.canCheckBiometrics;
    final bool canCheckBiometrics = canAuthenticateWithBiometrics ||
        await _localAuthentication.isDeviceSupported();
    if (canCheckBiometrics) {
      bool authenticated = await _localAuthentication.authenticate(
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
  }

  /*Future<void> authenticateWithFace(BuildContext context) async {
    final bool canAuthenticateWithBiometrics =
        await _localAuthentication.canCheckBiometrics;
    final bool canCheckBiometrics = canAuthenticateWithBiometrics ||
        await _localAuthentication.isDeviceSupported();
    if (canCheckBiometrics) {
      final availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();
      bool isAuthenticated = false;
      if (availableBiometrics.contains(BiometricType.face)) {
        try {
          isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: '얼굴 인식을 사용하여 인증하세요.',
          );
        } catch (e) {
          // Handle authentication error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("얼굴 인식에 실패했습니다."),
            ),
          );
        }
      }

      if (isAuthenticated) {
        // Add logic to proceed to the next page after successful authentication
        Get.offAll(() => const MainScreen());
      } else {
        // Display a message for authentication failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("얼굴 인식에 실패했습니다."),
          ),
        );
      }
    } else {
      // Display a message for unsupported devices
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("얼굴 인식이 지원되지 않는 기기입니다."),
        ),
      );
    }
  }*/

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
              left: screenWidth / 844 * 23,
              right: screenWidth / 844 * 23,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Abibo',
                  style: ABTextTheme.MainMainText,
                ),
                SizedBox(height: screenHeight / 844 * 90),
                const Text(
                  '아비보를 시작하기 위하여 \n지문 인식을 진행해 주세요.',
                  textAlign: TextAlign.center,
                  style: ABTextTheme.FingerPrintLoginDescription,
                ),
                SizedBox(height: screenHeight / 844 * 270),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 70,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    authenticateWithFingerprint(context);
                                    return Container();
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.fingerprint_sharp,
                            size: 50,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                      SizedBox(
                        width: 70,
                        child: IconButton(
                          onPressed: () => Get.defaultDialog(
                              title: '알림', middleText: '얼굴인식은 개발중입니다!'),

                          /*showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    authenticateWithFace(
                                        context); // Call the face recognition authentication method
                                    return Container();
                                  },
                                );
                              },
                            );*/

                          icon: Icon(
                            Icons.face_unlock_sharp,
                            size: 50,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight / 844 * 30),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    '지문인식이 안되나요?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 844 * 24),
                InkWell(
                  onTap: () {
                    Get.offAll(() => const PINScreen());
                  },
                  child: const Text(
                    'PIN을 이용하여 보안 인증하기',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFACA5DF),
                      decoration: TextDecoration.underline,
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
