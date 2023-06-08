import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight * 0.15,
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/background_netflix.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white.withOpacity(0.8),
                size: 25,
              ),
              onPressed: () {
                // 왼쪽 화살표를 눌렀을 때 수행할 작업을 여기에 추가합니다.
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NETFLIX',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF0000),
                        ),
                      ),
                      Text(
                        ' 결제일까지',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '54',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF0000),
                        ),
                      ),
                      Text(
                        '일 남았어요!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFFD9d9D9),
                      ),
                      SizedBox(width: 4), // 점 사이의 간격을 조절할 수 있는 SizedBox
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFF696969),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFF696969),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFF696969),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: Color(0xFF696969),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ), // 추가된 괄호
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.8),
                size: 25,
              ),
              onPressed: () {
                // 왼쪽 화살표를 눌렀을 때 수행할 작업을 여기에 추가합니다.
              },
            ),
          ),
        ],
      ),
    );
  }
}
