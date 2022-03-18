import 'package:flutter/material.dart';

class BodyFooterWidget extends StatelessWidget {
  final double total;
  const BodyFooterWidget({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(230, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0),
              offset: Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Итоговая сумма: ',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              total.toStringAsFixed(2),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 54, 126),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
