import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class CustomUserAccountDrawerHeader extends StatefulWidget {
  const CustomUserAccountDrawerHeader({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  State<CustomUserAccountDrawerHeader> createState() =>
      _CustomUserAccountDrawerHeaderState();
}

class _CustomUserAccountDrawerHeaderState
    extends State<CustomUserAccountDrawerHeader>
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
    double screenWidth = MediaQuery.of(context).size.width;
    return SlideTransition(
      position: _animation,
      child: SizedBox(
        width: screenWidth / 390 * 10,
        child: UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.00005),
          ),
          accountName: const SizedBox.shrink(),
          accountEmail: Text(widget.user.email!),
          currentAccountPicture: InkWell(
            onTap: _selectImage,
            child: CircleAvatar(
              radius: 3, // TODO : 크기 설정인데 왠지 모르겠지만 안바뀜
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
      ),
    );
  }
}
