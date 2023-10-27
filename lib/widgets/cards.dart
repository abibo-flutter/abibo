import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/theme/color_theme.dart';
import 'package:abibo/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abibo/functions/control_platform.dart';
import '../functions/control_guarantee.dart';
import 'package:intl/intl.dart';
import 'package:abibo/widgets/custom_text.dart';

class StandardCard extends StatefulWidget {
  const StandardCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.remove,
    required this.initial,
    required this.touched,
    required this.type,
    required this.updating,
  }) : super(key: key);

  final Widget initial;
  final Widget touched;
  final String name;
  final String type;
  final dynamic obj;
  final Function remove;
  final bool updating;

  @override
  State<StandardCard> createState() => _StandardCardState();
}

class _StandardCardState extends State<StandardCard> {
  String state = 'initial';
  late bool updated;

  @override
  void initState() {
    super.initState();
    updated = widget.updating;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (updated != widget.updating) {
      setState(() {
        state = 'initial';
        updated = widget.updating;
      });
    }

    if (state == 'initial') {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        movementDuration: Duration.zero,
        resizeDuration: const Duration(microseconds: 1),
        confirmDismiss: (direction) async {
          setState(() {
            state = 'dismiss';
          });
          return false;
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
            setState(() {
              state = 'touched';
            });
          },
          child: widget.initial,
        ),
      );
    }
    if (state == 'touched') {
      return GestureDetector(
        onTap: () {
          setState(() {
            state = 'initial';
          });
        },
        child: widget.touched,
      );
    }
    //if (state == 'dismiss)
    return GestureDetector(
      onTap: () {
        setState(() {
          state = 'initial';
          widget.remove();
        });
      },
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
    );
  }
}

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.updating,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final bool updating;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StandardCard(
      updating: updating,
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
                    CustomText(
                      text: name.toUpperCase(),
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
                            CustomText(
                              text: name.toUpperCase(),
                              style: ABTextTheme.CardTitle,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 844 * 25),
                        CustomText(
                          text: '보안 정보',
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
                                  CustomText(
                                    text: '아이디',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: obj['id']));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: obj['id'],
                                            style: ABTextTheme.CardDescription),
                                        const SizedBox(width: 3),
                                        const Icon(
                                          Icons.copy_rounded,
                                          color: Colors.black,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '비밀번호',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: obj['password']));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: obj['password'],
                                            style: ABTextTheme.CardDescription),
                                        const SizedBox(width: 3),
                                        const Icon(
                                          Icons.copy_rounded,
                                          color: Colors.black,
                                          size: 10,
                                        ),
                                      ],
                                    ),
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
  const SubscriptionCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.updating,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final bool updating;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final NumberFormat formatter = NumberFormat('#,###');
    return StandardCard(
      updating: updating,
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
                    CustomText(
                      text: name.toUpperCase(),
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
                            CustomText(
                              text: name.toUpperCase(),
                              style: ABTextTheme.CardTitle,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 844 * 25),
                        CustomText(
                          text: '보안 정보',
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
                                  CustomText(
                                    text: '아이디',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['id'],
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
                                  CustomText(
                                    text: '비밀번호',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['password'],
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
                        CustomText(
                          text: '구독 정보',
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
                                  CustomText(
                                    text: '결제 금액',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                              text:
                                                  formatter.format(obj['cost']),
                                              style:
                                                  ABTextTheme.CardDescription),
                                          CustomText(
                                            text: '원/KRW',
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
                                  CustomText(
                                    text: '다음 결제일',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['endDate'],
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
  const GuaranteeCard({
    Key? key,
    required this.name,
    required this.obj,
    required this.change,
    required this.updating,
  }) : super(key: key);

  final String name;
  final dynamic obj;
  final Function change;
  final bool updating;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StandardCard(
      updating: updating,
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
                    CustomText(
                      text: name.toUpperCase(),
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
                            CustomText(
                              text: name.toUpperCase(),
                              style: ABTextTheme.CardTitle,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 844 * 25),
                        CustomText(
                          text: '보안 정보',
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
                                  CustomText(
                                    text: '제품명',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['name'],
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
                                  CustomText(
                                    text: '모델명',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['model'],
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
                        CustomText(
                          text: '기타 정보',
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
                                  CustomText(
                                    text: '메모',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                              text: obj['note'],
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
                                  CustomText(
                                    text: '해지일',
                                    style: ABTextTheme.CardDescription,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: obj['endDate'],
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
