import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:abibo/screens/theme/text_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SharedPreferences prefs;
  String? PIN;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    String searching = "";
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_screen.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 52,
              bottom: 0,
              left: screenHeight / 844 * 23,
              right: screenHeight / 844 * 23,
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Abibo',
                      style: ABTextTheme.MainMainText,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 844 * 32,
                ),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        //입력 전 디자인
                        hintText: "원하는 정보를 입력하세요.",
                        hintStyle: ABTextTheme.SearchingText,
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: Colors.white, // 검색 아이콘
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1.3,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(18.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1.3,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(18.5),
                        ),
                      ),
                      style: ABTextTheme.SearchingText,
                      onChanged: (value) {
                        setState(() {
                          searching = value;
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final todo = todos[index];
                          final bool isCompleted =
                              todo['completed'] ?? false; //할 일이 완료되었는지 여부
                          if (titleLarge.isNotEmpty &&
                              !todo['title']
                                  .toLowerCase()
                                  .contains(searching.toLowerCase())) {
                            return const SizedBox
                                .shrink(); // 검색어가 포함되지 않은 항목 숨기기
                          }
                          return Dismissible(
                            key: Key(todo['title']),
                            direction: DismissDirection.startToEnd, // 오른쪽으로 밀때
                            onDismissed: (direction) {
                              // 삭제하기
                              if (direction == DismissDirection.startToEnd) {
                                removeTodoItem(index);
                              }
                            },
                            background: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10), // 뒷배경 둥글게
                                color: Colors.red,
                              ),
                              alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20), //아이콘 PADDING
                              child: const Icon(Icons.delete_outline_rounded,
                                  color: Colors.white),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // 원하는 라운드 모서리 반지름 값 설정
                                side: BorderSide(
                                  color: isCompleted
                                      ? const Color(0xFFF7C34C)
                                      : Color(kPrimaryColor),
                                  width: 2,
                                ), // 원하는 모서리 색상 및 두께 설정
                              ),
                              color: Color(kBgColor),
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    color: isCompleted
                                        ? Colors.grey
                                        : Colors.white,
                                    isCompleted
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank_rounded,
                                    size: 35,
                                  ),
                                  onPressed: () => toggleTodoCompleted(index),
                                ),
                                title: Text(
                                  todo['title'] ?? '',
                                  style: TextStyle(
                                    color: isCompleted
                                        ? Colors.grey
                                        : Colors.white,
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ), // ?? '' 는 문자열이 null일 경우를 방지해 빈 문자열로 대체
                                subtitle: Text(
                                  todo['description'] ?? '',
                                  style: TextStyle(
                                    color: isCompleted
                                        ? Colors.grey
                                        : Colors.grey[300],
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ), // ?? ''
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: isCompleted
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  onPressed: () => removeTodoItem(index),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
