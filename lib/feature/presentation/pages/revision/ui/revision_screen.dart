import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/product_add/ui/product_add_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionScreen extends StatefulWidget {
  final RevisionEntity revision;
  const RevisionScreen({Key? key, required this.revision}) : super(key: key);

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  late RevisionCubit _revisionCubit;

  @override
  void initState() {
    context.read<RevisionCubit>().getProducts(revisionId: widget.revision.id);
    _revisionCubit = BlocProvider.of<RevisionCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeBodyToCubit, ChangeBodyToState>(
      builder: (context, changeBodytate) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: (changeBodytate is ShowRevisionState)
              ? SizedBox(
                  width: 54,
                  height: 54,
                  child: GestureDetector(
                    onTap: () {
                      context.read<ChangeBodyToCubit>().changeToAddProduct();
                    },
                    child: Container(
                      height: 54,
                      width: 54,
                      decoration: const BoxDecoration(
                        color: AppColors.blackColorAddTrophy,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColorApp,
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<ChangeBodyToCubit>()
                              .changeToAddProduct();
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 6,
                            ),
                            child: Icon(Icons.add_circle_outline_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          appBar: AppBar(
            title: Text(
              widget.revision.name,
            ),
            centerTitle: false,
            actions: const [
              SizedBox(width: 5),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple[200]!, Colors.amber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            height: double.infinity,
            width: double.infinity,
            child: BlocBuilder<RevisionCubit, RevisionState>(
                builder: (BuildContext context, RevisionState state) {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await _revisionCubit.getProducts(
                          revisionId: widget.revision.id);
                    },
                    child: BlocBuilder<RevisionCubit, RevisionState>(
                        builder: (BuildContext context, RevisionState state) {
                      if (state.status == Status.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.status == Status.success &&
                          state.products.isEmpty) {
                        return const Text('ПУСТО!!');
                      }

                      if (state.status == Status.success &&
                          state.products.isNotEmpty) {
                        final _products = state.products;

                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            itemCount: _products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(20),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Название товара: ' +
                                            _products[index].name),
                                        const SizedBox(height: 5),
                                        Text('Дата записи : ' +
                                            DateFormat('dd.MM.yyyy').format(
                                                _products[index]
                                                    .datePublished)),
                                        const SizedBox(height: 5),
                                        Text('Цена товара: ' +
                                            _products[index].cost.toString()),
                                        const SizedBox(height: 5),
                                        Text('Количество товара: ' +
                                            _products[index]
                                                .quantity
                                                .toString()),
                                        const SizedBox(height: 5),
                                        Text('Итог: ' +
                                            _products[index]
                                                .total
                                                .toStringAsFixed(2)),
                                        const SizedBox(height: 5),
                                        Text('Имя создателя : ' +
                                            _products[index]
                                                .userName
                                                .toString()),
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            primary: const Color.fromARGB(
                                                146, 189, 5, 14),
                                          ),
                                          onPressed: () {
                                            promptDialog(
                                                context: context,
                                                dialog:
                                                    'Вы действительно хотите удалить товар ${_products[index].name} ?',
                                                onPressed: () {
                                                  _revisionCubit.deleteProducts(
                                                      revisionId:
                                                          widget.revision.id,
                                                      product:
                                                          _products[index]);
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
                            });
                      }
                      return const Text(
                          'AppLocalizations.of(context).screenInitialization');
                    }),
                  ),
                  (changeBodytate is ShowRevisionState)
                      ? const SizedBox.shrink()
                      : ProductAddWidget(revision: widget.revision),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
