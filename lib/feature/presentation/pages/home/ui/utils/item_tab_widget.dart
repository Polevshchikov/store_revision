import 'package:flutter/material.dart';

class ItemTabWidget extends StatelessWidget {
  final double tabWidth;
  final int actionIndex;
  final Color? colorBorder;
  final Widget childTab;
  final VoidCallback callback;
  const ItemTabWidget(
      {Key? key,
      required this.tabWidth,
      required this.actionIndex,
      required this.colorBorder,
      required this.childTab,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: SizedBox(
        height: 79,
        width: tabWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 3.29,
              color: colorBorder,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24.86,
              ),
              child: childTab,
            ),
          ],
        ),
      ),
    );
  }
}
