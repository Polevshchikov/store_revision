import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class GradientCastom {
  static const Gradient onePage = SweepGradient(colors: [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 35, 147, 212),
    Color.fromARGB(255, 0, 0, 0)
  ], endAngle: math.pi);

  static const Gradient twoPage = SweepGradient(colors: [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 212, 35, 153),
    Color.fromARGB(255, 0, 0, 0)
  ], endAngle: math.pi);
}
