import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/screens/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/color_theme.dart';

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
        localizedReason: '생체 인식을 사용하여 인증하세요.',
      );
      if (authenticated) {
        // 인증 성공한 경우 다음 페이지로 이동하는 로직 추가
        Get.offAll(() => const MainScreen());
      } else {
        Fluttertoast.showToast(
          msg: "생체인식에 실패했습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 20,
        );
      }
    } else {
      // 지문 인식이 지원되지 않는 기기일 경우 메시지 표시
      Fluttertoast.showToast(
        msg: "생체인식이 지원하지 않느 기기이거나, 정보가 등록되어있지 않습니다",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20,
      );
    }
  }

  Future<void> authenticateWithFace(BuildContext context) async {
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
            localizedReason: '생체 인식을 사용하여 인증하세요.',
          );
        } catch (e) {
          // Handle authentication error
          Fluttertoast.showToast(
            msg: "오류가 발생했습니다, 다시 시도해주세요.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 20,
          );
        }
      }

      if (isAuthenticated) {
        // Add logic to proceed to the next page after successful authentication
        Get.offAll(() => const MainScreen());
      } else {
        // Display a message for authentication failure
        Fluttertoast.showToast(
          msg: "생체인식에 실패했습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 20,
        );
      }
    } else {
      // Display a message for unsupported devices
      Fluttertoast.showToast(
        msg: "생체인식이 지원하지 않는 기기이거나, 정보가 등록되어있지 않습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ABColors.MAIN_THEME,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 162,
            bottom: 0,
            left: screenWidth / 844 * 23,
            right: screenWidth / 844 * 23,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Abibo',
                style: ABTextTheme.LoginMainText1,
              ),
              SizedBox(height: screenHeight / 844 * 42),
              const Text(
                '아비보를 시작하기 위하여 \n생체 인식을 진행해 주세요.',
                textAlign: TextAlign.center,
                style: ABTextTheme.FingerPrintLoginDescription,
              ),
              SizedBox(height: screenHeight / 844 * 284),
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
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight / 844 * 36),
              InkWell(
                onTap: () {},
                child: const Text(
                  '생체인식이 안되나요?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 844 * 12),
              InkWell(
                onTap: () {
                  Get.offAll(() => const PINScreen());
                },
                child: const Text(
                  'PIN을 이용하여 보안 인증하기',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFACA5DF),
                    height: 1.43,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
