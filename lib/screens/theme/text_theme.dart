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
  static const UpcomingIssueStandard = TextStyle(
    color: Colors.black,
    fontSize: 34,
    fontFamily: 'Noto Sans KR',
    fontWeight: FontWeight.w700,
    height: 1,
  );
  static const UpcomingIssueHighlight = TextStyle(
    color: Color(0xFFD966BB),
    fontSize: 34,
    fontFamily: 'Noto Sans KR',
    fontWeight: FontWeight.w900,
    height: 1,
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
  static const SplashScreenMain = TextStyle(
    color: Colors.white,
    fontSize: 48,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    height: -0.4,
    letterSpacing: -0.4,
  );
  static const LoginMainText1 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    fontSize: 48,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const LoginMainText2 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const LoginHintText = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const LoginStateMaintain = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.2,
    color: Color(0xFFD6D6D6),
    letterSpacing: -0.4,
  );
  static const QuestionNoAccount1 = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.2,
    color: Color(0xFFD6D6D6),
    letterSpacing: -0.4,
  );
  static const QuestionNoAccount2 = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.2,
    color: Color(0xFFB586F6),
    letterSpacing: -0.4,
  );
  static const MainWidgetTitle = TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.2,
    color: Colors.white,
    letterSpacing: 0,
  );
  static const MainWidgetContext = TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 2,
    color: Colors.white,
    letterSpacing: 0,
  );
  static const MainMainText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    fontSize: 48,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const SearchingText = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const KeyboardNumber = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w100,
    fontSize: 20,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const FingerPrintLoginDescription = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const CardTitle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static final CardFirstStandard = TextStyle(
    color: Colors.white.withOpacity(0.7),
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static const CardFirstHighlight = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static final CardSecondStandard = TextStyle(
    color: Colors.white.withOpacity(0.7),
    fontSize: 16,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static const CardSecondHighlight = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
}
