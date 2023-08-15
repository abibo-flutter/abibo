import 'package:flutter/material.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchButton(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _switchValue = !_switchValue;
        });
        widget.onChanged(_switchValue);
      },
      child: Container(
        width: 52.0,
        height: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color:
              _switchValue ? const Color(0xFFDABFFF) : const Color(0xFFD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 2.0,
            bottom: 2.0,
            right: 2.0,
            left: 2.0,
          ),
          child: Container(
            alignment: _switchValue
                ? ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerRight
                    : Alignment.centerLeft)
                : ((Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.centerLeft
                    : Alignment.centerRight),
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _switchValue
                    ? const Color(0xFF6B19DD)
                    : const Color(0xFF707070),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
