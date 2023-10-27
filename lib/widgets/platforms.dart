import 'package:abibo/widgets/cards.dart';
import 'package:flutter/material.dart';
import '../functions/control_platform.dart';

class Platforms extends StatefulWidget {
  const Platforms({Key? key}) : super(key: key);

  @override
  State<Platforms> createState() => _PlatformsState();
}

class _PlatformsState extends State<Platforms> {
  List<List> infos = [];
  bool updating = true;

  Future<void> searchInfo() async {
    infos = await getAllPlatform();
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

    return Expanded(
      child: FutureBuilder(
        future: searchInfo(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => setState(() {
              updating = !updating;
            }),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: screenHeight / 844 * 16,
              ),
              itemCount: infos.length,
              itemBuilder: (BuildContext context, int index) {
                String name = infos[index][0];
                dynamic obj = infos[index][1];

                return Center(
                  child: PlatformCard(
                    name: name,
                    obj: obj,
                    change: () {
                      searchInfo();
                      setState(() {});
                    },
                    updating: updating,
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
