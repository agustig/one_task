import 'package:flutter/material.dart';

/// Kotak isian yang digunakan untuk menginput Text/String
class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        autocorrect: false,
        autofocus: true,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
