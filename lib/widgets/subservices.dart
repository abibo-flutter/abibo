import 'package:abibo/functions/control_subscription.dart';
import 'package:abibo/widgets/cards.dart';
import 'package:flutter/material.dart';

class SubServices extends StatefulWidget {
  const SubServices({Key? key}) : super(key: key);

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
  List<List> infos = [];

  Future<void> searchInfo() async {
    infos = await getAllSubscription();
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
              print('set state');
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
                  child: SubscriptionCard(
                    name: name,
                    obj: obj,
                    change: () {
                      searchInfo();
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
