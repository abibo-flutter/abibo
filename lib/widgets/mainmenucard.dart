import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:get/get.dart';
import 'package:abibo/widgets/platforms.dart';
import 'package:abibo/widgets/custom_text.dart';

class MainMenu extends StatelessWidget {
  final bool topRight;
  final bool topLeft;
  final bool bottomRight;
  final bool bottomLeft;
  final Color color;
  final String image;
  final String headline;
  final String text;
  const MainMenu({
    super.key,
    required this.color,
    required this.image,
    required this.headline,
    required this.text,
    this.topRight = true,
    this.topLeft = true,
    this.bottomRight = true,
    this.bottomLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Get.to(() => const Platforms());
      },
      child: Container(
        width: screenWidth / 390 * 168,
        height: screenHeight / 844 * 230,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: (topRight) ? const Radius.circular(60) : Radius.zero,
            topLeft: (topLeft) ? const Radius.circular(60) : Radius.zero,
            bottomLeft: (bottomLeft) ? const Radius.circular(60) : Radius.zero,
            bottomRight:
                (bottomRight) ? const Radius.circular(60) : Radius.zero,
          ),
          image: DecorationImage(
            image: AssetImage(image),
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
              width: screenWidth / 390 * 16,
              height: 1,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: screenHeight / 844 * 2,
            ),
            Container(
              width: screenWidth / 390 * 8,
              height: 1,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: screenHeight / 844 * 26,
            ),
            CustomText(
              text: headline,
              style: ABTextTheme.MainWidgetTitle,
            ),
            SizedBox(
              height: screenHeight / 844 * 16,
            ),
            Container(
              width: screenWidth / 396 * 22,
              height: 1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: screenHeight / 844 * 12,
            ),
            CustomText(
              text: text,
              style: ABTextTheme.MainWidgetContext,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
