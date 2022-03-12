import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove.dart';

class ItemBodyProduct extends StatelessWidget {
  final ProductEntity product;
  final String revisionId;
  const ItemBodyProduct(
      {Key? key, required this.product, required this.revisionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 36, 153, 199),
              Color.fromARGB(255, 174, 222, 241),
              Color.fromARGB(255, 230, 230, 230),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[500]!,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Название товара: ' + product.name),
              const SizedBox(height: 5),
              Text('Дата записи : ' +
                  DateFormat('dd.MM.yyyy').format(product.datePublished)),
              const SizedBox(height: 5),
              Text('Цена товара: ' + product.cost.toString()),
              const SizedBox(height: 5),
              Text('Количество товара: ' + product.quantity.toString()),
              const SizedBox(height: 5),
              Text('Итог: ' + product.total.toStringAsFixed(2)),
              const SizedBox(height: 5),
              Text('Имя создателя : ' + product.userName.toString()),
            ],
          ),
        ),
        Positioned(
          right: 30.0,
          bottom: -10,
          child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  primary: const Color.fromARGB(146, 189, 5, 14),
                ),
                onPressed: () {
                  promptDialog(
                      context: context,
                      dialog: Text(
                          'Вы действительно хотите удалить товар ${product.name}?',
                          style: const TextStyle(color: Colors.black)),
                      onPressed: () {
                        BlocProvider.of<RevisionCubit>(context).deleteProducts(
                            revisionId: revisionId, product: product);
                      });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Удалить товар'),
                    Icon(Icons.cancel_outlined)
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
