import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abibo/functions/control_platform.dart';
import '../functions/control_guarantee.dart';
import 'package:intl/intl.dart';

class StandardCard extends StatelessWidget {
  StandardCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.remove,
    required this.initial,
    required this.touched,
    required this.type,
  }) : super(key: key);

  final Widget initial;
  final Widget touched;
  final String name;
  final String type;
  final dynamic obj;
  final Function remove;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Navigator(
          key: navigatorKey,
          onGenerateRoute: (setting) {
            return PageRouteBuilder(
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
              pageBuilder: (context, anim1, anim2) => StandardInitialCard(
                name: name,
                obj: obj,
                type: type,
                remove: remove,
                navigatorKey: navigatorKey,
                initial: initial,
                touched: touched,
              ),
            );
          },
        ),
      ),
    );
  }
}

class StandardInitialCard extends StatelessWidget {
  const StandardInitialCard({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
    required this.remove,
    required this.navigatorKey,
    required this.initial,
    required this.touched,
  }) : super(key: key);

  final Widget initial;
  final Widget touched;
  final String type;
  final String name;
  final dynamic obj;
  final Function remove;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                StandardDismissCard(
              type: type,
              name: name,
              obj: obj,
              remove: remove,
              navigatorKey: navigatorKey,
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
          navigatorKey.currentState?.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  StandardTouchedCard(
                type: type,
                name: name,
                obj: obj,
                remove: remove,
                navigatorKey: navigatorKey,
                initial: initial,
                touched: touched,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Hero(
          tag: '${type}hero-$name',
          child: initial,
        ),
      ),
    );
  }
}

class StandardDismissCard extends StatelessWidget {
  const StandardDismissCard({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
    required this.remove,
    required this.navigatorKey,
  }) : super(key: key);

  final String type;
  final String name;
  final dynamic obj;
  final Function remove;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        remove();
      },
      child: Hero(
        tag: '${type}hero-$name',
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

class StandardTouchedCard extends StatelessWidget {
  const StandardTouchedCard({
    Key? key,
    required this.type,
    required this.name,
    required this.obj,
    required this.remove,
    required this.navigatorKey,
    required this.initial,
    required this.touched,
  }) : super(key: key);

  final Widget initial;
  final Widget touched;
  final String name;
  final dynamic obj;
  final Function remove;
  final String type;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                StandardInitialCard(
              type: type,
              name: name,
              obj: obj,
              remove: remove,
              navigatorKey: navigatorKey,
              initial: initial,
              touched: touched,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Hero(
        tag: '${type}hero-$name',
        child: touched,
      ),
    );
  }
}

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StandardCard(
      name: name,
      obj: obj,
      remove: () async {
        await removePlatform(platform: name, obj: obj);
        change();
      },
      initial: Container(
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
                      name.toUpperCase(),
                      style: ABTextTheme.CardTitle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      touched: Column(
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
                              name.toUpperCase(),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['id'],
                                          style: ABTextTheme.CardDescription),
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(
                                              ClipboardData(text: obj['id']));
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['password'],
                                          style: ABTextTheme.CardDescription),
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: obj['password']));
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
      type: 'platform',
    );
  }
}

class SubscriptionCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return StandardCard(
      name: name,
      obj: obj,
      remove: () async {
        await removeSubscription(serviceName: name, obj: obj);
        change();
      },
      initial: Container(
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
                      name.toUpperCase(),
                      style: ABTextTheme.CardTitle,
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: formatter.format(obj['cost']),
                              style: ABTextTheme.InitialCardTitle),
                          const TextSpan(
                              text: '원', style: ABTextTheme.InitialCardTitle),
                          const TextSpan(text: ', '),
                          TextSpan(
                              text: obj['endDate'],
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
      touched: Column(
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
                              name.toUpperCase(),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['id'],
                                          style: ABTextTheme.CardDescription),
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(
                                              ClipboardData(text: obj['id']));
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['password'],
                                          style: ABTextTheme.CardDescription),
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: obj['password']));
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(formatter.format(obj['cost']),
                                              style:
                                                  ABTextTheme.CardDescription),
                                          Text(
                                            '원/KRW',
                                            style: ABTextTheme.CardDescription,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['endDate'],
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
      type: 'subscription',
    );
  }
}

class GuaranteeCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StandardCard(
      name: name,
      obj: obj,
      remove: () async {
        await removeGuarantee(brand: name, obj: obj);
        change();
      },
      initial: Container(
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
                      name.toUpperCase(),
                      style: ABTextTheme.CardTitle,
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: obj['name'],
                              style: ABTextTheme.InitialCardTitle),
                          const TextSpan(text: ', '),
                          TextSpan(
                              text: obj['endDate'],
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
      touched: Column(
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
                              name.toUpperCase(),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['name'],
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['model'],
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(obj['note'],
                                              style:
                                                  ABTextTheme.CardDescription),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(obj['endDate'],
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
      type: 'guarantee',
    );
  }
}
