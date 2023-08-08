import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:abibo/screens/setting_screen.dart';
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
                HomeScreen(),
                SearchScreen(),
                SettingScreen(),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: SizedBox(
            height: 0,
            child: TabBar(
              tabs: const [
                Tab(
                  icon: Icon(Icons.home_outlined),
                  text: '  HOME ',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: ' SEARCH',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'SETTING',
                ),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xFF7443D3),
              indicatorWeight: 2,
              unselectedLabelColor: Colors.grey[400],
              labelStyle: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
