import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPageTransition extends CustomTransitionPage {
  CustomPageTransition({
    required super.child,
    required TransitionType transitionType,
    super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );

              case TransitionType.slide:
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curveTween = CurveTween(curve: Curves.easeInOut);
                return SlideTransition(
                  position: animation.drive(curveTween).drive(tween),
                  child: child,
                );

              case TransitionType.scale:
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );

              case TransitionType.rotation:
                return RotationTransition(
                  turns: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );

              case TransitionType.slideUp:
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curveTween = CurveTween(curve: Curves.easeInOut);
                return SlideTransition(
                  position: animation.drive(curveTween).drive(tween),
                  child: child,
                );
            }
          },
        );
}

enum TransitionType {
  fade,
  slide,
  scale,
  rotation,
  slideUp,
}
