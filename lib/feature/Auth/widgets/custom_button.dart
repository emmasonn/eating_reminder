import 'package:flutter/material.dart';

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.style,
  }) : super(key: key);
  final String text;
  final Widget? icon;
  final TextStyle? style;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            icon != null ? icon! : Container(),
            Expanded(
                child: Align(
              child: Text(
                text,
                style: style ??
                    const TextStyle(
                      fontFamily: 'RubikBold',
                      fontSize: 16,
                    ),
              ),
            ))
          ],
        ));
  }
}
