import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/product_add/ui/product_add_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionScreen extends StatelessWidget {
  final RevisionEntity revision;
  const RevisionScreen({Key? key, required this.revision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RevisionCubit>().getProducts(revisionId: revision.id);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 6,
                ),
                child: SvgPicture.asset(AppResources.addTrophyIcon),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(revision.name),
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
                  await context
                      .read<RevisionCubit>()
                      .getProducts(revisionId: revision.id);
                },
                child: BlocBuilder<RevisionCubit, RevisionState>(
                    builder: (BuildContext context, RevisionState state) {
                  if (state.status == Status.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.status == Status.success &&
                      state.products.isEmpty) {
                    return Text('ПУСТО!!');
                  }

                  if (state.status == Status.success &&
                      state.products.isNotEmpty) {
                    final _products = state.products;

                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemCount: _products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[500]!,
                                  offset: const Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_products[index].name),
                                SizedBox(height: 5),
                                Text(_products[index].datePublished.toString()),
                                SizedBox(height: 5),
                                Text(_products[index].cost.toString()),
                                SizedBox(height: 5),
                                Text(_products[index].count.toString()),
                                SizedBox(height: 5),
                                Text(_products[index].total.toString()),
                                SizedBox(height: 5),
                                Text(_products[index].userName.toString()),
                              ],
                            ),
                          );
                        });
                  }
                  return Text(
                      'AppLocalizations.of(context).screenInitialization');
                }),
              ),
              ProductAddWidget(revision: revision),
            ],
          );
        }),
      ),
    );
  }
}
