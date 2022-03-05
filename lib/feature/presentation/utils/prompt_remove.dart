import 'package:flutter/material.dart';

/// Всплывающая подсказка подтверждения удалить запись из списка
void promptDialog({
  required BuildContext context,
  required String dialog,
  required Function onPressed,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              dialog,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      onPressed();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Да',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Нет',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ]);
      });
}
