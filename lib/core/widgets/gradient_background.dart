import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget widget;
  const GradientBackground({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFFFD700),
            ],
          ),
        ),
        child: widget,
      ),
    );
  }
}
