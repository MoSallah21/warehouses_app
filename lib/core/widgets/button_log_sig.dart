import 'package:eks/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ButtonLogSig extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const ButtonLogSig({super.key, required this.text, this.onTap, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? screenWidth * 0.9,
          height ?? screenHeight * 0.07,
        ),
        backgroundColor: Pallat.iconsAndButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
