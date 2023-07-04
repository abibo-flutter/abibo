import 'package:flutter/material.dart';
import 'package:abibo/widgets/dialog.dart';
import 'package:get/get.dart';

class Platforms extends StatefulWidget {
  const Platforms({Key? key}) : super(key: key);

  @override
  State<Platforms> createState() => _PlatformsState();
}

class _PlatformsState extends State<Platforms> {
  @override
  void initState() {
    super.initState();
  }

  void _showPlatformAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.white,
          ),
          child: const RegisterDialog(),
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
                      Get.back();
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
