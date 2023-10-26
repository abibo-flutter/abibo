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
  bool updating = true;

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

    return Expanded(
      child: FutureBuilder(
        future: searchInfos(),
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
                String brand = infos[index][0];
                dynamic obj = infos[index][1];
                return Center(
                  child: GuaranteeCard(
                    updating: updating,
                    name: brand,
                    obj: obj,
                    change: () {
                      searchInfos();
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
