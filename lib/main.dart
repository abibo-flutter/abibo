import 'package:abibo/functions/notification.dart';
import 'screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/pin_screen.dart';
import 'screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplashScreen = true;
  double textScaleFactor = 0.85;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await initNotification();
    await Future.delayed(
        const Duration(milliseconds: 2000)); // splash screen이 표시될 시간(초)
    setState(() {
      _showSplashScreen = false;
    });
  }

  Future<String?> getPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? PIN = prefs.getString('PIN');
    return PIN;
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).viewInsets.bottom;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF6B19DC),
      statusBarIconBrightness: Brightness.light,
    ));
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        body: _showSplashScreen
            ? const Scaffold(body: SplashScreen())
            : FutureBuilder(
                future: getPIN(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  } else {
                    if (snapshot.hasData) {
                      return const PINScreen();
                    } else {
                      return const MainScreen();
                    }
                  }
                },
              ),
      ),
    );
  }
}
