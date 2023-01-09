import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showCustomTopSnackBar(
  BuildContext context, {
  required String msg,
  required Color color,
}) {
  showTopSnackBar(
    Overlay.of(context)!,
    CustomSnackBar.info(
      message: msg,
      icon: const Icon(
        Icons.info,
        color: Color(0x15000000),
        size: 120,
      ),
      backgroundColor: color,
    ),
    animationDuration: const Duration(milliseconds: 1000),
  );
}
