import 'package:abibo/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class Platforms extends StatefulWidget {
  const Platforms({Key? key}) : super(key: key);

  @override
  State<Platforms> createState() => _PlatformsState();
}

class _PlatformsState extends State<Platforms> {
  final _controller = Get.find<HomeScreenController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: FutureBuilder(
        future: _controller.searchInfo(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => setState(() {}),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: screenHeight / 844 * 16,
              ),
              itemCount: _controller.infos.length,
              itemBuilder: (BuildContext context, int index) {
                String name = _controller.infos[index][0];
                dynamic obj = _controller.infos[index][1];

                return Center(
                  child: PlatformCard(
                    name: name,
                    obj: obj,
                    change: () {
                      _controller.searchInfo();
                      _controller.searchNotice();
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
