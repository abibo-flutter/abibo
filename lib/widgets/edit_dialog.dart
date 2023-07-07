import 'package:abibo/functions/control_memo.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  final String type;
  final String name;
  final dynamic obj;
  final Function change;
  const EditDialog({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String? id;
  String? password;
  String? text;
  int? endDate;
  int? cost;

  bool isPlatform = false;
  bool isSubscription = false;
  bool isMemo = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'platform') isPlatform = true;
    if (widget.type == 'subscription') isSubscription = true;
    if (widget.type == 'memo') isMemo = true;
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
          Text(widget.name),
          const SizedBox(
            height: 10,
          ),
          if (isPlatform || isSubscription)
            TextField(
              onChanged: (value) {
                setState(() {
                  id = value.replaceAll(RegExp(r'\s'), '');
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
                  password = value.replaceAll(RegExp(r'\s'), '');
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
            if (isPlatform) {
              await removePlatform(
                platform: widget.name,
                obj: widget.obj,
              );
            } else if (isSubscription) {
              await removeSubscription(
                serviceName: widget.name,
                obj: widget.obj,
              );
            } else if (isMemo) {
              await removeMemo(
                title: widget.name,
              );
            }
            await widget.change();
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
            if (isMemo && text != null) {
              await updateMemo(
                title: widget.name,
                memo: text!,
              );
            } else if (isSubscription &&
                id != null &&
                password != null &&
                endDate != null &&
                cost != null) {
              await updateSubscription(
                serviceName: widget.name,
                obj: widget.obj,
                newObj: {
                  'id': id,
                  'password': password,
                  'endDate': endDate,
                  'cost': cost,
                },
              );
            } else if (isPlatform && id != null && password != null) {
              await updatePlatform(
                platform: widget.name,
                obj: widget.obj,
                newObj: {
                  'id': id!,
                  'password': password!,
                },
              );
            }
            await widget.change();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
