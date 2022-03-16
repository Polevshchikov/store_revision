import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  final VoidCallback? onTapButtonCreate;
  final VoidCallback? onTapButtonClose;
  final TypeButton typeButton;

  const ButtonScreen({
    Key? key,
    required this.onTapButtonCreate,
    required this.onTapButtonClose,
    required this.typeButton,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: typeButton == TypeButton.add
                ? const Color.fromARGB(148, 196, 2, 2)
                : const Color.fromARGB(148, 39, 93, 143),
          ),
          onPressed: onTapButtonClose,
          icon: const Icon(Icons.close),
          label: const Text('Отменить'),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: typeButton == TypeButton.add
                ? const Color.fromARGB(147, 5, 146, 0)
                : const Color.fromARGB(148, 196, 2, 2),
          ),
          onPressed: onTapButtonCreate,
          icon: Icon(typeButton == TypeButton.add ? Icons.add : Icons.remove),
          label: Text(
            typeButton == TypeButton.add ? 'Добавить' : 'Удалить',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

enum TypeButton { add, delete }
