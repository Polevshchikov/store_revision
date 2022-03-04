import 'package:flutter/material.dart';

/// Всплывающая подсказка подтверждения удалить запись из списка
void promptRemove({
  required BuildContext context,
  required String title,
  required Function onPressed,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Вы уверены что хотите удалить $title ?',
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
