import 'dart:async';
import 'package:abibo/controller.dart';
import 'package:abibo/widgets/custom_text.dart';
import 'package:abibo/screens/register_info_screen.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
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
  static final HomeScreenController _controller =
      Get.find<HomeScreenController>();
  late Timer _timer;
  String selected = "platform";
  late PageController _pageController;
  int currentPage = 0;

  void select(type) {
    setState(() {
      selected = type;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_controller.notice.length < 2) return;
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
        GetBuilder<HomeScreenController>(builder: (controller) {
          return Column(
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
                        const CustomText(
                          text: 'Abibo',
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
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
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
                    SizedBox(height: screenHeight / 844 * 6),
                    FutureBuilder(
                      future: controller.searchNotice(),
                      builder: (context, snapshot) {
                        if (controller.notice.length > 1) {
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
                                    itemBuilder: (context, index) {
                                      int i = index % controller.notice.length;
                                      return NoticeTab(
                                        empty: false,
                                        type: controller.notice[i][0],
                                        obj: controller.notice[i][1],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (controller.notice.isEmpty) {
                          return SizedBox(
                            height: screenHeight / 844 * 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: screenWidth / 390 * 300,
                                  child: PageView(
                                    controller: _pageController,
                                    children: const [NoticeTab(empty: true)],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox(
                          height: screenHeight / 844 * 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: screenWidth / 390 * 300,
                                child: PageView(
                                  controller: _pageController,
                                  children: [
                                    NoticeTab(
                                      empty: false,
                                      type: controller.notice[0][0],
                                      obj: controller.notice[0][1],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < controller.notice.length; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 390 * 3.5),
                            child: Container(
                              height: screenWidth / 390 * 6,
                              width: screenWidth / 390 * 6,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color:
                                    (currentPage % controller.notice.length ==
                                            i)
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
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth / 390 * 100,
                              height: screenHeight / 844 * 38,
                              decoration: BoxDecoration(
                                color: (selected == 'subscription')
                                    ? const Color(0xFF6B19DC)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (selected == 'subscription')
                                      ? const Color(0xFF561CA7)
                                      : const Color(0xFFD7D5D5),
                                  width: 0.5,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => select("subscription"),
                                child: Center(
                                  child: CustomText(
                                    text: '구독 서비스',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'NotoSansKR',
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
                              height: screenHeight / 844 * 38,
                              decoration: BoxDecoration(
                                color: (selected == 'platform')
                                    ? const Color(0xFF6B19DC)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (selected == 'platform')
                                      ? const Color(0xFF561CA7)
                                      : const Color(0xFFD7D5D5),
                                  width: 0.5,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => select("platform"),
                                child: Center(
                                  child: CustomText(
                                    text: '플랫폼',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'NotoSansKR',
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
                              height: screenHeight / 844 * 38,
                              decoration: BoxDecoration(
                                color: (selected == 'guarantee')
                                    ? const Color(0xFF6B19DC)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (selected == 'guarantee')
                                      ? const Color(0xFF561CA7)
                                      : const Color(0xFFD7D5D5),
                                  width: 0.5,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => select("guarantee"),
                                child: Center(
                                  child: CustomText(
                                    text: '보증서',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'NotoSansKR',
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
          );
        }),
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
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    if (widget.empty) {
      return Padding(
        padding: const EdgeInsets.only(right: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight / 844 * 21,
            ),
            const CustomText(
                text: '정보를', style: ABTextTheme.UpcomingIssueStandard),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: '입력해보세요!',
              style: ABTextTheme.UpcomingIssueStandard,
            ),
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
          CustomText(
            text: (widget.type == 'subscription') ? '구독 서비스' : '보증서',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: screenHeight / 844 * 21,
          ),
          CustomText(
              text: (widget.type == 'subscription')
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
                CustomText(
                  text: '$difference',
                  style: ABTextTheme.UpcomingIssueHighlight,
                ),
                const CustomText(
                  text: '일 남았어요!',
                  style: ABTextTheme.UpcomingIssueStandard,
                ),
              ],
            ),
          if (difference == 0)
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: '해지일이에요!',
                  style: ABTextTheme.UpcomingIssueStandard,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
