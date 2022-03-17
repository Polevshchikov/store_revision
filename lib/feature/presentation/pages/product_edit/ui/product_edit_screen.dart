import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/product_edit/cubit/product_edit_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late ChangeBodyToCubit _changeBodyToCubit;
  late String productName;
  late double productCost;
  late double productQuantity;
  late String revisionId;
  late String productId;
  late TextEditingController controllerName;
  late TextEditingController controllerCost;
  late TextEditingController controllerQuantity;
  late FocusNode focusName;
  late FocusNode focusCost;
  late FocusNode focusQuantity;

  @override
  void initState() {
    _changeBodyToCubit = BlocProvider.of<ChangeBodyToCubit>(context);
    revisionId = _changeBodyToCubit.state.revisionId;
    productId = _changeBodyToCubit.state.productId;
    productName = _changeBodyToCubit.state.productName;
    productCost = _changeBodyToCubit.state.productCost;
    productQuantity = _changeBodyToCubit.state.productQuantity;
    controllerName = TextEditingController();
    controllerCost = TextEditingController();
    controllerQuantity = TextEditingController();
    focusName = FocusNode();
    focusCost = FocusNode();
    focusQuantity = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerCost.dispose();
    controllerQuantity.dispose();
    focusName.dispose();
    focusCost.dispose();
    focusQuantity.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<ProductEditCubit>().resetState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 300,
        margin: const EdgeInsets.all(15),
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                            child: Text(
                          'Название: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 1, 9, 15)),
                        )),
                        const SizedBox(width: 5),
                        Flexible(
                            flex: 2,
                            child: TextFormField(
                              autofocus: true,
                              focusNode: focusName,
                              controller: controllerName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 20, bottom: 2),
                                alignLabelWithHint: true,
                                hintText: productName,
                                helperText: '',
                              ),
                              onFieldSubmitted: (term) {
                                focusName.unfocus();
                                FocusScope.of(context).requestFocus(focusCost);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                            child: Text(
                          'Цена: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 1, 9, 15)),
                        )),
                        const SizedBox(width: 5),
                        Flexible(
                            flex: 2,
                            child: TextFormField(
                              focusNode: focusCost,
                              controller: controllerCost,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]'))
                              ],
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 20, bottom: 2),
                                alignLabelWithHint: true,
                                hintText: productCost.toStringAsFixed(2),
                                helperText: '',
                              ),
                              onFieldSubmitted: (term) {
                                focusCost.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(focusQuantity);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                            child: Text(
                          'Количество: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 1, 9, 15)),
                        )),
                        const SizedBox(width: 5),
                        Flexible(
                            flex: 2,
                            child: TextFormField(
                              focusNode: focusQuantity,
                              controller: controllerQuantity,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]'))
                              ],
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 20, bottom: 2),
                                alignLabelWithHint: true,
                                hintText: productQuantity.toStringAsFixed(2),
                                helperText: '',
                              ),
                              onFieldSubmitted: (term) {
                                focusQuantity.unfocus();
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: BlocBuilder<ProductEditCubit, ProductEditState>(
                  builder: (context, state) {
                    if (state.status == Status.success) {
                      BlocProvider.of<RevisionCubit>(context)
                          .getProducts(revisionId: revisionId);

                      BlocProvider.of<ChangeBodyToCubit>(context)
                          .changeToRevision();
                    }
                    return state.status == Status.waiting
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  primary:
                                      const Color.fromARGB(255, 255, 81, 0),
                                ),
                                onPressed: () =>
                                    BlocProvider.of<ChangeBodyToCubit>(context)
                                        .changeToRevision(),
                                child: const Text('Отменить'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  primary:
                                      const Color.fromARGB(255, 0, 167, 14),
                                ),
                                onPressed: () async {
                                  await context
                                      .read<ProductEditCubit>()
                                      .editProduct(
                                        revisionId: revisionId,
                                        productCost: controllerCost.text,
                                        productId: productId,
                                        productName: controllerName.text,
                                        productQuantity:
                                            controllerQuantity.text,
                                      );
                                },
                                child: const Text('Изменить'),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
            const Positioned(
              top: -40,
              child: Text(
                'Редактирование товара',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
