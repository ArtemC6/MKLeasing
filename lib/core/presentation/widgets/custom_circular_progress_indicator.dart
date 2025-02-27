import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final int min;
  final int max;
  final int current;
  final Widget child;

  CustomCircularProgressIndicator({
    required this.min,
    required this.max,
    required this.current,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          child: CircularPercentIndicator(
        radius: 35.0,
        animation: true,
        animationDuration: 1000,
        lineWidth: 4.0,
        animateFromLastPercent: true,
        percent: current == 0
            ? 0
            : current <= min
                ? 1 / max * ((current < max) ? current + 1 : current)
                : 1 / max * min,
        circularStrokeCap: CircularStrokeCap.butt,
        rotateLinearGradient: true,
        backgroundColor: Colors.transparent,
        progressColor: Colors.red,
      )),
      Positioned(
          child: CircularPercentIndicator(
              radius: 35.0,
              animation: true,
              animationDuration: 1000,
              lineWidth: 4.0,
              animateFromLastPercent: true,
              percent: current == 0
                  ? 0
                  : current >= min
                      ? 1 /
                          max *
                          (((current < max) ? current + 1 : current) - min)
                      : 0,
              circularStrokeCap: CircularStrokeCap.butt,
              rotateLinearGradient: true,
              backgroundColor: Colors.transparent,
              progressColor: Colors.green,
              startAngle: 360 / max * min,
              center: child))
    ]);
  }
}
