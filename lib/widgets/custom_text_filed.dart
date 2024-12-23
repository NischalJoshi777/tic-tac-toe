import 'package:flutter/material.dart';

class CustomTextEditField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const CustomTextEditField({
    super.key,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
