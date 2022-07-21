import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(),
              border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
