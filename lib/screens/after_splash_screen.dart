import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:abibo/screens/pin_screen.dart';
import 'package:abibo/screens/main_screen.dart';
import 'package:abibo/screens/theme/color_theme.dart';

class AfterSplashScreen extends StatefulWidget {
  const AfterSplashScreen({Key? key}) : super(key: key);

  @override
  State<AfterSplashScreen> createState() => _AfterSplashScreenState();
}

class _AfterSplashScreenState extends State<AfterSplashScreen> {
  Future<String?> getPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? PIN = prefs.getString('PIN');
    return PIN;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primaryColor: AbColor.ABMainColor,
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          brightness: Brightness.light,
          primary: AbColor.ABMainColor,
        ),
      ),
      home: FutureBuilder(
        future: getPIN(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return const PINScreen();
            } else {
              return const MainScreen();
            }
          }
        },
      ),
    );
  }
}
