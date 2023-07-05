import 'package:abibo/functions/control_memo.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  bool isPlatform = true;
  bool isSubscription = false;
  bool isMemo = false;
  String? name;
  String? id;
  String? password;
  String? text;
  int? endDate;
  int? cost;

  Future<void> removePlatform({
    required String platform,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('platform-$platform');
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
          TextField(
            onChanged: (value) {
              setState(() {
                name = value.toLowerCase().removeAllWhitespace;
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
                  id = value.removeAllWhitespace;
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
                  password = value.removeAllWhitespace;
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
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black)),
          child: const Text("Delete"),
          onPressed: () async {
            if (name != null) {
              await removePlatform(platform: name!);
            }
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
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
                endDate: endDate!,
                cost: cost!,
              );
            } else if (isPlatform && id != null && password != null) {
              await setPlatform(
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
