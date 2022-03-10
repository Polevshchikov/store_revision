import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/product_add/cubit/product_add_cubit.dart';
import 'package:store_revision/feature/presentation/pages/product_add/ui/widgets/product_field_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';

class ProductAddWidget extends StatelessWidget {
  final RevisionEntity revision;
  const ProductAddWidget({Key? key, required this.revision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              _ProductFormWidget(revisionId: revision.id),
              const Align(
                alignment: Alignment.topRight,
                child: _QrScannerWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _QrScannerWidget extends StatefulWidget {
  const _QrScannerWidget({Key? key}) : super(key: key);

  @override
  _QrScannerWidgetState createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<_QrScannerWidget> {
  String qrCode = '';

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Отменить',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: const Color.fromARGB(205, 218, 87, 0),
      ),
      onPressed: () async {
        await scanQRCode();
        if (qrCode != '-1' && qrCode.isNotEmpty) {
          context.read<ProductAddCubit>().scannChanged(qrCode);
        }
      },
      icon: const Icon(Icons.qr_code_2_outlined),
      label: const Text('Сканировать'),
    );
  }
}

class _ProductFormWidget extends StatefulWidget {
  final String revisionId;
  const _ProductFormWidget({Key? key, required this.revisionId})
      : super(key: key);

  @override
  _ProductFormWidgetState createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<_ProductFormWidget> {
  late TextEditingController _nameController;
  late TextEditingController _costController;
  late TextEditingController _quantityController;
  late UserEntity user;
  late FocusNode focusName;
  late FocusNode focusCost;
  late FocusNode focusQuantity;
  @override
  void initState() {
    focusName = FocusNode();
    focusCost = FocusNode();
    focusQuantity = FocusNode();
    _nameController = TextEditingController();
    _costController = TextEditingController();
    _quantityController = TextEditingController();
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _quantityController.dispose();
    focusName.dispose();
    focusCost.dispose();
    focusQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        BlocBuilder<ProductAddCubit, ProductAddState>(
          buildWhen: (previous, current) =>
              ((previous.scannQr != current.scannQr) ||
                  (previous.name != current.name)),
          builder: (context, state) {
            if (state.scannQr.isNotEmpty) {
              context.read<ProductAddCubit>().nameChanged(state.scannQr);
              _nameController.value = TextEditingValue(
                text: state.scannQr,
                selection: TextSelection.fromPosition(
                    TextPosition(offset: state.scannQr.length)),
              );
            }
            return ProductFieldWidget(
              errorText: state.name.invalid ? 'Пустое поле' : null,
              controllerWidget: _nameController,
              focusWidget: focusName,
              focusWidgetNext: focusCost,
              keyWidget: const Key('productForm_nameInput_textField'),
              labelText: 'Название товара',
              typeField: TypeField.name,
            );
          },
        ),
        BlocBuilder<ProductAddCubit, ProductAddState>(
          buildWhen: (previous, current) => previous.cost != current.cost,
          builder: (context, state) {
            return ProductFieldWidget(
              errorText: state.cost.invalid ? 'Некорректно указана цена' : null,
              controllerWidget: _costController,
              focusWidget: focusCost,
              focusWidgetNext: focusQuantity,
              keyWidget: const Key('productForm_costInput_textField'),
              labelText: 'Цена товара',
              typeField: TypeField.cost,
            );
          },
        ),
        BlocBuilder<ProductAddCubit, ProductAddState>(
          buildWhen: (previous, current) =>
              previous.quantity != current.quantity,
          builder: (context, state) {
            return ProductFieldWidget(
              errorText: state.quantity.invalid
                  ? 'Некорректно указано количество'
                  : null,
              controllerWidget: _quantityController,
              focusWidget: focusQuantity,
              focusWidgetNext: focusName,
              keyWidget: const Key('productForm_quantityInput_textField'),
              labelText: 'Количество товара',
              typeField: TypeField.quantity,
            );
          },
        ),
        BlocBuilder<ProductAddCubit, ProductAddState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return _CreateProductButton(
              onTapButtonCreate: state.status.isValidated
                  ? () async {
                      await context.read<ProductAddCubit>().createProduct(
                            uid: user.uid,
                            revisionId: widget.revisionId,
                            userName: user.name,
                            productName: _nameController.text,
                            productCost: double.parse(_costController.text
                                .replaceAll(RegExp(','), '.')),
                            productQuantity: double.parse(_quantityController
                                .text
                                .replaceAll(RegExp(','), '.')),
                          );
                      await context
                          .read<RevisionCubit>()
                          .getProducts(revisionId: widget.revisionId);
                      focusQuantity.unfocus();
                      FocusScope.of(context).requestFocus(focusName);
                      _nameController.clear();
                      _costController.clear();
                      _quantityController.clear();
                    }
                  : null,
              onTapButtonClose: () async {
                await context
                    .read<RevisionCubit>()
                    .getProducts(revisionId: widget.revisionId);
                context.read<ChangeBodyToCubit>().changeToRevision();
                context.read<ProductAddCubit>().resetState();
              },
            );
          },
        ),
      ],
    );
  }
}

class _CreateProductButton extends StatelessWidget {
  final VoidCallback? onTapButtonCreate;
  final VoidCallback? onTapButtonClose;

  const _CreateProductButton({
    Key? key,
    required this.onTapButtonCreate,
    required this.onTapButtonClose,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddCubit, ProductAddState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const LinearProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: const Color.fromARGB(148, 196, 2, 2),
                    ),
                    onPressed: onTapButtonClose,
                    icon: const Icon(Icons.close),
                    label: const Text('Закрыть'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: const Color.fromARGB(147, 5, 146, 0),
                    ),
                    onPressed: onTapButtonCreate,
                    icon: const Icon(Icons.add),
                    label: const Text('PRODUCT'),
                  ),
                ],
              );
      },
    );
  }
}
