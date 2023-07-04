import 'package:flutter/material.dart';
import 'package:abibo/functions/control_all.dart';

class PlatformCard extends StatefulWidget {
  const PlatformCard({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  final String type;
  final String name;

  @override
  State<PlatformCard> createState() => _PlatformCardState();
}

class _PlatformCardState extends State<PlatformCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAny(type: widget.type, name: widget.name),
      builder: (context, snapshot) {
        return const SizedBox();
      },
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  final String type;
  final String name;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAny(type: widget.type, name: widget.name),
      builder: (context, snapshot) {
        return const SizedBox();
      },
    );
  }
}

class MemoCard extends StatefulWidget {
  const MemoCard({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  final String type;
  final String name;

  @override
  State<MemoCard> createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAny(type: widget.type, name: widget.name),
      builder: (context, snapshot) {
        return const SizedBox();
      },
    );
  }
}
