import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/main_container.dart';
import 'package:abibo/widgets/add_new_info.dart';
import 'package:abibo/widgets/bottomnavibar.dart';

class MainScreen extends StatefulWidget {
  final User user; // user 매개변수 추가
  const MainScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight / 844 * 513,
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/main_screen.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.account_circle_outlined),
                          iconSize: 25,
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 10),
                          onPressed: () {},
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/images/logo.png',
                          color: Colors.white,
                          width: 100,
                          height: 24,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          iconSize: 26,
                          color: Colors.white,
                          padding: const EdgeInsets.only(right: 10),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 5,
                        right: 5,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB).withOpacity(0.9),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            )),
                        height: 30,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  '플랫폼',
                                  style: ABTextTheme.MenuBar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                              child: Opacity(
                                opacity: 0.3,
                                child: VerticalDivider(
                                  color: Color(0xFF000000),
                                  thickness: 1.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'OTT',
                                  style: ABTextTheme.MenuBar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                              child: Opacity(
                                opacity: 0.3,
                                child: VerticalDivider(
                                  color: Color(0xFF000000),
                                  thickness: 1.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  '보증서',
                                  style: ABTextTheme.MenuBar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                              child: Opacity(
                                opacity: 0.3,
                                child: VerticalDivider(
                                  color: Color(0xFF000000),
                                  thickness: 1.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  '메모',
                                  style: ABTextTheme.MenuBar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '아비보',
                                style: ABTextTheme.Introducing1,
                              ),
                              Text(
                                '를 통해',
                                style: ABTextTheme.Introducing2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                '중요한 정보',
                                style: ABTextTheme.Introducing1,
                              ),
                              Text(
                                '들을',
                                style: ABTextTheme.Introducing2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                '빠르게',
                                style: ABTextTheme.Introducing1,
                              ),
                              Text(
                                ' 정리 해보세요',
                                style: ABTextTheme.Introducing2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, right: 0),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(243, 243, 243, 0.3),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_alarms_rounded,
                        size: 11,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '다가오는 이슈',
                        style: ABTextTheme.UpcomingIssue,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: Colors.black.withOpacity(0.8),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: MainContainer(),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: AddNewInfo(),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
