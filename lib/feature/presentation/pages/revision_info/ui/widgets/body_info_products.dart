import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

class BodyInfoProducts extends StatelessWidget {
  final List<ProductEntity> products;
  const BodyInfoProducts({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(57, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: products.isEmpty
          ? const Center(
              child: Text(
              'Список пользователей пуст',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 27, 187, 126),
                      Color.fromARGB(255, 152, 204, 180),
                      Color.fromARGB(255, 230, 230, 230),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Название товара: ' + products[index].name),
                      const SizedBox(height: 5),
                      Text('Дата записи : ' +
                          DateFormat('dd.MM.yyyy')
                              .format(products[index].datePublished)),
                      const SizedBox(height: 5),
                      Text('Цена товара: ' + products[index].cost.toString()),
                      const SizedBox(height: 5),
                      Text('Количество товара: ' +
                          products[index].quantity.toString()),
                      const SizedBox(height: 5),
                      Text('Итог: ' + products[index].total.toStringAsFixed(2)),
                      const SizedBox(height: 5),
                      Text('Имя сотрудника : ' +
                          products[index].userName.toString()),
                    ],
                  ),
                );
              }),
    );
  }
}
