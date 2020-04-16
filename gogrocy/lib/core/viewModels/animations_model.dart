import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/awesome_animation_view.dart';

class AnimationsModel {
  final Animation<double> womanScaleAnimation;
  final Animation<double> awesomeTextScaleAnimation;
  final Animation<double> formFadeAnimation;
  final AnimationController controller;

  static AwesomeAnimationView awesomeAnimationView =
      locator<AwesomeAnimationView>();

  AnimationsModel({
    @required this.controller,
  })  : womanScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.3, curve: Curves.easeOut),
          ),
        ),
        awesomeTextScaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.3, curve: Curves.easeOut),
          ),
        ),
        formFadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        );
}
