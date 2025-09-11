import 'package:flutter/material.dart';
import '/user/particle/particle_widget.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _ColorTween { color1, color2 }


class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        _ColorTween.color1,
        const Color(0xffD38312).tweenTo(Colors.lightBlue.shade900),
        duration: 3.seconds,
      )
      ..tween(
        _ColorTween.color2,
        const Color(0xffA83279).tweenTo(Colors.blue.shade600),
        duration: 3.seconds,
      );

    return MirrorAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    value.get<Color>(_ColorTween.color1),
                    value.get<Color>(_ColorTween.color2)
                  ])),
        );
      },
    );
  }
}