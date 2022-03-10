import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/product_add/cubit/product_add_cubit.dart';

enum TypeField { name, cost, quantity }

class ProductFieldWidget extends StatelessWidget {
  final FocusNode focusWidget;
  final FocusNode focusWidgetNext;
  final TextEditingController controllerWidget;
  final Key keyWidget;
  final String? errorText;
  final String labelText;
  final TypeField typeField;
  const ProductFieldWidget(
      {Key? key,
      required this.focusWidget,
      required this.focusWidgetNext,
      required this.controllerWidget,
      required this.keyWidget,
      this.errorText,
      required this.labelText,
      required this.typeField})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusWidget,
      autofocus: true,
      controller: controllerWidget,
      textInputAction: TextInputAction.next,
      key: keyWidget,
      inputFormatters:
          (typeField == TypeField.cost || typeField == TypeField.quantity)
              ? [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ]
              : null,
      keyboardType:
          (typeField == TypeField.cost || typeField == TypeField.quantity)
              ? TextInputType.datetime
              : TextInputType.name,
      onChanged: typeField == TypeField.name
          ? (name) => context.read<ProductAddCubit>().nameChanged(name)
          : typeField == TypeField.cost
              ? (cost) => context.read<ProductAddCubit>().costChanged(cost)
              : (quantity) =>
                  context.read<ProductAddCubit>().quantityChanged(quantity),
      onFieldSubmitted: (term) {
        focusWidget.unfocus();
        FocusScope.of(context).requestFocus(focusWidgetNext);
      },
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}
