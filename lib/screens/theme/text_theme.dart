import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/color_theme.dart';

abstract class ABTextTheme {
  static const MenuBar = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.2,
    color: Colors.black,
    letterSpacing: -0.4,
  );
  static const SplashMaintext = TextStyle(
    color: Colors.white,
    fontSize: 48,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    height: 1.25,
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
    color: Colors.white,
    fontSize: 28,
    fontFamily: 'Noto Sans KR',
    fontWeight: FontWeight.w700,
    height: 1.35,
  );
  static const UpcomingIssueHighlight = TextStyle(
    color: Color(0xFFFFE27B),
    fontSize: 28,
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
    height: 1.25,
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
    fontSize: 24,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const SearchTitleText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    fontSize: 34,
    height: 1.2,
    color: Colors.white,
    letterSpacing: -0.4,
  );
  static const MainMainTextPurpleVer = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    fontSize: 40,
    height: 1.2,
    color: ABColors.MAIN_THEME,
    letterSpacing: -0.4,
  );
  static const RegiEachTitle = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.2,
    color: Colors.black,
    letterSpacing: -0.4,
  );
  static const RegiEachTitleRed = TextStyle(
    color: Color(0xFFBB0000),
    fontSize: 16,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.4,
  );
  static const RegisterInfoMainText = TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.normal,
    fontSize: 32,
    height: 1.2,
    color: ABColors.MAIN_THEME,
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
  static const SettingMainText = TextStyle(
    height: 1.2,
    letterSpacing: -0.4,
    color: Color(0xFF6B19DC),
    fontSize: 28,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static const SettingMenuTitle = TextStyle(
    height: 1.2,
    letterSpacing: -0.4,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 26,
  );
  static final SearchingHintText = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.2,
    color: Colors.white.withOpacity(0.7),
    letterSpacing: -0.4,
  );
  static const KeyboardNumber = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w100,
    fontSize: 20,
    height: 1.2,
    color: Colors.black,
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
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );
  static const InitialCardTitle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );
  static final CardMidSeperate = TextStyle(
    color: Colors.black.withOpacity(0.7),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
  static final CardDescription = TextStyle(
    color: Colors.black.withOpacity(0.5),
    fontSize: 10,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w900,
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
  static const NoticePeriodTitle = TextStyle(
    color: Color(0xFF6B19DC),
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static const NoticePeriodText = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static const NoticePeriodButton = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
}
