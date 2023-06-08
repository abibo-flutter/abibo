import 'package:flutter/material.dart';

abstract class ABTextTheme {
  static const MenuBar = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.2,
    color: Colors.black,
    letterSpacing: -0.4,
  );
  static const Introducing1 = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const Introducing2 = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 24,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const UpcomingIssue = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.2,
    color: Color(0xFF464646),
    letterSpacing: -0.4,
  );
  static const BottomNavibarTextSelected = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 8,
    height: 1.2,
    color: Colors.black,
    letterSpacing: -0.4,
  );
  static const BottomNavibarTextUnselected = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 8,
    height: 1.2,
    color: Color(0xFF999999),
    letterSpacing: -0.4,
  );
}
