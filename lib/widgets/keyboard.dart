import 'package:abibo/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:abibo/widgets/custom_text.dart';

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
        KeyBoardKey(
          vertex: (i == 0)
              ? 0
              : (i == 2)
                  ? 1
                  : null,
          value: '${shuffled[i]}',
          controller: widget.controller,
        ),
    ]
      ..insert(
        9,
        KeyBoardAction(
          vertex: 2,
          controller: widget.controller,
          onTap: () {
            String text = widget.controller.text;
            if (text.isNotEmpty) {
              widget.controller.text = text.substring(0, text.length - 1);
            }
            setState(() {});
          },
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ),
      )
      ..insert(
        11,
        KeyBoardAction(
          vertex: 3,
          controller: widget.controller,
          onTap: () {
            widget.enterFunc();
          },
          child: const Center(
            child: Icon(
              Icons.backspace_outlined,
              color: Colors.black,
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth / 390 * 335;
    double height = screenHeight / 844 * 250;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF828282), width: 1),
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF828282),
      ),
      width: width,
      height: height,
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: width / height * 4 / 3,
        children: List.generate(keys.length, (index) {
          Widget key = keys[index];
          key = Container(
            decoration: BoxDecoration(
              border: Border(
                top: index < 3
                    ? BorderSide.none
                    : const BorderSide(color: Color(0xFF828282), width: 1),
                left: index % 3 == 0
                    ? BorderSide.none
                    : const BorderSide(color: Color(0xFF828282), width: 1),
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
  final int? vertex;
  const KeyBoardKey({
    Key? key,
    required this.value,
    required this.controller,
    this.vertex,
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: (widget.vertex == 0)
                  ? const Radius.circular(15)
                  : Radius.zero,
              topRight: (widget.vertex == 1)
                  ? const Radius.circular(15)
                  : Radius.zero,
            ),
          ),
          child: Center(
            child: CustomText(
              text: widget.value,
              style: ABTextTheme.KeyboardNumber,
            ),
          ),
        ),
      ),
    );
  }
}

class KeyBoardAction extends StatefulWidget {
  final void Function() onTap;
  final TextEditingController controller;
  final Widget child;
  final int? vertex;

  const KeyBoardAction({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.child,
    this.vertex,
  }) : super(key: key);

  @override
  State<KeyBoardAction> createState() => _KeyBoardActionState();
}

class _KeyBoardActionState extends State<KeyBoardAction> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: (widget.vertex == 2)
                  ? const Radius.circular(15)
                  : Radius.zero,
              bottomRight: (widget.vertex == 3)
                  ? const Radius.circular(15)
                  : Radius.zero,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
