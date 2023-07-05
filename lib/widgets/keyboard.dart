import 'package:abibo/screens/theme/text_theme.dart';
import 'package:flutter/material.dart';

class KeyBoard extends StatefulWidget {
  final TextEditingController controller;
  final Function enterFunc;
  const KeyBoard({
    Key? key,
    required this.controller,
    required this.enterFunc,
  }) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  late List<Widget> keys;
  @override
  void initState() {
    super.initState();
    List shuffled = [
      for (int i = 0; i < 10; i++) i,
    ]..shuffle();
    keys = [
      for (int i = 0; i < 10; i++)
        ({2, 5, 8}.contains(i))
            ? KeyBoardKey(
                value: '${shuffled[i]}',
                controller: widget.controller,
              )
            : (i == 9)
                ? KeyBoardKey(
                    value: '${shuffled[i]}',
                    controller: widget.controller,
                  )
                : KeyBoardKey(
                    value: '${shuffled[i]}',
                    controller: widget.controller,
                  )
    ]
      ..insert(
        9,
        KeyBoardAction(
          controller: widget.controller,
          onTap: () {
            String text = widget.controller.text;
            if (text.isNotEmpty) {
              widget.controller.text = text.substring(0, text.length - 1);
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
            ),
            child: const Center(
              child: Icon(
                Icons.backspace_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
      ..insert(
        11,
        KeyBoardAction(
          controller: widget.controller,
          onTap: () {
            widget.enterFunc();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
            ),
            child: const Center(
              child: Icon(
                Icons.keyboard_return,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
      ),
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 1.8,
        children: List.generate(keys.length, (index) {
          Widget key = keys[index];
          key = Container(
            decoration: BoxDecoration(
              border: Border(
                top: index < 3
                    ? BorderSide.none
                    : const BorderSide(width: 0.5, color: Colors.white),
                left: index == 0 || index == 3 || index == 6 || index == 9
                    ? BorderSide.none
                    : const BorderSide(width: 0.5, color: Colors.white),
                bottom: index == 9 || index == 10 || index == 11
                    ? BorderSide.none
                    : const BorderSide(width: 0.5, color: Colors.white),
                right: index == 2 || index == 5 || index == 8 || index == 11
                    ? BorderSide.none
                    : const BorderSide(width: 0.5, color: Colors.white),
              ),
            ),
            child: key,
          );
          return key;
        }),
      ),
    );
  }
}

class KeyBoardKey extends StatefulWidget {
  final String value;
  final TextEditingController controller;
  const KeyBoardKey({
    Key? key,
    required this.value,
    required this.controller,
  }) : super(key: key);

  @override
  State<KeyBoardKey> createState() => _KeyBoardKeyState();
}

class _KeyBoardKeyState extends State<KeyBoardKey> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (widget.controller.text.length < 6) {
            widget.controller.text += widget.value;
          }
        },
        child: Ink(
          color: Colors.white.withOpacity(0.08),
          child: Center(
            child: Text(
              widget.value,
              style: ABTextTheme.KeyboardNumber,
            ),
          ),
        ),
      ),
    );
  }
}

class KeyBoardAction extends StatelessWidget {
  final void Function() onTap;
  final TextEditingController controller;
  final Widget child;

  const KeyBoardAction({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(child: child),
      ),
    );
  }
}
