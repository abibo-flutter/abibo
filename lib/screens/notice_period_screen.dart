//NoticePeriodScreen.dart

import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/notification.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:get/get.dart';

class NoticePeriodScreen extends StatefulWidget {
  const NoticePeriodScreen({super.key});

  @override
  State<NoticePeriodScreen> createState() => _NoticePeriodScreenState();
}

class _NoticePeriodScreenState extends State<NoticePeriodScreen> {
  final secureKeyboardController = SecureKeyboardController();
  final pinCodeEditor = TextEditingController();
  final textFieldFocusNode = FocusNode();
  late SharedPreferences prefs;
  Set<String> periods = {};
  List infos = [];

  Future<void> searchInfos() async {
    List<List> arr = [];
    for (List list in await getAllSubscription()) {
      arr.add(['subscription', list[0], list[1]]);
    }

    for (List list in await getAllGuarantee()) {
      arr.add(['guarantee', list[0], list[1]]);
    }
    infos = arr;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 390 * 26,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 844 * 52,
                ),
                IconButton(
                  iconSize: 23,
                  color: ABColors.MAIN_THEME,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                SizedBox(
                  height: screenHeight / 844 * 16,
                ),
                const Text(
                  '알림 발송 주기를\n설정하세요',
                  style: ABTextTheme.NoticePeriodTitle,
                ),
                SizedBox(
                  height: screenHeight / 844 * 22,
                ),
                Container(
                  height: screenWidth / 390 * 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!periods.add('0d')) {
                          periods.remove('0d');
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '당일 00:00',
                          style: ABTextTheme.NoticePeriodTimeButton,
                        ),
                        const Spacer(),
                        if (periods.contains('0d'))
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 8,
                ),
                Container(
                  height: screenWidth / 390 * 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!periods.add('1d')) {
                          periods.remove('1d');
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Text('24시간 전',
                            style: ABTextTheme.NoticePeriodTimeButton),
                        const Spacer(),
                        if (periods.contains('1d'))
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 8,
                ),
                Container(
                  height: screenWidth / 390 * 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!periods.add('3d')) {
                          periods.remove('3d');
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Text('3일 전',
                            style: ABTextTheme.NoticePeriodTimeButton),
                        const Spacer(),
                        if (periods.contains('3d'))
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 8,
                ),
                Container(
                  height: screenWidth / 390 * 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!periods.add('7d')) {
                          periods.remove('7d');
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Text('7일 전',
                            style: ABTextTheme.NoticePeriodTimeButton),
                        const Spacer(),
                        if (periods.contains('7d'))
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 8,
                ),
                Container(
                  height: screenWidth / 390 * 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!periods.add('1m')) {
                          periods.remove('1m');
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Text('한 달 전',
                            style: ABTextTheme.NoticePeriodTimeButton),
                        const Spacer(),
                        if (periods.contains('1m'))
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 23,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (periods.isEmpty) return;

                    prefs = await SharedPreferences.getInstance();
                    await prefs.setStringList(
                        "periods", periods.toList(growable: false)..sort());
                    await updatePeriod();
                    setState(() {});
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: screenWidth / 390 * 60,
                    child: const Center(
                      child: Text(
                        '설정하기',
                        style: ABTextTheme.NoticePeriodButton,
                      ),
                    ),
                  ),
                ),
                /*
                SizedBox(
                  height: screenHeight / 844 * 23,
                ),
                Divider(
                  thickness: 1,
                  color: const Color(0xffaaaaaa).withOpacity(0.3),
                ),
                SizedBox(
                  height: screenHeight / 844 * 23,
                ),
                FutureBuilder(
                  future: _loadPeriod(),
                  builder: (context, snapshot) {
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: periods.length,
                      itemBuilder: (context, index) => NoticePeriodCard(
                        change: _removePeriod,
                        period: periods[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: screenHeight / 844 * 8,
                      ),
                    );
                  },
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
class NoticePeriodCard extends StatefulWidget {
  const NoticePeriodCard(
      {super.key, required this.change, required this.period});
  final Function change;
  final String period;

  @override
  State<NoticePeriodCard> createState() => _NoticePeriodCardState();
}

class _NoticePeriodCardState extends State<NoticePeriodCard> {
  String text = '1234567';

  @override
  void initState() {
    super.initState();
    text = widget.period.substring(0, widget.period.length - 1);
    if (widget.period.endsWith('d')) {
      text += '일 전';
    } else if (widget.period.endsWith('m')) {
      text += '개월 전';
    }
    if (text == '0일 전') {
      text = '당일';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.change(widget.period);
      },
      background: Container(
        width: screenWidth / 390 * 326,
        height: screenHeight / 844 * 100,
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데//아이콘 PADDING
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: Container(
        height: screenHeight / 844 * 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight / 844 * 22),
              Text(
                '$text에 알림이 울립니다.',
              ),
              SizedBox(height: screenHeight / 844 * 20),
              Text(
                '$text에 알림이 울립니다.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
