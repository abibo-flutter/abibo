import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/widgets/custom_text.dart';

class RegisterInfoScreen extends StatefulWidget {
  const RegisterInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  late SharedPreferences prefs;
  bool isPlatform = true;
  bool isSubscription = false;
  bool isGuarantee = false;
  bool passwordVisible = false;
  String? name;
  String? model;
  String? brand;
  String? id;
  String? password;
  String text = '';
  DateTime? endDate;
  int? cost;
  DateTime now = DateTime.now();

  void select(type) {
    setState(() {
      isPlatform = false;
      isSubscription = false;
      isGuarantee = false;
      if (type == 'platform') isPlatform = true;
      if (type == 'subscription') isSubscription = true;
      if (type == 'guarantee') isGuarantee = true;
    });
  }

  Future<void> _selectDate() async {
    endDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 100, now.month, now.day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ABColors.MAIN_THEME,
              onPrimary: Colors.white,
              onSurface: ABColors.MAIN_THEME,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ABColors.MAIN_THEME,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 60,
              bottom: 0,
              left: screenWidth / 390 * 30,
              right: screenWidth / 390 * 30,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ABColors.MAIN_THEME,
                        size: 30,
                      ),
                    ),
                    const CustomText(
                      text: '정보 등록하기',
                      style: ABTextTheme.RegisterInfoMainText,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 844 * 34,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth / 390 * 100,
                          height: screenHeight / 844 * 34,
                          decoration: BoxDecoration(
                            color: (isSubscription)
                                ? const Color(0xFF6B19DC)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (isSubscription)
                                  ? const Color(0xFF561CA7)
                                  : const Color(0xFFD7D5D5),
                              width: 0.5,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => select("subscription"),
                            child: Center(
                              child: CustomText(
                                text: '구독 서비스',
                                style: TextStyle(
                                  color: (isSubscription)
                                      ? Colors.white
                                      : const Color(0xFF818181),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 13,
                        ),
                        Container(
                          width: screenWidth / 390 * 100,
                          height: screenHeight / 844 * 34,
                          decoration: BoxDecoration(
                            color: (isPlatform)
                                ? const Color(0xFF6B19DC)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (isPlatform)
                                  ? const Color(0xFF561CA7)
                                  : const Color(0xFFD7D5D5),
                              width: 0.5,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => select("platform"),
                            child: Center(
                              child: CustomText(
                                text: '플랫폼',
                                style: TextStyle(
                                  color: (isPlatform)
                                      ? Colors.white
                                      : const Color(0xFF818181),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 13,
                        ),
                        Container(
                          width: screenWidth / 390 * 100,
                          height: screenHeight / 844 * 34,
                          decoration: BoxDecoration(
                            color: (isGuarantee)
                                ? const Color(0xFF6B19DC)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (isGuarantee)
                                  ? const Color(0xFF561CA7)
                                  : const Color(0xFFD7D5D5),
                              width: 0.5,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => select("guarantee"),
                            child: Center(
                              child: CustomText(
                                text: '보증서',
                                style: TextStyle(
                                  color: (isGuarantee)
                                      ? Colors.white
                                      : const Color(0xFF818181),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        border: Border.all(
                          color: const Color(0xFFD6D4D4),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.5,
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        left: screenWidth / 390 * 30,
                        right: screenWidth / 390 * 30,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight / 844 * 24),
                          Row(
                            children: [
                              CustomText(
                                  text: (isGuarantee) ? '제품명' : '서비스 이름',
                                  style: ABTextTheme.RegiEachTitle),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  name =
                                      value.toLowerCase().removeAllWhitespace;
                                });
                              },
                              decoration: InputDecoration(
                                hintText:
                                    (isGuarantee) ? 'ex) TV' : 'ex) Google',
                                hintStyle: const TextStyle(
                                  color: ABColors.Regi_Hint_Color,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ABColors.Regi_Hint_Color,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ABColors.Regi_Hint_Color,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                // 입력중 text color
                                color: Color(0xFF818181),
                              ),
                            ),
                          ),
                          if (isPlatform || isSubscription)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '아이디',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        id = value.removeAllWhitespace;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "ex) id1234",
                                      hintStyle: TextStyle(
                                          color: ABColors.Regi_Hint_Color),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isPlatform || isSubscription)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '비밀번호',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        password = value.removeAllWhitespace;
                                      });
                                    },
                                    obscureText: !passwordVisible,
                                    decoration: InputDecoration(
                                      hintText: "ex) password1234",
                                      hintStyle: const TextStyle(
                                          color: ABColors.Regi_Hint_Color),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      suffix: IconButton(
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              passwordVisible =
                                                  !passwordVisible;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isGuarantee)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '브랜드',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        brand = value.removeAllWhitespace;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "ex) Samsung",
                                      hintStyle: TextStyle(
                                        color: ABColors.Regi_Hint_Color,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isGuarantee)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '모델명',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        model = value.removeAllWhitespace;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "ex) 35DF5KF-89",
                                      hintStyle: TextStyle(
                                        color: ABColors.Regi_Hint_Color,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isSubscription)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '금액',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        cost = int.tryParse(value);
                                      });
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      hintText: "ex) 15000",
                                      hintStyle: TextStyle(
                                          color: ABColors.Regi_Hint_Color),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isGuarantee)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '메모',
                                        style: ABTextTheme.RegiEachTitle),
                                  ],
                                ),
                                SizedBox(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        text = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "ex) 3년 무상수리",
                                      hintStyle: TextStyle(
                                          color: ABColors.Regi_Hint_Color),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ABColors.Regi_Hint_Color,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      // 입력중 text color
                                      color: Color(0xFF818181),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (isSubscription || isGuarantee)
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 844 * 24),
                                const Row(
                                  children: [
                                    CustomText(
                                        text: '해지일',
                                        style: ABTextTheme.RegiEachTitleRed),
                                  ],
                                ),
                                SizedBox(height: screenHeight / 844 * 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ABColors.MAIN_THEME,
                                  ),
                                  onPressed: _selectDate,
                                  child: Center(
                                    child: CustomText(
                                      text: (endDate != null)
                                          ? DateFormat('yyyy년 MM월 dd일')
                                              .format(endDate!)
                                          : "해지일을 선택하세요",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          SizedBox(height: screenHeight / 844 * 20),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight / 844 * 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            elevation: MaterialStateProperty.all(1),
                          ),
                          child: const CustomText(
                              text: "취소",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ABColors.MAIN_THEME),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: const CustomText(
                            text: "완료",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (name == null) return;
                            if (isSubscription &&
                                id != null &&
                                password != null &&
                                endDate != null &&
                                cost != null) {
                              await setSubscription(
                                serviceName: name!,
                                id: id!,
                                password: password!,
                                endDate:
                                    DateFormat("yyyy/MM/dd").format(endDate!),
                                cost: cost!,
                              );
                            } else if (isPlatform &&
                                id != null &&
                                password != null) {
                              await setPlatform(
                                platform: name!,
                                id: id!,
                                password: password!,
                              );
                            } else if (isGuarantee &&
                                brand != null &&
                                model != null &&
                                endDate != null) {
                              await setGuarantee(
                                brand: brand!,
                                productName: name!,
                                model: model!,
                                endDate:
                                    DateFormat("yyyy/MM/dd").format(endDate!),
                                note: text,
                              );
                            } else {
                              Get.snackbar(
                                '알림',
                                '오류가 발생했습니다, 다시 시도해주세요',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                              return;
                            }
                            Get.offAll(() => const MainScreen());
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
