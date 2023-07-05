import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/screens/platforms.dart';
import 'package:abibo/widgets/register_dialog.dart';
import 'package:abibo/screens/register_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  void _showPlatformAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.white,
          ),
          child: const RegisterDialog(),
        );
      },
    );
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
          const Row(
            children: [
              Text(
                'Abibo',
                style: ABTextTheme.MainMainText,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 844 * 54,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Platforms());
                      },
                      child: const Text('플랫폼'),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 390 * 6,
                  ),
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Platforms());
                      },
                      child: const Text('OTT'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 844 * 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Platforms());
                      },
                      child: const Text('보증서'),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 390 * 6,
                  ),
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Platforms());
                      },
                      child: const Text('메모'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight / 844 * 240),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD9D9D9).withOpacity(0.3),
                      spreadRadius: 7,
                      blurRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.add,
                    size: 24,
                    color: Color(0xFFF0FF73),
                  ),
                  onPressed: () => Get.to(() => const RegisterInfoScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
