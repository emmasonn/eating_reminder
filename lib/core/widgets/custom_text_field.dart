import 'package:flutter/material.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/widgets/custom_input_border.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.displayHint = DisplayHint.outside,
    this.controller,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.isEditable,
    this.outline,
    this.elevate,
    this.helperText,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final DisplayHint displayHint;
  final String hintText;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? isEditable;
  final bool? elevate;
  final bool? outline;
  final String? helperText;
  final String? initialValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (displayHint == DisplayHint.outside) ...[
            Text(
              hintText,
              style: theme.textTheme.subtitle1?.copyWith(color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            )
          ],
          TextFormField(
            style: theme.textTheme.headline6
                ?.copyWith(fontSize: 16, fontFamily: 'Rubik'),
            enabled: true,
            keyboardType: TextInputType.number,
            autocorrect: false,
            initialValue: initialValue,
            decoration: displayHint == DisplayHint.outside
                ? InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: theme.primaryColorLight, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: theme.primaryColorLight, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: theme.primaryColorLight, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    helperText: helperText,
                    hintText: hintText,
                    hintStyle: theme.textTheme.subtitle1?.copyWith(
                        color: theme.primaryColorLight.withOpacity(0.4)),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                  )
                : InputDecoration(
                    label: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          hintText,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'Rubik'),
                        )
                      ],
                    ),
                    prefix: SizedBox(
                      width: 10,
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    ),
                    border: CustomInputBorder(
                      borderSide: BorderSide(
                          color: theme.primaryColorLight, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: CustomInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: theme.primaryColorLight)),
                    focusedBorder: CustomInputBorder(
                      borderSide: BorderSide(
                          color: theme.primaryColorLight, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: hintText,
                    hintStyle: theme.textTheme.subtitle2?.copyWith(
                        color: theme.primaryColorLight.withOpacity(0.2)),
                    suffixIcon: suffixIcon,
                  ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
