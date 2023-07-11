import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _SettingScreenState extends State<SettingScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight / 844 * 78,
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
          SizedBox(
            height: screenHeight / 844 * 54,
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text(
                    'set pin',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    prefs = await SharedPreferences.getInstance();
                    PIN = prefs.getString('PIN');
                    if (PIN != null) {
                      navigateToChangePINScreen();
                    } else {
                      navigateToInitPINScreen();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
