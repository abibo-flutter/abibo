import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/widgets/custon_switch_button.dart';
// import 'package:abibo/screens/notice_period_screen.dart';
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

// void navigateToNoticePeriodScreen() {
//   Get.to(() => const NoticePeriodScreen());
// }

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
    bool enable = false;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight / 844 * 78,
        bottom: 0,
        left: screenHeight / 844 * 26,
        right: screenHeight / 844 * 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Abibo',
              style: ABTextTheme.MainMainText,
            ),
          ),
          SizedBox(
            height: screenHeight / 844 * 20,
          ),
          const Text(
            '전체알림',
            style: ABTextTheme.CardTitle,
          ),
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
          // const ElevatedButton(
          //   onPressed: navigateToNoticePeriodScreen,
          //   child: Text(
          //     'set notice period',
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          Row(
            children: [
              const Text('ON', style: ABTextTheme.CardTitle),
              const SizedBox(width: 5),
              CustomSwitchButton(
                value: enable,
                onChanged: (bool val) {
                  setState(() {
                    enable = val;
                  });
                },
              ),
              const SizedBox(width: 5),
              const Text('OFF', style: ABTextTheme.CardTitle),
            ],
          ),
          const Text(
            '전체알림',
            style: ABTextTheme.CardTitle,
          ),
        ],
      ),
    );
  }
}
