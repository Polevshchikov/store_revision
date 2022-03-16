import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlugScreen extends StatelessWidget {
  const PlugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: SweepGradient(colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 158, 0, 0),
                      Color.fromARGB(255, 0, 0, 0)
                    ], endAngle: math.pi),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: SweepGradient(colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 158, 0, 0),
                      Color.fromARGB(255, 0, 0, 0)
                    ], endAngle: math.pi * 2, startAngle: math.pi),
                  ),
                ),
              ),
            ],
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                  child: Text(
                'Произошел сбой',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
