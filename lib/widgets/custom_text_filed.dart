import 'package:flutter/material.dart';

class CustomTextEditField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool readOnly;

  const CustomTextEditField({
    super.key,
    required this.hintText,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
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
