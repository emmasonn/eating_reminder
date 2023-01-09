import 'package:flutter/material.dart';

class AuthProviderButton extends StatelessWidget {
  const AuthProviderButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.header,
    this.style,
  }) : super(key: key);
  final String text;
  final Widget? icon;
  final TextStyle? style;
  final String? header;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) ...[
          const Text(
            'Setup profile',
            style: TextStyle(
              fontFamily: 'RubikBold',
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
        SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null ? icon! : Container(),
                  const SizedBox(
                    width: 5,
                  ),
                  Align(
                    child: Text(
                      text,
                      style: style ??
                          const TextStyle(
                            fontFamily: 'RubikBold',
                            fontSize: 16,
                          ),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
