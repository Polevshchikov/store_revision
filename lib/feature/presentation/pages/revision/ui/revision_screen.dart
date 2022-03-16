import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/product_add/ui/product_add_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/utils/revision_appbar.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/widgets/add_product_button.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/widgets/item_body_product.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

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
        return BlocBuilder<RevisionCubit, RevisionState>(
            builder: (BuildContext context, RevisionState state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: (changeBodytate is ShowRevisionState)
                ? const AddProductButton()
                : null,
            appBar: revisionAppbar(
                context: context,
                revision: widget.revision,
                products: state.products),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 206, 147, 216),
                  Color.fromARGB(255, 241, 184, 11),
                  Color.fromARGB(255, 4, 105, 97),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  RefreshIndicator(
                    displacement: 140,
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
                        return const Center(
                            child: Text(
                          'Список пуст',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ));
                      }

                      if (state.status == Status.success &&
                          state.products.isNotEmpty) {
                        final _products = state.products;

                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            itemCount: _products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(top: 100)
                                    : index == _products.length - 1
                                        ? const EdgeInsets.only(bottom: 120)
                                        : EdgeInsets.zero,
                                child: ItemBodyProduct(
                                  product: _products[index],
                                  revisionId: widget.revision.id,
                                ),
                              );
                            });
                      }
                      return const PlugScreen();
                    }),
                  ),
                  (changeBodytate is ShowRevisionState)
                      ? const SizedBox.shrink()
                      : ProductAddWidget(revision: widget.revision),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
