import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class BodyArchiveCard extends StatelessWidget {
  final RevisionEntity revision;
  final bool isAccess;
  const BodyArchiveCard(
      {Key? key, required this.revision, required this.isAccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(236, 236, 236, 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Название: ' + revision.name),
          const SizedBox(height: 5),
          Text('Описание: ' + revision.description),
          const SizedBox(height: 5),
          Text('Дата: ' + DateFormat('dd.MM.yyyy').format(revision.date)),
          const SizedBox(height: 5),
          Text('Количество наименований: ' +
              revision.listProducts.length.toString()),
          const SizedBox(height: 5),
          isAccess
              ? Text('Общая сумма: ' + revision.total.toStringAsFixed(2))
              : const Text(
                  'Вы принимали участие',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
        ],
      ),
    );
  }
}
