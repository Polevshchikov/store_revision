import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/core/navigation/arguments/revision_details_arguments.dart';

class RevisionDetailsPage extends StatelessWidget {
  final RevisionDetailsArguments revisionDetailsArguments;
  const RevisionDetailsPage({Key? key, required this.revisionDetailsArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 31, 30, 30),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          vertical: 100,
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 207, 202, 202),
            Color.fromARGB(255, 182, 125, 125),
            Color.fromARGB(255, 41, 38, 38),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 173, 173, 173),
              offset: Offset(6, 6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 199, 38, 38),
              offset: Offset(-6, -6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              revisionDetailsArguments.revision.name,
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
              revisionDetailsArguments.revision.description.isEmpty
                  ? 'Нет описания'
                  : revisionDetailsArguments.revision.description,
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
              DateFormat('dd.MM.yyyy')
                  .format(revisionDetailsArguments.revision.date),
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 217, 217),
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
                    'Количество наименований: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    revisionDetailsArguments.products.length.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 18, 103, 129),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 217, 217),
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
                    'Количество сотрудников: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    revisionDetailsArguments.revision.listTrusted.length
                        .toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 18, 103, 129),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 217, 217),
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
                    revisionDetailsArguments.products
                        .fold<double>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.total)
                        .toStringAsFixed(2),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 18, 103, 129),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 25),
            // const Text(
            //   'Добавить сотрудника к ревизии, чтобы он мог добавлять товар?',
            //   style: TextStyle(
            //     color: Color.fromARGB(255, 16, 19, 207),
            //     fontSize: 14,
            //     fontWeight: FontWeight.w700,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     primary: const Color.fromARGB(255, 23, 32, 156),
            //   ),
            //   onPressed: () {},
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: const [
            //       Text('Добавить сотрудника'),
            //       SizedBox(width: 5),
            //       Icon(Icons.person_add_outlined)
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
