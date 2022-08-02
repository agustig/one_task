import 'package:flutter/material.dart';

/// [TextButton] dengan kustom style
class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.onPressed,
    this.icon,
    this.width,
    required this.child,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget? icon;
  final double? width;
  final Widget child;

  final ButtonStyle _buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
      (_) => RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: (icon != null)
          ? TextButton.icon(
              onPressed: onPressed,
              icon: icon!,
              style: _buttonStyle,
              label: child,
            )
          : TextButton(
              onPressed: onPressed,
              style: _buttonStyle,
              child: child,
            ),
    );
  }
}
