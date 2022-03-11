import 'package:flutter/material.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';

PreferredSizeWidget homeAppbar(
    {required BuildContext context,
    required String title,
    required Gradient gradient}) {
  return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
      ),
      elevation: 10,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10, top: 12),
          child: GestureDetector(
            child: Container(
              width: 55,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 2,
                  color: Colors.white24,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                  child: Icon(
                Icons.person_pin,
                color: Colors.white,
              )),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                MainNavigationRouteNames.profile,
              );
            },
          ),
        ),
      ]);
}
