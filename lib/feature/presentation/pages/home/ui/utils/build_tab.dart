import 'package:flutter/widgets.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';

Widget buildTab(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return tabGroups[currentIndex];
    case 1:
      return tabGroups[currentIndex];
    default:
      return const SizedBox.shrink();
  }
}
