import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abibo/functions/control_platform.dart';
import '../functions/control_guarantee.dart';
import 'package:intl/intl.dart';

class PlatformCard extends StatefulWidget {
  PlatformCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<PlatformCard> createState() => _PlatformCardState();
}

class _PlatformCardState extends State<PlatformCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Navigator(
          key: widget.navigatorKey,
          onGenerateRoute: (setting) {
            return PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (context, anim1, anim2) => PlatformInitialCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlatformInitialCard extends StatefulWidget {
  const PlatformInitialCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<PlatformInitialCard> createState() => _PlatformInitialCardState();
}

class _PlatformInitialCardState extends State<PlatformInitialCard> {
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        widget.navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PlatformDismissCard(
              name: widget.name,
              obj: widget.obj,
              change: widget.change,
              navigatorKey: widget.navigatorKey,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      background: Container(
        width: screenWidth / 390 * 326,
        height: screenHeight / 844 * 82,
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데//아이콘 PADDING
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          widget.navigatorKey.currentState?.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  PlatformTouchedCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Hero(
          tag: 'platformhero-${widget.name}',
          child: Container(
            width: screenWidth / 390 * 326,
            height: screenHeight / 844 * 82,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              color: const Color(0xFFF4F4F4),
              border: Border.all(
                color: const Color(0xFFD6D4D4),
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight / 844 * 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
        ),
      ),
    );
  }
}

class PlatformDismissCard extends StatefulWidget {
  const PlatformDismissCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<PlatformDismissCard> createState() => _PlatformDismissCardState();
}

class _PlatformDismissCardState extends State<PlatformDismissCard> {
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        removePlatform(platform: widget.name, obj: widget.obj);
        widget.change();
      },
      child: Hero(
        tag: 'platformhero-${widget.name}',
        child: Container(
          width: screenWidth / 390 * 326,
          height: screenHeight / 844 * 82,
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: Colors.red,
            border: Border.all(
              color: Colors.white,
              width: 0.5,
            ),
          ),
          alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데//아이콘 PADDING
          child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
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
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'platform';
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<PlatformTouchedCard> createState() => _PlatformTouchedCardState();
}

class _PlatformTouchedCardState extends State<PlatformTouchedCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        widget.navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PlatformInitialCard(
              name: widget.name,
              obj: widget.obj,
              change: widget.change,
              navigatorKey: widget.navigatorKey,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Hero(
        tag: 'platformhero-${widget.name}',
        child: Column(
          children: [
            Container(
              width: screenWidth / 390 * 326,
              height: screenHeight / 844 * 174,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                color: const Color(0xFFF4F4F4),
                border: Border.all(
                  color: const Color(0xFFD6D4D4),
                  width: 0.5,
                ),
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
  SubscriptionCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Navigator(
          key: widget.navigatorKey,
          onGenerateRoute: (setting) {
            return PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (context, anim1, anim2) => SubscriptionInitialCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubscriptionInitialCard extends StatefulWidget {
  const SubscriptionInitialCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<SubscriptionInitialCard> createState() =>
      _SubscriptionInitialCardState();
}

class _SubscriptionInitialCardState extends State<SubscriptionInitialCard> {
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await removeSubscription(serviceName: widget.name, obj: widget.obj);
        widget.change();
      },
      background: Container(
        width: screenWidth / 390 * 326,
        height: screenHeight / 844 * 82,
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데//아이콘 PADDING
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          widget.navigatorKey.currentState?.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  SubscriptionTouchedCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Hero(
          tag: 'subscriptionhero-${widget.name}',
          child: Column(
            children: [
              Container(
                width: screenWidth / 390 * 326,
                height: screenHeight / 844 * 82,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  color: const Color(0xFFF4F4F4),
                  border: Border.all(
                    color: const Color(0xFFD6D4D4),
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 844 * 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: CircleDesign.BlueGradient,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.name.toUpperCase(),
                              style: ABTextTheme.CardTitle,
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          formatter.format(widget.obj['cost']),
                                      style: ABTextTheme.InitialCardTitle),
                                  const TextSpan(
                                      text: '원',
                                      style: ABTextTheme.InitialCardTitle),
                                  const TextSpan(text: ', '),
                                  TextSpan(
                                      text: widget.obj['endDate'],
                                      style: ABTextTheme.InitialCardTitle),
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
      ),
    );
  }
}

class SubscriptionTouchedCard extends StatefulWidget {
  const SubscriptionTouchedCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'subscription';
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<SubscriptionTouchedCard> createState() =>
      _SubscriptionTouchedCardState();
}

class _SubscriptionTouchedCardState extends State<SubscriptionTouchedCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return GestureDetector(
      onTap: () {
        widget.navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                SubscriptionInitialCard(
              name: widget.name,
              obj: widget.obj,
              change: widget.change,
              navigatorKey: widget.navigatorKey,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Hero(
        tag: 'subscriptionhero-${widget.name}',
        child: Column(
          children: [
            Container(
              width: screenWidth / 390 * 326,
              height: screenHeight / 844 * 290,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                color: const Color(0xFFF4F4F4),
                border: Border.all(
                  color: const Color(0xFFD6D4D4),
                  width: 0.5,
                ),
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
                        decoration: CircleDesign.BlueGradient,
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
                          SizedBox(height: screenHeight / 844 * 25),
                          Text(
                            '구독 정보',
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
                                      '결제 금액',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                formatter
                                                    .format(widget.obj['cost']),
                                                style: ABTextTheme
                                                    .CardDescription),
                                            Text(
                                              '원/KRW',
                                              style:
                                                  ABTextTheme.CardDescription,
                                            )
                                          ],
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
                                      '다음 결제일',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['endDate'],
                                            style: ABTextTheme.CardDescription),
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

class GuaranteeCard extends StatefulWidget {
  GuaranteeCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<GuaranteeCard> createState() => _GuaranteeCardState();
}

class _GuaranteeCardState extends State<GuaranteeCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Navigator(
          key: widget.navigatorKey,
          onGenerateRoute: (setting) {
            return PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (context, anim1, anim2) => GuaranteeInitialCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class GuaranteeInitialCard extends StatefulWidget {
  const GuaranteeInitialCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<GuaranteeInitialCard> createState() => _GuaranteeInitialCardState();
}

class _GuaranteeInitialCardState extends State<GuaranteeInitialCard> {
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await removeGuarantee(brand: widget.name, obj: widget.obj);
        widget.change();
      },
      background: Container(
        width: screenWidth / 390 * 326,
        height: screenHeight / 844 * 82,
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 390 * 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데//아이콘 PADDING
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          widget.navigatorKey.currentState?.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  GuaranteeTouchedCard(
                name: widget.name,
                obj: widget.obj,
                change: widget.change,
                navigatorKey: widget.navigatorKey,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Hero(
          tag: 'guaranteehero-${widget.name}',
          child: Column(
            children: [
              Container(
                width: screenWidth / 390 * 326,
                height: screenHeight / 844 * 82,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  color: const Color(0xFFF4F4F4),
                  border: Border.all(
                    color: const Color(0xFFD6D4D4),
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 844 * 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: CircleDesign.BlackGradient,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.name.toUpperCase(),
                              style: ABTextTheme.CardTitle,
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.obj['name'],
                                      style: ABTextTheme.InitialCardTitle),
                                  const TextSpan(text: ', '),
                                  TextSpan(
                                      text: widget.obj['endDate'],
                                      style: ABTextTheme.InitialCardTitle),
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
      ),
    );
  }
}

class GuaranteeTouchedCard extends StatefulWidget {
  const GuaranteeTouchedCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.navigatorKey,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final String type = 'guarantee';
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<GuaranteeTouchedCard> createState() => _GuaranteeTouchedCardState();
}

class _GuaranteeTouchedCardState extends State<GuaranteeTouchedCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        widget.navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                GuaranteeInitialCard(
              name: widget.name,
              obj: widget.obj,
              change: widget.change,
              navigatorKey: widget.navigatorKey,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Hero(
        tag: 'guaranteehero-${widget.name}',
        child: Column(
          children: [
            Container(
              width: screenWidth / 390 * 326,
              height: screenHeight / 844 * 290,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                color: const Color(0xFFF4F4F4),
                border: Border.all(
                  color: const Color(0xFFD6D4D4),
                  width: 0.5,
                ),
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
                        decoration: CircleDesign.BlackGradient,
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
                                      '제품명',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['name'],
                                            style: ABTextTheme.CardDescription),
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
                                      '모델명',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['model'],
                                            style: ABTextTheme.CardDescription),
                                        const SizedBox(width: 3),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight / 844 * 25),
                          Text(
                            '기타 정보',
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
                                      '메모',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(widget.obj['note'],
                                                style: ABTextTheme
                                                    .CardDescription),
                                          ],
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
                                      '해지일',
                                      style: ABTextTheme.CardDescription,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.obj['endDate'],
                                            style: ABTextTheme.CardDescription),
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

/*
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
}*/

/*
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
}*/