import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  final Widget child;
  const BorderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0, right: 4, left: 4),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Colors.amber,
                width: 2.0,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
