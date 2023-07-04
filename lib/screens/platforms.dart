import 'package:abibo/screens/home_screen.dart';
import 'package:abibo/screens/init_pin_screen.dart';
import 'package:abibo/screens/change_pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/mainmenucard.dart';
import 'package:get/get.dart';

class Platforms extends StatefulWidget {
  const Platforms({Key? key}) : super(key: key);

  @override
  State<Platforms> createState() => _PlatformsState();
}

void navigateToInitPINScreen() {
  Get.to(() => const InitPINScreen());
}

void navigateToChangePINScreen() {
  Get.to(() => const ChangePINScreen());
}

class _PlatformsState extends State<Platforms> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  void _showPlatformAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.white,
          ),
          child: AlertDialog(
            title: const Text(
              "Add Todo",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      //  title = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type Title",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    // 입력중 text color
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      //  description = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type description",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    // 입력중 text color
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text("Ok"),
                onPressed: () {
                  //setState(() {
                  // todos.insert(0, {
                  //'title': title,
                  // 'description': description,
                  // 'completed': false, // 'completed' 값을 false로 초기화
                  // });
                  //});
                  // 다이얼로그 닫기
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
              left: screenHeight / 844 * 30,
              right: screenHeight / 844 * 30,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth / 390 * 300,
                  height: screenHeight / 844 * 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: _showPlatformAddDialog,
                    child: const Row(
                      children: [
                        // Icon(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to((const HomeScreen()));
                    },
                    child: const Text('돌아가기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
