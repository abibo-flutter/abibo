import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/main_screen.dart';
import 'package:get/get.dart';

class RealMainScreen extends StatefulWidget {
  const RealMainScreen({Key? key}) : super(key: key);

  @override
  State<RealMainScreen> createState() => _RealMainScreenState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _RealMainScreenState extends State<RealMainScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: const TabBarView(
              children: [
                MainScreen(),
                Center(
                  child: Text('Searching Screen'),
                ),
                Center(
                  child: Text('Setting Screen'),
                )
              ],
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: SizedBox(
              height: screenHeight / 844 * 50,
              child: TabBar(
                tabs: const [
                  Tab(
                    icon: Icon(Icons.home_outlined),
                    text: 'HOME',
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                    text: 'SEARCH',
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: 'SETTING',
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.red,
                indicatorWeight: 2,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey[400],
                labelStyle: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
