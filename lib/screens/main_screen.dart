import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abibo/screens/theme/text_theme.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // 메뉴 항목을 선택했을 때 수행할 동작을 작성합니다.
                Navigator.pop(context); // Drawer를 닫습니다.
                // TODO: Home 화면으로 이동하는 동작을 수행합니다.
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Drawer를 닫습니다.
                // TODO: Settings 화면으로 이동하는 동작을 수행합니다.
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_screen.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 38,
              bottom: 0,
              left: screenHeight / 844 * 28,
              right: screenHeight / 844 * 28,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Builder(builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Image(
                        image: AssetImage('assets/images/button/menu.png'),
                      ),
                      iconSize: 20,
                    );
                  }),
                ),
                const Row(
                  children: [
                    Text(
                      'Abibo',
                      style: ABTextTheme.LoginMainText1,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 844 * 54,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth / 390 * 168,
                          height: screenHeight / 844 * 230,
                          decoration: const BoxDecoration(
                            color: Color(0xFFC87CFF),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/mainmenu1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: screenHeight / 844 * 12,
                              ),
                              Container(
                                width: screenWidth / 844 * 32,
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight / 844 * 2,
                              ),
                              Container(
                                width: screenWidth / 844 * 16,
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                '플랫폼',
                                style: ABTextTheme.MainWidgetTitle,
                              ),
                              SizedBox(
                                height: screenHeight / 844 * 2,
                              ),
                              Container(
                                width: screenWidth / 844 * 16,
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container()
                      ],
                    ),
                    const Row(
                      children: [],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
