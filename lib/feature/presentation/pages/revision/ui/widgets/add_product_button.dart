import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<ChangeBodyToCubit>().changeToAddProduct();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF242424),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
            Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  gradient: const SweepGradient(
                      center: Alignment.center,
                      colors: [
                        Color.fromARGB(200, 166, 255, 0),
                        Color.fromARGB(200, 13, 209, 160),
                        Color.fromARGB(200, 186, 13, 209),
                        Color.fromARGB(200, 115, 88, 233)
                      ],
                      endAngle: 5,
                      startAngle: 1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.white24,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Center(
                    child: Text(
                  'Товар',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))),
          ],
        ));
  }
}
