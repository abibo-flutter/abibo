import 'package:flutter/material.dart';

class PlatformCard extends StatefulWidget {
  const PlatformCard({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
  }) : super(key: key);

  final String type;
  final String name;
  final dynamic obj;

  @override
  State<PlatformCard> createState() => _PlatformCardState();
}

class _PlatformCardState extends State<PlatformCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: Row(),
              ),
              Divider(),
              Column(),
            ],
          ),
          Divider(),
          SizedBox(child: Column()),
          Divider(),
          SizedBox(
            child: Column(),
          ),
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
  }) : super(key: key);

  final String type;
  final String name;
  final dynamic obj;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class MemoCard extends StatefulWidget {
  const MemoCard({
    Key? key,
    required this.type,
    required this.name,
    required this.text,
  }) : super(key: key);

  final String type;
  final String name;
  final String text;

  @override
  State<MemoCard> createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}
