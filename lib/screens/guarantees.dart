import 'package:abibo/functions/control_guarantee.dart';
import 'package:abibo/widgets/cards.dart';
import 'package:flutter/material.dart';

class Guarantees extends StatefulWidget {
  const Guarantees({Key? key}) : super(key: key);

  @override
  State<Guarantees> createState() => _GuaranteesState();
}

class _GuaranteesState extends State<Guarantees> {
  List<List> infos = [];

  Future<void> searchInfos() async {
    infos = await getAllGuarantee();
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
        future: searchInfos(),
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
                        String brand = infos[index][0];
                        dynamic obj = infos[index][1];
                        return GuaranteeCard(
                          name: brand,
                          obj: obj,
                          change: () {
                            searchInfos();
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
