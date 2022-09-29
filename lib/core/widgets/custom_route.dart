import 'package:flutter/material.dart';
enum PageAnimationStyle { fade, scale, rotate, slide, slideBottomTop }

class CustomRoute extends PageRouteBuilder  {
  final Widget child;
  final Duration? duration;
  final String? routeName;
  final PageAnimationStyle? animationStyle;

  CustomRoute({
    required this.child,
    this.duration,
    this.routeName,
    this.animationStyle,
  }) : super(
            pageBuilder: (context, anim1, anim2) => child,
            transitionDuration: duration ?? const Duration(milliseconds: 300),
            settings: RouteSettings(name: routeName),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              if (animationStyle == PageAnimationStyle.slide) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                );
              }else if(animationStyle == PageAnimationStyle.fade) {
                return FadeTransition(opacity: animation, child: child,);
              }else if(animationStyle  == PageAnimationStyle.rotate) {
                return RotationTransition(
                  turns: ReverseAnimation(animation),
                  child: child,);
              }else if(animationStyle == PageAnimationStyle.scale) {
                return ScaleTransition(scale: animation, child: child);
              }else {
                return FadeTransition(opacity: animation, child: child,);
              }
            });

}
