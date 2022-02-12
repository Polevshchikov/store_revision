import 'dart:math';

import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: const Center(
        child: Text('title ' 'ForumScreen'),
      ),
    );
  }
}
