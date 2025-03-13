import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.height,  this.width});
  final double height;
  final double? width;


  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/eks_cut.png',
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
