//NoticePeriodScreen.dart

import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/notification.dart';
import 'package:abibo/screens/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';
import 'package:abibo/screens/theme/text_theme.dart';
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
  String newPeriod = '0d';
  List<String> periods = [];
  List infos = [];

  Future<void> _loadPeriod() async {
    prefs = await SharedPreferences.getInstance();
    periods = prefs.getStringList('periods') ?? [];
  }

  Future<void> _removePeriod(value) async {
    for (List info in infos) {
      await cancelNotification(
        type: info[0],
        name: info[1],
        detail: info[2][(info[0] == 'guarantee') ? 'name' : 'id'],
        dateDiff: value,
      );
    }
    periods.remove(value);
    prefs.setStringList('periods', periods);
    setState(() {});
  }

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
    searchInfos();
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
              horizontal: screenWidth / 390 * 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 844 * 43,
                ),
                IconButton(
                  iconSize: 23,
                  color: ABColors.MAIN_THEME,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                SizedBox(
                  height: screenHeight / 844 * 11,
                ),
                const Text(
                  '알림 발송 주기를\n설정하세요',
                  style: ABTextTheme.NoticePeriodTitle,
                ),
                SizedBox(
                  height: screenHeight / 844 * 22,
                ),
                Container(
                  height: screenWidth / 390 * 43,
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
                        newPeriod = '0d';
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '당일',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (newPeriod == '0d')
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
                  height: screenWidth / 390 * 43,
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
                        newPeriod = '1d';
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '1일 전',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (newPeriod == '1d')
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
                  height: screenWidth / 390 * 43,
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
                        newPeriod = '3d';
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '3일 전',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (newPeriod == '3d')
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
                  height: screenWidth / 390 * 43,
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
                        newPeriod = '7d';
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '7일 전',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (newPeriod == '7d')
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
                  height: screenWidth / 390 * 43,
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
                        newPeriod = '1m';
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          '1개월 전',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        if (newPeriod == '1m')
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
                    periods = (prefs.getStringList("periods")) ?? [];
                    if (!periods.contains(newPeriod)) {
                      periods.add(newPeriod);
                    }
                    await prefs.setStringList("periods", periods);

                    for (var info in infos) {
                      await registerNotification(
                        type: info[0],
                        name: info[1],
                        detail: info[2]
                            [(info[0] == 'guarantee') ? 'name' : 'id'],
                        endDate: info[2]['endDate'],
                        dateDiff: newPeriod,
                      );
                    }
                    setState(() {});
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
                        '추가하기',
                        style: ABTextTheme.NoticePeriodButton,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 23,
                ),
                const Divider(
                  thickness: 1,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        height: screenHeight / 844 * 82,
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
        child: Center(
          child: Text('$text에 알림이 울립니다.'),
        ),
      ),
    );
  }
}
