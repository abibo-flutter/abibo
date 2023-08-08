import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/control_memo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:abibo/screens/theme/color_theme.dart';

class RegisterInfoScreen extends StatefulWidget {
  const RegisterInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  late SharedPreferences prefs;
  List<bool> isSelected = [true, false, false];
  bool isPlatform = true;
  bool isSubscription = false;
  bool isMemo = false;
  bool isGuarantee = false;
  String? name;
  String? model;
  String? brand;
  String? id;
  String? password;
  String? text;
  DateTime? endDate;
  int? cost;
  DateTime now = DateTime.now();

  void _toggleSelect(index) {
    isSelected = [false, false, false];
    isSelected[index] = true;
    setState(() {
      isSelected = isSelected;
      isPlatform = isSelected[0];
      isSubscription = isSelected[1];
      isGuarantee = isSelected[2];
      //isMemo = isSelected[3];
    });
  }

  Future<void> _selectDate() async {
    endDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 100, now.month, now.day),
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
        decoration: const BoxDecoration(color: Colors.white),
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
                  const Text(
                    '정보 등록하기',
                    style: ABTextTheme.RegisterInfoMainText,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 844 * 34,
              ),
              Column(
                children: [
                  ToggleButtons(
                    selectedBorderColor: Colors.white,
                    disabledBorderColor: Colors.white,
                    isSelected: isSelected,
                    onPressed: _toggleSelect,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(child: Text('플랫폼')),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(child: Text('구독')),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(child: Text('보증서')),
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
                            Text(
                                (isMemo)
                                    ? '제목'
                                    : (isGuarantee)
                                        ? '제품명'
                                        : '서비스 이름',
                                style: ABTextTheme.RegiEachTitle),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                name = value.toLowerCase().removeAllWhitespace;
                              });
                            },
                            decoration: InputDecoration(
                              hintText:
                                  "${(isMemo) ? '제목' : (isGuarantee) ? '제품명' : '서비스 이름'}을 입력하세요",
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
                                  Text('아이디', style: ABTextTheme.RegiEachTitle),
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
                                    hintText: "아이디를 입력하세요",
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
                                  Text('비밀번호',
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
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "비밀번호를 입력하세요",
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
                                  Text('브랜드', style: ABTextTheme.RegiEachTitle),
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
                                    hintText: "브랜드를 입력하세요",
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
                                  Text('모델명', style: ABTextTheme.RegiEachTitle),
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
                                    hintText: "모델명을 입력하세요",
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
                                  Text('금액', style: ABTextTheme.RegiEachTitle),
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
                                  decoration: const InputDecoration(
                                    hintText: "금액을 입력하세요",
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
                                  Text('해지일', style: ABTextTheme.RegiEachTitle),
                                ],
                              ),
                              SizedBox(height: screenHeight / 844 * 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ABColors.MAIN_THEME,
                                ),
                                onPressed: _selectDate,
                                child: Center(
                                  child: Text(DateFormat('yyyy년 MM월 dd일')
                                      .format(endDate ?? now)),
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
                        ),
                        child: const Text("취소"),
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
                        child: const Text("완료"),
                        onPressed: () async {
                          if (name == null) return;
                          if (isMemo && text != null) {
                            await setMemo(
                              title: name!,
                              memo: text!,
                            );
                          } else if (isSubscription &&
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
                              endDate != null &&
                              text != null) {
                            await setGuarantee(
                              brand: brand!,
                              productName: name!,
                              model: model!,
                              endDate:
                                  DateFormat("yyyy/MM/dd").format(endDate!),
                              note: text!,
                            );
                          } else {
                            return;
                          }

                          Get.offAll(const MainScreen());
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
    );
  }
}
