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

    return Scaffold(
      body: FutureBuilder(
        future: searchInfo(),
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup_screen.png'),
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
                    height: screenHeight / 844 * 94,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          height: screenHeight / 844 * 24,
                        ),
                      ),
                      itemCount: infos.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name = infos[index][0];
                        dynamic obj = infos[index][1];

                        return SubscriptionCard(
                          name: name,
                          obj: obj,
                          change: () {
                            searchInfo();
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
