import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:store_revision/common/app_resources.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                        Color.fromARGB(255, 152, 182, 209),
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
                        Color.fromARGB(255, 152, 182, 209),
                        Color.fromARGB(255, 0, 0, 0)
                      ], endAngle: math.pi * 2, startAngle: math.pi),
                    ),
                  ),
                ),
              ],
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: Center(
                    child: Image.asset(
                  AppResources.logoApp,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
