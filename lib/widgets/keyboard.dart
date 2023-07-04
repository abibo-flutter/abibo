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
                right: true,
              )
            : (i == 9)
                ? KeyBoardKey(
                    value: '${shuffled[i]}',
                    controller: widget.controller,
                    bottom: true,
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
          right: true,
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
        children: keys,
      ),
    );
  }
}

class KeyBoardKey extends StatefulWidget {
  final String value;
  final TextEditingController controller;
  final bool right;
  final bool bottom;
  const KeyBoardKey({
    Key? key,
    required this.value,
    required this.controller,
    this.right = false,
    this.bottom = false,
  }) : super(key: key);

  @override
  State<KeyBoardKey> createState() => _KeyBoardKeyState();
}

class _KeyBoardKeyState extends State<KeyBoardKey> {
  bool a = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          left: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          bottom: (widget.bottom)
              ? const BorderSide(
                  width: 1,
                  color: Colors.white,
                )
              : BorderSide.none,
          right: (widget.right)
              ? const BorderSide(
                  width: 1,
                  color: Colors.white,
                )
              : BorderSide.none,
        ),
      ),
      child: Material(
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
              child: Text(widget.value, style: ABTextTheme.KeyboardNumber),
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
  final bool right;

  const KeyBoardAction({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.child,
    this.right = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          bottom: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          left: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
          right: (right)
              ? const BorderSide(
                  width: 1,
                  color: Colors.white,
                )
              : BorderSide.none,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(child: child),
        ),
      ),
    );
  }
}
