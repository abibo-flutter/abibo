import 'package:abibo/screens/theme/color_theme.dart';
import 'package:abibo/screens/theme/text_theme.dart';
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
                          decoration: CircleDesign.RedGradient,
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
                                '결재금액',
                                style: ABTextTheme.CardFirstStandard,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${widget.obj['cost']}",
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
                          decoration: CircleDesign.BlueGradient,
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
                          decoration: CircleDesign.BlackGradient,
                        ),
                        SizedBox(width: screenWidth / 390 * 16),
                        Text(
                          widget.name,
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
                        text: widget.text,
                        style: ABTextTheme.CardSecondStandard,
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
