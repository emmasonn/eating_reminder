import 'dart:math';

import 'package:flutter/material.dart';

class WiggleAnimation extends StatelessWidget {
  const WiggleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  static const sinePeriod = 2 * pi;
  final double _endValue = 0;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: _endValue),
      duration: const Duration(milliseconds: 1000),
      builder: (BuildContext context, double value, Widget? child) {
        double offset = sin(value);

        return Transform.translate(
          offset: Offset(0, offset * 2),
          child: child,
        );
      },
      child: child,
    );
  }
}
