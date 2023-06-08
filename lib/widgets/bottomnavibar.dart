import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        color: Colors.white, //색상
        child: Container(
          color: Colors.transparent, // 상위 Container의 색상을 투명으로 설정
          child: Stack(
            children: [
              Container(
                height: screenHeight / 844 * 62,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      color: Color.fromRGBO(158, 158, 158, 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 65,
                child: TabBar(
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.all(0),
                  indicator: BoxDecoration(),
                  unselectedLabelColor: Color(0xFF999999),
                  labelStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        size: 25,
                      ),
                      text: '홈',
                      iconMargin: EdgeInsets.only(bottom: 1.5),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.search_rounded,
                        size: 25,
                      ),
                      text: '검색',
                      iconMargin: EdgeInsets.only(bottom: 1.5),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.settings,
                        size: 25,
                      ),
                      text: '설정',
                      iconMargin: EdgeInsets.only(bottom: 1.5),
                    ),
                  ],
                  padding: EdgeInsets.only(left: 20, right: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
