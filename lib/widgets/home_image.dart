import 'package:flutter/material.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          color: Colors.white,
          width: 100,
          height: 24,
        ),
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              iconSize: 26,
              color: Colors.white,
              onPressed: () {
                // 왼쪽 아이콘을 눌렀을 때 수행할 동작
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            iconSize: 26,
            color: Colors.white,
            onPressed: () {
              // 오른쪽 아이콘을 눌렀을 때 수행할 동작
            },
          ),
        ],
      ),
    );
  }
}
