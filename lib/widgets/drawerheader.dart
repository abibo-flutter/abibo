/*import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간
    );

    _animation = Tween<Offset>(
      begin: const Offset(2.0, 0.0), // 시작 위치 (오른쪽에서)
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SlideTransition(
      position: _animation,
      child: SizedBox(
        width: screenWidth / 390 * 10,
        height: screenHeight / 844 * 120,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.00005),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 50,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/