import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/theme/color_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const SplashScreen(),
    );
  }
}
