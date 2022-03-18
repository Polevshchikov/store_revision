import 'package:flutter/material.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/body_info_products.dart';

class InfoProductWidget extends StatefulWidget {
  final List<ProductEntity> products;
  const InfoProductWidget({Key? key, required this.products}) : super(key: key);

  @override
  State<InfoProductWidget> createState() => _InfoProductWidgetState();
}

class _InfoProductWidgetState extends State<InfoProductWidget> {
  bool showProductsBody = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(190, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(155, 0, 0, 0),
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
                    widget.products.length.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 54, 126),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() => showProductsBody = !showProductsBody);
              },
              child: Icon(
                showProductsBody
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
        showProductsBody
            ? BodyInfoProducts(products: widget.products)
            : const SizedBox.shrink(),
      ],
    );
  }
}
