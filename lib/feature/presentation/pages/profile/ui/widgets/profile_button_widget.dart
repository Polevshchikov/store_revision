import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final Widget widget;
  final Function onTap;
  const ProfileButtonWidget(
      {Key? key, required this.widget, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 2,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
