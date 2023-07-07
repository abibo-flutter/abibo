import 'package:abibo/functions/control_memo.dart';
import 'package:abibo/functions/control_platform.dart';
import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/widgets/cards.dart';
import 'package:flutter/material.dart';

class Platforms extends StatefulWidget {
  const Platforms({Key? key}) : super(key: key);

  @override
  State<Platforms> createState() => _PlatformsState();
}

class _PlatformsState extends State<Platforms> {
  List<List> infos = [];

  Future<void> searchTodos() async {
    infos = [];
    for (List list in await getAllPlatform()) {
      infos.add(['platform', list[0], list[1]]);
    }

    for (List list in await getAllSubscription(sorted: true)) {
      infos.add(['subscription', list[0], list[1]]);
    }

    for (List list in await getAllMemo()) {
      infos.add(['memo', list[0], list[1]]);
    }
    print(infos);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: searchTodos(),
            builder: (context, snapshot) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/main_screen.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight / 844 * 38,
                    bottom: 0,
                    left: screenHeight / 844 * 30,
                    right: screenHeight / 844 * 30,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 844 * 50,
                      ),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('돌아가기'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.white30),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            itemCount: infos.length,
                            itemBuilder: (BuildContext context, int index) {
                              String type = infos[index][0];
                              String name = infos[index][1];
                              dynamic obj = infos[index][2];

                              if (type == 'platform') {
                                return PlatformCard(
                                  name: name,
                                  obj: obj,
                                  change: () {
                                    searchTodos();
                                    setState(() {});
                                  },
                                );
                              }
                              if (type == 'memo') {
                                return MemoCard(
                                  name: name,
                                  text: obj,
                                  change: () {
                                    searchTodos();
                                    setState(() {});
                                  },
                                );
                              }
                              if (type == 'subscription') {
                                return SubscriptionCard(
                                  name: name,
                                  obj: obj,
                                  change: () {
                                    searchTodos();
                                    setState(() {});
                                  },
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
