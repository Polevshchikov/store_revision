import 'package:flutter/material.dart';

/// Всплывающая подсказка подтверждения об изменении записи из списка
void promptDialog({
  required BuildContext context,
  required Widget dialog,
  required Function onPressed,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: dialog,
            elevation: 10,
            backgroundColor: const Color.fromARGB(214, 255, 255, 255),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DecoratedBox(
                    decoration: _decorationText(),
                    child: TextButton(
                      onPressed: () {
                        onPressed();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Да',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: _decorationText(),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Нет',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]);
      });
}

Decoration _decorationText() {
  return const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(180, 0, 143, 179),
      Color.fromARGB(180, 52, 114, 150),
      Color.fromARGB(180, 230, 230, 230),
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 0, 0, 0),
        offset: Offset(4, 4),
        blurRadius: 15,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(-4, -4),
        blurRadius: 15,
        spreadRadius: 1,
      ),
    ],
  );
}
