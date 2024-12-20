import 'package:flutter/material.dart';

class AppHeaderText extends StatelessWidget {
  final String text;

  const AppHeaderText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        shadows: [
          BoxShadow(
            color: Colors.green,
          ),
        ],
        fontSize: 42.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
