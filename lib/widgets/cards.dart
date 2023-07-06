import 'package:flutter/material.dart';
import 'edit_dialog.dart';

void _showInfoDialog(context, widget) {
  showDialog(
    context: context,
    builder: (context) {
      return EditDialog(
        type: widget.type,
        name: widget.name,
        obj: widget.obj,
        change: widget.change,
      );
    },
  );
}

class PlatformCard extends StatefulWidget {
  const PlatformCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'platform';

  @override
  State<PlatformCard> createState() => _PlatformCardState();
}

class _PlatformCardState extends State<PlatformCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInfoDialog(context, widget),
      child: Container(
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
      ),
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'subscription';

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInfoDialog(context, widget),
      child: Container(
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
      ),
    );
  }
}

class MemoCard extends StatefulWidget {
  const MemoCard({
    Key? key,
    required this.name,
    required this.text,
    required this.change,
  }) : super(key: key);

  final String name;
  final String text;
  final dynamic obj = 0;
  final Function change;
  final String type = 'memo';

  @override
  State<MemoCard> createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInfoDialog(context, widget),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
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
        ),
      ),
    );
  }
}
