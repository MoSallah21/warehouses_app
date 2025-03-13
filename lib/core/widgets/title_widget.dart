import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        text: 'Establishment ',
        style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Khalil ',
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'sleiman',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
