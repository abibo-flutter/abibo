import 'package:flutter/material.dart';

class PlatformCard extends StatefulWidget {
  const PlatformCard({
    Key? key,
    required this.name,
    required this.obj,
  }) : super(key: key);

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
      child: Column(
        children: [
          const Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('PLATFORM'),
                const VerticalDivider(),
                Text(widget.name),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text(widget.obj['id']),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text(widget.obj['password']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.name,
    required this.obj,
  }) : super(key: key);

  final String name;
  final dynamic obj;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          const Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('SUBSCRIPTION'),
                const VerticalDivider(),
                Text(widget.name),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text(widget.obj['id']),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text(widget.obj['password']),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text('${widget.obj['endDate']}'),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            child: Column(
              children: [
                Text('${widget.obj['cost']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemoCard extends StatefulWidget {
  const MemoCard({
    Key? key,
    required this.name,
    required this.text,
  }) : super(key: key);

  final String name;
  final String text;

  @override
  State<MemoCard> createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('MEMO'),
            Text(widget.name),
          ],
        ),
        const Divider(),
        Text(widget.text),
      ],
    );
  }
}
