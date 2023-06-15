import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/theme/color_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
