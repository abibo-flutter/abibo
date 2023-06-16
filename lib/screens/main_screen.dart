import 'dart:ui';

import 'package:abibo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/mainmenucard.dart';
import 'package:abibo/widgets/drawerheader.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

void navigateToLoginScreen() {
  Get.to(() => const LoginScreen());
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  late User user;

  void getCurrentUser() {
    try {
      user = _authentication.currentUser!; //로그인 정보 받아오기
    } catch (err) {
      print(err); //실패하면 오류 출력
    }
  }

  void logOut() async {
    await _authentication.signOut();
    getCurrentUser();
    navigateToLoginScreen();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawerScrimColor: Colors.transparent,
      endDrawer: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Drawer(
            backgroundColor: Colors.transparent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CustomUserAccountDrawerHeader(user: user),
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
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context); // Drawer를 닫습니다.
                    logOut();
                  },
                ),
              ],
            ),
          ),
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
              left: screenHeight / 844 * 23,
              right: screenHeight / 844 * 23,
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
                        const MainMenu(
                          color: Color(0xFFC87CFF),
                          image: 'assets/images/mainmenu1.png',
                          headline: '플랫폼',
                          text: '여기다가 아무거나\n적을거고 이거는\n진짜 아무거나이니까\n나중에 바꾸자',
                          topLeft: false,
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 6,
                        ),
                        const MainMenu(
                          color: Color(0xFF6153D1),
                          image: 'assets/images/mainmenu2.png',
                          headline: 'OTT',
                          text:
                              '사용하고 있는 \nOTT 서비스의 아이디와 가입일을\n 입력하고 보다 쉽게 해지일을\n확인하세요!',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MainMenu(
                          color: Color(0xFF0A033C),
                          image: 'assets/images/mainmenu3.png',
                          headline: '보증서',
                          text: '사실 이만큼 안써도 되고\n그냥 적당히 한두줄만\n써도 됨!',
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 6,
                        ),
                        const MainMenu(
                          color: Color(0xFF7443D3),
                          image: 'assets/images/mainmenu4.png',
                          headline: '메모',
                          text: '여기다가는 그냥 대충\n기능 간단하게 소개할 \n수 있는 문구 넣으면 \n좋을듯',
                          bottomRight: false,
                        ),
                      ],
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
