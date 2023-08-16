import 'dart:async';
import 'dart:math';

import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/screens/register_info_screen.dart';
import 'package:abibo/screens/searching_screen.dart';
import 'package:abibo/screens/setting_screen.dart';
import 'package:abibo/screens/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/widgets/platforms.dart';
import 'package:abibo/widgets/subservices.dart';
import 'package:abibo/widgets/guarantees.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void openRegisterInfoScreen() {
  Get.to(() => const RegisterInfoScreen());
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Timer _timer;
  String selected = "platform";
  late PageController _pageController;
  int currentPage = 500;
  List<List> searching = [];

  void select(type) {
    setState(() {
      selected = type;
    });
  }

  Future<List<List>> searchInfos(BuildContext context) async {
    List<List> arr = [];
    for (List list in await getAllSubscription()) {
      arr.add(['subscription', list]);
    }

    for (List list in await getAllGuarantee()) {
      arr.add(['guarantee', list]);
    }

    if (arr.isEmpty) return [];

    arr.sort((a, b) => a[1][1]['endDate'].compareTo(b[1][1]['endDate']));

    if (context.mounted) {
      setState(() {
        searching = arr.sublist(0, min(4, arr.length));
      });
    }
    return searching;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 500);

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (searching.length < 2) return;
        setState(() {
          currentPage++;
        });
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
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
                          heroTag: 'search',
                          onPressed: () {
                            widget.controller.animateTo(0);
                          },
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6B19DC),
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 390 * 12,
                      ),
                      SizedBox(
                        width: screenWidth / 390 * 36,
                        child: FloatingActionButton(
                          heroTag: 'setting',
                          onPressed: () {
                            widget.controller.animateTo(2);
                          },
                          elevation: 0,
                          backgroundColor: ABColors.MAIN_THEME,
                          foregroundColor: Colors.white,
                          child: const Icon(
                            Icons.menu_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 844 * 33,
                  ),
                  FutureBuilder(
                      future: searchInfos(context),
                      builder: (context, snapshot) {
                        if (searching.length > 1) {
                          return SizedBox(
                            height: screenHeight / 844 * 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: screenWidth / 390 * 300,
                                  child: PageView.builder(
                                    onPageChanged: (value) {
                                      setState(() {
                                        currentPage = value;
                                      });
                                    },
                                    controller: _pageController,
                                    itemCount: (searching.isEmpty) ? 501 : null,
                                    itemBuilder: (context, index) {
                                      int i = (index - 500) % searching.length;
                                      return NoticeTab(
                                        empty: false,
                                        type: searching[i][0],
                                        obj: searching[i][1],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (searching.isEmpty) {
                          return const NoticeTab(empty: true);
                        }
                        return SizedBox(
                          height: screenHeight / 844 * 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              NoticeTab(
                                empty: false,
                                type: searching[0][0],
                                obj: searching[0][1],
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
                        );
                      }),
                  SizedBox(
                    height: screenHeight / 844 * 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < searching.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 390 * 3.5),
                          child: Container(
                            height: screenWidth / 390 * 6,
                            width: screenWidth / 390 * 6,
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color:
                                  ((currentPage - 500) % searching.length == i)
                                      ? const Color(0xFF9E96D4)
                                      : Colors.white,
                            ),
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
                      // SizedBox(
                      //   height: screenHeight / 844 * 16,
                      // ),
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
                onPressed: () {
                  openRegisterInfoScreen();
                },
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

class NoticeTab extends StatefulWidget {
  const NoticeTab({
    super.key,
    required this.empty,
    this.type,
    this.obj,
  });

  final String? type;
  final List? obj;
  final bool empty;

  @override
  State<NoticeTab> createState() => _NoticeTabState();
}

class _NoticeTabState extends State<NoticeTab> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (widget.empty) {
      return const Padding(
        padding: EdgeInsets.only(right: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('정보를\n입력하세요', style: ABTextTheme.UpcomingIssueStandard),
          ],
        ),
      );
    }
    DateTime endDate =
        DateTime.parse(widget.obj![1]['endDate'].replaceAll('/', '-'));
    DateTime today = DateTime.now();
    today = DateTime(
      today.year,
      today.month,
      today.day,
      0,
      0,
    );
    int difference = endDate.difference(today).inDays;

    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (widget.type == 'subscription') ? '구독 서비스' : '보증서',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: screenHeight / 390 * 11,
          ),
          Text(
              (widget.type == 'subscription')
                  ? widget.obj![0]
                  : widget.obj![1]['name'],
              style: ABTextTheme.UpcomingIssueStandard),
          const SizedBox(
            height: 10,
          ),
          if (difference != 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$difference',
                  style: ABTextTheme.UpcomingIssueHighlight,
                ),
                const Text(
                  '일 남았어요!',
                  style: ABTextTheme.UpcomingIssueStandard,
                ),
              ],
            ),
          if (difference == 0)
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '해지일이에요!',
                  style: ABTextTheme.UpcomingIssueStandard,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
