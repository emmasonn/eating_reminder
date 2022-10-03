import 'package:flutter/material.dart';

Future<void> showCustomDialog(
  BuildContext context,
  Widget child, {
  bool? dismissible,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible ?? false,
    builder: (context) => child,
  );
}
