import 'package:abibo/functions/control_guarantee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/control_memo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterInfoScreen extends StatefulWidget {
  const RegisterInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  late SharedPreferences prefs;
  List<bool> isSelected = [true, false, false, false];
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
    isSelected = [false, false, false, false];
    isSelected[index] = true;
    setState(() {
      isSelected = isSelected;
      isPlatform = isSelected[0];
      isSubscription = isSelected[1];
      isGuarantee = isSelected[2];
      isMemo = isSelected[3];
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_screen.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 78,
            bottom: 0,
            left: screenHeight / 844 * 26,
            right: screenHeight / 844 * 26,
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    '정보 등록하기',
                    style: ABTextTheme.MainMainText,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 844 * 54,
              ),
              Column(
                children: [
                  ToggleButtons(
                    selectedBorderColor: Colors.white,
                    isSelected: isSelected,
                    onPressed: _toggleSelect,
                    children: const [
                      SizedBox(
                        width: 70,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('플랫폼')),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('구독')),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('보증서')),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('메모')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        name = value.toLowerCase().removeAllWhitespace;
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          "${(isMemo) ? '제목' : (isGuarantee) ? '제품명' : '서비스 이름'}을 입력하세요",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.6),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      // 입력중 text color
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (isPlatform || isSubscription)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          id = value.removeAllWhitespace;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "아이디를 입력하세요",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  if (isPlatform || isSubscription)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isPlatform || isSubscription)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value.removeAllWhitespace;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "비밀번호를 입력하세요",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  if (isGuarantee)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isGuarantee)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          brand = value.removeAllWhitespace;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "브랜드를 입력하세요",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  if (isGuarantee)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isGuarantee)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          model = value.removeAllWhitespace;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "모델명을 입력하세요",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  if (isSubscription || isGuarantee)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isSubscription || isGuarantee)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: _selectDate,
                      child: Center(
                        child: Text(
                            DateFormat('yyyy년 MM월 dd일').format(endDate ?? now)),
                      ),
                    ),
                  if (isSubscription)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isSubscription)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          cost = int.tryParse(value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "금액을 입력하세요",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  if (isMemo || isGuarantee)
                    const SizedBox(
                      height: 10,
                    ),
                  if (isMemo || isGuarantee)
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "내용을 입력하세요\n\n\n\n",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.6),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        // 입력중 text color
                        color: Colors.white,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text("Ok"),
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
                          }
                          Navigator.pop(context);
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
