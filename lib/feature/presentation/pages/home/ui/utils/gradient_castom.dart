import 'package:flutter/widgets.dart';
import 'dart:math' as math;

gradientCastom() {
  return const SweepGradient(colors: [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 35, 147, 212),
    Color.fromARGB(255, 0, 0, 0)
  ], endAngle: math.pi);
}
