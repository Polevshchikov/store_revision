import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/product_add/cubit/product_add_cubit.dart';

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
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Color.fromARGB(205, 218, 87, 0),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.qr_code_2_outlined),
                  label: Text('Сканировать'),
                ),
              )
            ],
          ),
        ),
      ),
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
  late TextEditingController _countController;
  late UserEntity user;
  late FocusNode focusName;
  late FocusNode focusCost;
  late FocusNode focusCount;
  @override
  void initState() {
    focusName = FocusNode();
    focusCost = FocusNode();
    focusCount = FocusNode();
    _nameController = TextEditingController();
    _costController = TextEditingController();
    _countController = TextEditingController();
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _countController.dispose();
    focusName.dispose();
    focusCost.dispose();
    focusCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddCubit, ProductAddState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 36),
            TextFormField(
              focusNode: focusName,
              autofocus: true,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              key: const Key('productForm_nameInput_textField'),
              onChanged: (name) =>
                  context.read<ProductAddCubit>().nameChanged(name),
              keyboardType: TextInputType.name,
              onFieldSubmitted: (term) {
                focusName.unfocus();
                FocusScope.of(context).requestFocus(focusCost);
              },
              decoration: InputDecoration(
                labelText: 'Название товара',
                helperText: '',
                errorText: state.name.invalid ? 'invalid name' : null,
              ),
            ),
            TextFormField(
              focusNode: focusCost,
              controller: _costController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.datetime,
              key: const Key('productForm_costInput_textField'),
              onChanged: (cost) =>
                  context.read<ProductAddCubit>().costChanged(cost),
              onFieldSubmitted: (term) {
                focusCost.unfocus();
                FocusScope.of(context).requestFocus(focusCount);
              },
              decoration: InputDecoration(
                labelText: 'Цена товара',
                helperText: '',
                errorText: state.cost.invalid ? 'invalid cost' : null,
              ),
            ),
            TextFormField(
              focusNode: focusCount,
              controller: _countController,
              keyboardType: TextInputType.number,
              key: const Key('productForm_countInput_textField'),
              onChanged: (count) =>
                  context.read<ProductAddCubit>().countChanged(count),
              onFieldSubmitted: (term) {
                focusCount.unfocus();
                FocusScope.of(context).requestFocus(focusName);
              },
              decoration: InputDecoration(
                labelText: 'Количество товара',
                helperText: '',
                errorText: state.count.invalid ? 'invalid count' : null,
              ),
            ),
            _CreateRevisionButton(
              onTapButton: state.status.isValidated
                  ? () async {
                      await context.read<ProductAddCubit>().createProduct(
                            uid: user.uid,
                            revisionId: widget.revisionId,
                            userName: user.name,
                          );
                      focusCount.unfocus();
                      FocusScope.of(context).requestFocus(focusName);
                      _nameController.clear();
                      _costController.clear();
                      _countController.clear();
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _CreateRevisionButton extends StatelessWidget {
  final VoidCallback? onTapButton;

  const _CreateRevisionButton({
    Key? key,
    required this.onTapButton,
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
                      primary: Color.fromARGB(148, 196, 2, 2),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.close),
                    label: Text('Закрыть'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: Color.fromARGB(147, 5, 146, 0),
                    ),
                    onPressed: onTapButton,
                    icon: Icon(Icons.add),
                    label: const Text('PRODUCT'),
                  ),
                ],
              );
      },
    );
  }
}
