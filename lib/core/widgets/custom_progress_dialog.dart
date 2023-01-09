import 'package:flutter/material.dart';
import 'package:informat/core/widgets/custom_progress_widget.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({
    super.key,
    this.loadingWidget,
  });
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: 200,
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: loadingWidget ?? CustomProgressWidget.cupertinoLoading(),
          ),
        ),
      ),
    );
  }
}
