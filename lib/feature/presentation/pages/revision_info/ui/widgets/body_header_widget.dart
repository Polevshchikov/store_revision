import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class BodyHeaderWidget extends StatelessWidget {
  final RevisionEntity revision;
  const BodyHeaderWidget({Key? key, required this.revision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Название ревизии:',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            revision.name,
            style: const TextStyle(
              color: Color.fromARGB(255, 201, 44, 135),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Описание ревизии:',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            revision.description.isEmpty
                ? 'Нет описания'
                : revision.description,
            style: const TextStyle(
              color: Color.fromARGB(255, 201, 44, 135),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Дата создания ревизии:',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            DateFormat('dd.MM.yyyy').format(revision.date),
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
