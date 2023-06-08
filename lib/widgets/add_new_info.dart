import 'package:flutter/material.dart';

class AddNewInfo extends StatelessWidget {
  const AddNewInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight / 844 * 69,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            offset: Offset(0, 2),
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
            color: Color.fromRGBO(101, 45, 139, 0.475),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6B19DC).withOpacity(0.8),
            const Color(0xFFD966BB).withOpacity(0.8),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          '새 정보 추가하기',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
