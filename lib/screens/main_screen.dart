import 'package:abibo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abibo/screens/theme/text_theme.dart';
import 'package:abibo/widgets/mainmenucard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class CustomUserAccountDrawerHeader extends StatefulWidget {
  const CustomUserAccountDrawerHeader({Key? key}) : super(key: key);

  @override
  _CustomUserAccountDrawerHeaderState createState() =>
      _CustomUserAccountDrawerHeaderState();
}

class _CustomUserAccountDrawerHeaderState
    extends State<CustomUserAccountDrawerHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  File? _selectedImage;
  User? user = FirebaseAuth.instance.currentUser;

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // 시작 위치 (오른쪽에서)
      end: Offset.zero, // 종료 위치 (왼쪽으로 이동)
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // 애니메이션 곡선 설정 (선택사항)
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: UserAccountsDrawerHeader(
        accountName: const SizedBox.shrink(),
        accountEmail: const Text('johndoe@example.com'),
        currentAccountPicture: InkWell(
          onTap: _selectImage,
          child: CircleAvatar(
            backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
            child: _selectedImage == null
                ? GestureDetector(
                    onTap: _selectImage,
                    child: const Icon(Icons.person),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

void navigateToLoginScreen() {
  Get.to(() => const LoginScreen());
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  late User? user;
  File? _selectedImage;

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void getCurrentUser() {
    try {
      user = _authentication.currentUser!; //로그인 정보 받아오기
    } catch (err) {
      print(err); //실패하면 오류 출력
    }
  }

  void logOut() async {
    await _authentication.signOut();
    getCurrentUser();
    navigateToLoginScreen();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const CustomUserAccountDrawerHeader(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // 메뉴 항목을 선택했을 때 수행할 동작을 작성합니다.
                Navigator.pop(context); // Drawer를 닫습니다.
                // TODO: Home 화면으로 이동하는 동작을 수행합니다.
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Drawer를 닫습니다.
                // TODO: Settings 화면으로 이동하는 동작을 수행합니다.
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Drawer를 닫습니다.
                logOut();
              },
            ),
          ],
        ),
      ),
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
              top: screenHeight / 844 * 38,
              bottom: 0,
              left: screenHeight / 844 * 23,
              right: screenHeight / 844 * 23,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Builder(builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Image(
                        image: AssetImage('assets/images/button/menu.png'),
                      ),
                      iconSize: 20,
                    );
                  }),
                ),
                const Row(
                  children: [
                    Text(
                      'Abibo',
                      style: ABTextTheme.LoginMainText1,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 844 * 54,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MainMenu(
                          color: Color(0xFFC87CFF),
                          image: 'assets/images/mainmenu1.png',
                          headline: '플랫폼',
                          text: '여기다가 아무거나\n적을거고 이거는\n진짜 아무거나이니까\n나중에 바꾸자',
                          topLeft: false,
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 6,
                        ),
                        const MainMenu(
                          color: Color(0xFF6153D1),
                          image: 'assets/images/mainmenu2.png',
                          headline: 'OTT',
                          text:
                              '사용하고 있는 \nOTT 서비스의 아이디와 가입일을\n 입력하고 보다 쉽게 해지일을\n확인하세요!',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 844 * 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MainMenu(
                          color: Color(0xFF0A033C),
                          image: 'assets/images/mainmenu3.png',
                          headline: '보증서',
                          text: '사실 이만큼 안써도 되고\n그냥 적당히 한두줄만\n써도 됨!',
                        ),
                        SizedBox(
                          width: screenWidth / 390 * 6,
                        ),
                        const MainMenu(
                          color: Color(0xFF7443D3),
                          image: 'assets/images/mainmenu4.png',
                          headline: '메모',
                          text: '여기다가는 그냥 대충\n기능 간단하게 소개할 \n수 있는 문구 넣으면 \n좋을듯',
                          bottomRight: false,
                        ),
                      ],
                    )
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
