import 'package:flutter/material.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/functions/control_memo.dart';
import 'package:get/get.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({Key? key}) : super(key: key);

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  List<bool> isSelected = [true, false, false];
  bool isPlatform = true;
  bool isSubscription = false;
  bool isMemo = false;
  String? name;
  String? id;
  String? password;
  String? text;
  int? endDate;
  int? cost;

  void toggleSelect(index) {
    isSelected = [false, false, false];
    isSelected[index] = true;
    setState(() {
      isSelected = isSelected;
      isPlatform = isSelected[0];
      isSubscription = isSelected[1];
      isMemo = isSelected[2];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add Todo",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleButtons(
            selectedBorderColor: Colors.blueAccent,
            isSelected: isSelected,
            onPressed: toggleSelect,
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
                  child: Center(child: Text('메모')),
                ),
              ),
            ],
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            decoration: InputDecoration(
              hintText: "${(isMemo) ? '제목' : '서비스 이름'}을 입력하세요",
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
          if (isPlatform || isSubscription)
            TextField(
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
              decoration: InputDecoration(
                hintText: "아이디를 입력하세요",
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
          if (isPlatform || isSubscription)
            const SizedBox(
              height: 10,
            ),
          if (isPlatform || isSubscription)
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: "비밀번호를 입력하세요",
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
          if (isPlatform || isSubscription)
            const SizedBox(
              height: 10,
            ),
          if (isSubscription)
            TextField(
              onChanged: (value) {
                setState(() {
                  endDate = int.tryParse(value);
                });
              },
              decoration: InputDecoration(
                hintText: "만료일을 입력하세요",
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
          if (isSubscription)
            const SizedBox(
              height: 10,
            ),
          if (isMemo)
            const SizedBox(
              height: 10,
            ),
          if (isMemo)
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
                  color: Colors.black.withOpacity(0.6),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
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
          if (isMemo)
            const SizedBox(
              height: 10,
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
            if (name == null) return;
            if (isMemo && text != null) {
              setMemo(
                title: name!,
                memo: text!,
              );
            } else if (isSubscription &&
                id != null &&
                password != null &&
                endDate != null &&
                cost != null) {
              setSubscription(
                serviceName: name!,
                id: id!,
                password: password!,
                endDate: endDate!,
                cost: cost!,
              );
            } else if (isPlatform && id != null && password != null) {
              setPlatform(
                platform: name!,
                id: id!,
                password: password!,
              );
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
