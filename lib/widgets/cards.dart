import 'package:abibo/screens/theme/color_theme.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

void _showInfoDialog(context, widget) {
  showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        body: EditDialog(
          type: widget.type,
          name: widget.name,
          obj: widget.obj,
          change: widget.change,
        ),
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
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (setting) {
            return MaterialPageRoute(
              builder: (context) => GestureDetector(
                onTap: () {
                  _navigatorKey.currentState?.push(
                    MaterialPageRoute(
                      builder: (context) => PlatformTouchedCard(
                        name: widget.name,
                        obj: widget.obj,
                        change: widget.change,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'platformhero-${widget.name}',
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth / 390 * 326,
                        height: screenHeight / 844 * 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color(0x3FEFEFEF),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight / 844 * 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: CircleDesign.RedGradient,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text(
                                          widget.name.toUpperCase(),
                                          style: ABTextTheme.CardTitle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight / 844 * 25),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight / 844 * 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlatformTouchedCard extends StatefulWidget {
  const PlatformTouchedCard({
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
  State<PlatformTouchedCard> createState() => _PlatformTouchedCardState();
}

class _PlatformTouchedCardState extends State<PlatformTouchedCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Hero(
        tag: 'platformhero-${widget.name}',
        child: Column(
          children: [
            Container(
              width: screenWidth / 390 * 326,
              height: screenHeight / 844 * 174,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                color: Color(0x3FEFEFEF),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight / 844 * 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: CircleDesign.RedGradient,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                widget.name.toUpperCase(),
                                style: ABTextTheme.CardTitle,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 844 * 25),
                          Text(
                            '보안 정보',
                            style: ABTextTheme.CardMidSeperate,
                          ),
                          SizedBox(height: screenHeight / 844 * 8),
                          Container(
                            width: screenWidth / 390 * 230,
                            height: screenHeight / 844 * 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 390 * 12,
                                vertical: screenHeight / 844 * 12),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEAEAEA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '아이디',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['id'],
                                            style: ABTextTheme.CardDescription),
                                        const SizedBox(width: 3),
                                        GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: widget.obj['id']));
                                          },
                                          child: const Icon(
                                            Icons.copy_rounded,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '비밀번호',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['password'],
                                            style: ABTextTheme.CardDescription),
                                        const SizedBox(width: 3),
                                        GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: widget.obj['password']));
                                          },
                                          child: const Icon(
                                            Icons.copy_rounded,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight / 844 * 10),
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
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return GestureDetector(
      onTap: () => _showInfoDialog(context, widget),
      child: Column(
        children: [
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 83,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenWidth / 390 * 16),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: CircleDesign.BlueGradient,
                        ),
                        SizedBox(width: screenWidth / 390 * 16),
                        Text(
                          widget.name.toUpperCase(),
                          style: ABTextTheme.CardTitle,
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.obj['password']));
                          },
                          icon: Icon(
                            Icons.copy_rounded,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: 3,
            color: Colors.white.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 0),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 71,
            decoration: const BoxDecoration(
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: screenWidth / 390 * 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '결제금액',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          formatter.format(widget.obj['cost']),
                                      style: ABTextTheme.CardFirstHighlight,
                                    ),
                                    TextSpan(
                                      text: '원/월',
                                      style: ABTextTheme.CardFirstStandard,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '예상 해지일',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${widget.obj['endDate']}",
                                      style: ABTextTheme.CardFirstHighlight,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth / 390 * 10),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: 3,
            color: Colors.white.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 0),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 102,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '아이디',
                        style: ABTextTheme.CardSecondStandard,
                      ),
                      TextSpan(
                        text: '    ',
                        style: ABTextTheme.CardSecondStandard,
                      ),
                      TextSpan(
                        text: widget.obj['id'],
                        style: ABTextTheme.CardSecondHighlight,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Clipboard.setData(
                                ClipboardData(text: widget.obj['id']));
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight / 844 * 4,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '비밀번호',
                        style: ABTextTheme.CardSecondStandard,
                      ),
                      TextSpan(
                        text: '    ',
                        style: ABTextTheme.CardSecondStandard,
                      ),
                      TextSpan(
                        text: widget.obj['password'],
                        style: ABTextTheme.CardSecondHighlight,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Clipboard.setData(
                                ClipboardData(text: widget.obj['password']));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GuaranteeCard extends StatefulWidget {
  const GuaranteeCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'guarantee';

  @override
  State<GuaranteeCard> createState() => _GuaranteeCardState();
}

class _GuaranteeCardState extends State<GuaranteeCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _showInfoDialog(context, widget),
      child: Column(
        children: [
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 83,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenWidth / 390 * 16),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: CircleDesign.PurpleGradient,
                        ),
                        SizedBox(width: screenWidth / 390 * 16),
                        Text(
                          widget.name.toUpperCase(),
                          style: ABTextTheme.CardTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: 3,
            color: Colors.white.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 0),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 71,
            decoration: const BoxDecoration(
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: screenWidth / 390 * 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '제품명',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "${widget.obj['name']}",
                                  style: ABTextTheme.CardFirstHighlight,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '모델명',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "${widget.obj['model']}",
                                  style: ABTextTheme.CardFirstHighlight,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '예상 해지일',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${widget.obj['endDate']}",
                                      style: ABTextTheme.CardFirstHighlight,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth / 390 * 10),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: 3,
            color: Colors.white.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 0),
          ),
          Container(
            width: screenWidth / 390 * 330,
            height: screenHeight / 844 * 102,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color(0x3FEFEFEF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: widget.obj['note'],
                    style: ABTextTheme.CardSecondStandard,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
