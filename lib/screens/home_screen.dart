import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/register_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/widgets/platforms.dart';
import 'package:abibo/widgets/subservices.dart';
import 'package:abibo/widgets/guarantees.dart';

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
  String selected = "platform";

  void select(type) {
    setState(() {
      selected = type;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
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
                          heroTag: 'notification',
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
                          heroTag: 'searching',
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
                  const Text('NETFLIX',
                      style: ABTextTheme.UpcomingIssueStandard),
                  Row(
                    children: [
                      const Text('54',
                          style: ABTextTheme.UpcomingIssueHighlight),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenWidth / 390 * 6,
                        width: screenWidth / 390 * 6,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color(0xFF9E96D4),
                        ),
                      ),
                      SizedBox(width: screenWidth / 390 * 7),
                      Container(
                        height: screenWidth / 390 * 6,
                        width: screenWidth / 390 * 6,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: screenWidth / 390 * 7),
                      Container(
                        height: screenWidth / 390 * 6,
                        width: screenWidth / 390 * 6,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: screenWidth / 390 * 7),
                      Container(
                        height: screenWidth / 390 * 6,
                        width: screenWidth / 390 * 6,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 844 * 27,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight / 844 * 20,
                    left: screenWidth / 390 * 29,
                    right: screenWidth / 390 * 29,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth / 390 * 100,
                            height: screenHeight / 844 * 34,
                            decoration: BoxDecoration(
                              color: (selected == 'subscription')
                                  ? const Color(0xFF6B19DC)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (selected == 'subscription')
                                    ? const Color(0xFF561CA7)
                                    : const Color(0xFF818181),
                                width: 0.5,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () => select("subscription"),
                              child: Center(
                                child: Text(
                                  '구독 서비스',
                                  style: TextStyle(
                                    color: (selected == 'subscription')
                                        ? Colors.white
                                        : const Color(0xFF818181),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 390 * 13,
                          ),
                          Container(
                            width: screenWidth / 390 * 100,
                            height: screenHeight / 844 * 34,
                            decoration: BoxDecoration(
                              color: (selected == 'platform')
                                  ? const Color(0xFF6B19DC)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (selected == 'platform')
                                    ? const Color(0xFF561CA7)
                                    : const Color(0xFF818181),
                                width: 0.5,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () => select("platform"),
                              child: Center(
                                child: Text(
                                  '플랫폼',
                                  style: TextStyle(
                                    color: (selected == 'platform')
                                        ? Colors.white
                                        : const Color(0xFF818181),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 390 * 13,
                          ),
                          Container(
                            width: screenWidth / 390 * 100,
                            height: screenHeight / 844 * 34,
                            decoration: BoxDecoration(
                              color: (selected == 'guarantee')
                                  ? const Color(0xFF6B19DC)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (selected == 'guarantee')
                                    ? const Color(0xFF561CA7)
                                    : const Color(0xFF818181),
                                width: 0.5,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () => select("guarantee"),
                              child: Center(
                                child: Text(
                                  '보증서',
                                  style: TextStyle(
                                    color: (selected == 'guarantee')
                                        ? Colors.white
                                        : const Color(0xFF818181),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 844 * 16,
                      ),
                      if (selected == 'subscription') const SubServices(),
                      if (selected == 'platform') const Platforms(),
                      if (selected == 'guarantee') const Guarantees(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight / 844 * 17,
                horizontal: screenWidth / 390 * 24,
              ),
              child: FloatingActionButton(
                heroTag: 'add_info',
                onPressed: () => Get.to(const RegisterInfoScreen()),
                elevation: 0,
                backgroundColor: const Color(0xFF6B19DC),
                foregroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
