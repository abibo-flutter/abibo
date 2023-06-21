import 'package:flutter/material.dart';

class KeyBoard extends StatefulWidget {
  final TextEditingController controller;
  const KeyBoard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> keys = [
      KeyBoardKey(value: '0', controller: widget.controller),
      KeyBoardKey(value: '1', controller: widget.controller),
      KeyBoardKey(value: '2', controller: widget.controller),
      KeyBoardKey(value: '3', controller: widget.controller),
      KeyBoardKey(value: '4', controller: widget.controller),
      KeyBoardKey(value: '5', controller: widget.controller),
      KeyBoardKey(value: '6', controller: widget.controller),
      KeyBoardKey(value: '7', controller: widget.controller),
      KeyBoardKey(value: '8', controller: widget.controller),
      KeyBoardKey(value: '9', controller: widget.controller),
    ]
      ..shuffle()
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
            child: const Center(
                child: Icon(
              Icons.backspace_outlined,
            )),
          ))
      ..insert(
          11,
          KeyBoardAction(
            controller: widget.controller,
            onTap: () {
              setState(() {});
            },
            child: const Center(
                child: Icon(
              Icons.keyboard_return,
            )),
          ));

    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 2.3,
      children: keys,
    );
  }
}

class KeyBoardKey extends StatelessWidget {
  final String value;
  final TextEditingController controller;
  const KeyBoardKey({
    Key? key,
    required this.value,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (controller.text.length < 6) {
            controller.text += value;
          }
        },
        child: Ink(
          color: Colors.transparent,
          child: Center(
            child: Text(
              value,
              textScaleFactor: 2,
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
      child: InkWell(
        onTap: onTap,
        child: Ink(child: child),
      ),
    );
  }
}
