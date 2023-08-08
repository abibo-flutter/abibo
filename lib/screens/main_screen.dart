import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/setting_screen.dart';
import 'package:abibo/screens/theme/color_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/home_screen.dart';
import 'package:abibo/screens/searching_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _MainScreenState extends State<MainScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF6B19DC),
            ),
            child: const TabBarView(
              children: [
                SearchScreen(),
                HomeScreen(),
                SettingScreen(),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: SizedBox(
            height: screenHeight / 844 * 62,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth / 390 * 92,
                  right: screenWidth / 390 * 92,
                  top: screenHeight / 844 * 2),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 32,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.menu_sharp,
                      size: 32,
                    ),
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: ABColors.MAIN_THEME,
                indicatorWeight: 3,
                labelColor: ABColors.MAIN_THEME,
                unselectedLabelColor: Color.fromARGB(255, 142, 142, 142),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
