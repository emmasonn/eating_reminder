import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

enum PageAnimationStyle {
  fade,
  scale,
  rotate,
  slideRight,
  fromBottom,
  fromTop,
  slideLeft,
  none
}

class CustomPage<T> extends CustomTransitionPage<T> {
  final Duration? duration;
  final PageAnimationStyle animationStyle;

  CustomPage({
    required super.key,
    required super.child,
    this.animationStyle = PageAnimationStyle.none,
    this.duration,
  }) : super(
            transitionDuration: duration ?? const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              if (animationStyle == PageAnimationStyle.slideRight) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child,
                );
              } else if (animationStyle == PageAnimationStyle.fade) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              } else if (animationStyle == PageAnimationStyle.rotate) {
                return RotationTransition(
                  turns: ReverseAnimation(animation),
                  child: child,
                );
              } else if (animationStyle == PageAnimationStyle.scale) {
                return ScaleTransition(scale: animation, child: child);
              } else {
                var xTranslation = 0.0, yTranslation = 0.0;

                if (animationStyle == PageAnimationStyle.fromTop) {
// this will animate items from top with fade transition
                  yTranslation = -50 * (1.0 - animation.value);
                } else if (animationStyle == PageAnimationStyle.fromBottom) {
// this will animate items from bottom with fade transition
                  yTranslation = 50 * (1.0 - animation.value);
                } else if (animationStyle == PageAnimationStyle.slideRight) {
// this will animate items from right with fade transition
                  xTranslation = 400 * (1.0 - animation.value);
                } else {
                  return child;
                }
                return FadeTransition(
                  opacity: animation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        xTranslation, yTranslation, 0.0),
                    child: child,
                  ),
                );
              }
            });
}
