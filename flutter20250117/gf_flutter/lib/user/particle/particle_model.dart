import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum ParticleOffsetProps { x, y }

class ParticleModel {
  late MovieTween tween;
  late double size;
  late Duration duration;
  late Duration startTime;
  Random random;

  ParticleModel(this.random) {
    _restart();
    _shuffle();
  }

  _restart() {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);

    tween = MovieTween()
      ..tween(ParticleOffsetProps.x, startPosition.dx.tweenTo(endPosition.dx),
          duration: const Duration(milliseconds: 20))
      ..tween(ParticleOffsetProps.y, startPosition.dy.tweenTo(endPosition.dy),
          duration: const Duration(milliseconds: 20));

    duration = 3000.milliseconds + random.nextInt(6000).milliseconds;
    startTime = DateTime.now().duration();
    size = 0.1 + random.nextDouble() * 0.01;//背景粒子得大小修改,前边得整数部分即可
  }

  void _shuffle() {
    startTime -= (random.nextDouble() * duration.inMilliseconds)
        .round()
        .milliseconds;
  }

  checkIfParticleNeedsToBeRestarted() {
    if (progress() == 1.0) {
      _restart();
    }
  }

  double progress() {
    return ((DateTime.now().duration() - startTime) / duration)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}
