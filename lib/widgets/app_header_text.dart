import 'package:flutter/material.dart';

class AppHeaderText extends StatelessWidget {
  final String text;
  final List<Shadow>? shadow;

  const AppHeaderText({
    super.key,
    this.shadow,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        shadows: shadow ??
            [
              const BoxShadow(
                offset: Offset(0, 1),
                color: Colors.green,
                spreadRadius: 20,
                blurRadius: 40,
              ),
            ],
        fontSize: 42.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
