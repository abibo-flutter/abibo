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
import 'package:abibo/screens/subservices.dart';
import 'package:abibo/screens/memos.dart';

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

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight / 844 * 78,
          bottom: 0,
          left: screenWidth / 390 * 28,
          right: screenWidth / 390 * 28,
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
              height: screenHeight / 844 * 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 4),
              child: Container(
                height: screenHeight / 844 * 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth / 390 * 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NETFLIX',
                                style: ABTextTheme.UpcomingIssueStandard),
                            Row(
                              children: [
                                Text('54',
                                    style: ABTextTheme.UpcomingIssueHighlight),
                                Text(
                                  '일 남았어요!',
                                  style: ABTextTheme.UpcomingIssueStandard,
                                )
                              ],
                            ),
                          ],
                        ),
                        //SizedBox(width: screenWidth / 390 * 60),
                        const Spacer(),
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.chevron_right_sharp,
                              color: Colors.black,
                              size: 45,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 844 * 100,
            ),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth / 390 * 320,
                      height: screenHeight / 844 * 116,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const Platforms());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        child: const Text('플랫폼',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 30,
                    ),
                    SizedBox(
                      width: screenWidth / 390 * 320,
                      height: screenHeight / 844 * 116,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const SubServices());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        child: const Text('구독서비스',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 30,
                    ),
                    SizedBox(
                      width: screenWidth / 390 * 320,
                      height: screenHeight / 844 * 116,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const Platforms());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        child: const Text('보증서',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 30,
                    ),
                    SizedBox(
                      width: screenWidth / 390 * 320,
                      height: screenHeight / 844 * 116,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const Memos());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        child: const Text('메모',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 100),
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
      ),
    );
  }
}
