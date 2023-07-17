import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
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

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchButton(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _switchValue = !_switchValue;
        });
        widget.onChanged(_switchValue);
      },
      child: Container(
        width: 52.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: _switchValue ? Colors.blue : Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 2.0,
            bottom: 2.0,
            right: 2.0,
            left: 2.0,
          ),
          child: Container(
            alignment: _switchValue
                ? ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerRight
                    : Alignment.centerLeft)
                : ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerLeft
                    : Alignment.centerRight),
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
