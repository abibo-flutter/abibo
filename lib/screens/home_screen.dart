import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/screens/platforms.dart';
import 'package:abibo/screens/register_info_screen.dart';
import 'package:abibo/screens/subservices.dart';
import 'package:abibo/screens/memos.dart';
import 'package:abibo/screens/guarantees.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight / 844 * 35,
          bottom: 0,
          left: screenWidth / 390 * 32,
          right: screenWidth / 390 * 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Abibo',
                  style: ABTextTheme.MainMainText,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  width: screenWidth / 390 * 36,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B19DC),
                    child: const Icon(
                      Icons.notifications,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth / 390 * 12,
                ),
                SizedBox(
                  width: screenWidth / 390 * 36,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B19DC),
                    child: const Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 844 * 33,
            ),
            const Text(
              '구독 서비스',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight / 390 * 11,
            ),
            const Text('NETFLIX', style: ABTextTheme.UpcomingIssueStandard),
            Row(
              children: [
                const Text('54', style: ABTextTheme.UpcomingIssueHighlight),
                const Text(
                  '일 남았어요!',
                  style: ABTextTheme.UpcomingIssueStandard,
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 844 * 32,
            ),
            const Row(
              children: [],
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
                          Get.to(() => const Platforms());
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
                          Get.to(() => const SubServices());
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
                          Get.to(() => const Guarantees());
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
                          Get.to(() => const Memos());
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
