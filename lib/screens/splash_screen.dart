import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abibo/screens/after_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToNextPage() async {
    // 로딩이 완료된 후 NextPage로 이동
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const AfterSplashScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          // child: Lottie.asset(
          //   'assets/animations/wave_animation.json',
          //   width: 400,
          //   height: 400,
          //   fit: BoxFit.contain,
          // ),
          ),
    );
  }
}
