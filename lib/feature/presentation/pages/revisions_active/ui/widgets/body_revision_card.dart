import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class BodyRevisionCard extends StatelessWidget {
  final RevisionEntity revision;
  const BodyRevisionCard({Key? key, required this.revision}) : super(key: key);

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
          RichText(
            text: TextSpan(
              text: 'Название: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: revision.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: 'Описание: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: revision.description,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: 'Дата: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: DateFormat('dd.MM.yyyy').format(revision.date),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: 'Количество наименований: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: revision.listProducts.length.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: 'Общая сумма: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: revision.total.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
