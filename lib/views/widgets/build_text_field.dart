import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Kotak isian yang digunakan untuk menginput Text/String
class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.enabled = true,
    this.isIosField = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int minLines;
  final int maxLines;
  final bool enabled;

  /// Menampikan CupertinoTextField
  final bool isIosField;

  @override
  Widget build(BuildContext context) {
    if (isIosField) {
      return _iosField();
    }

    return _defaultField();
  }

  Widget _iosField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CupertinoTextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        autocorrect: false,
        autofocus: true,
        decoration: BoxDecoration(border: Border.all()),
        enabled: enabled,
        placeholder: hint,
      ),
    );
  }

  Widget _defaultField() {
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
        enabled: enabled,
      ),
    );
  }
}
