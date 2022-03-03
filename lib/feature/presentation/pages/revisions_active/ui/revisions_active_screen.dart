import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/widgets/button_add_revision.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove_revision.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionActiveScreen extends StatelessWidget {
  const RevisionActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RevisionActiveListCubit>().getRevisions();
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 36, 153, 199),
          Color.fromARGB(255, 174, 222, 241),
          Color.fromARGB(255, 230, 230, 230),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await context.read<RevisionActiveListCubit>().getRevisions();
            },
            child:
                BlocBuilder<RevisionActiveListCubit, RevisionActiveListState>(
                    builder:
                        (BuildContext context, RevisionActiveListState state) {
              if (state.status == Status.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == Status.success && state.revisions.isEmpty) {
                return Text('ПУСТО!!');
              }

              if (state.status == Status.success &&
                  state.revisions.isNotEmpty) {
                final revisions = state.revisions;

                return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    itemCount: revisions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: index + 1 == revisions.length
                            ? const EdgeInsets.only(bottom: 60)
                            : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MainNavigationRouteNames.revision,
                              arguments: revisions[index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
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
                                  child: Slidable(
                                    key: ValueKey(index),
                                    startActionPane: ActionPane(
                                      extentRatio: 0.6,
                                      dragDismissible: false,
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 2,
                                          onPressed: (context) {
                                            promptRemoveRevision(
                                                context: context,
                                                revisionId: revisions[index].id,
                                                userId: user.uid,
                                                title: revisions[index].name);
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Удалить',
                                        ),
                                        SlidableAction(
                                          flex: 3,
                                          onPressed: (context) {
                                            promptRemoveRevision(
                                                context: context,
                                                revisionId: revisions[index].id,
                                                userId: user.uid,
                                                title: revisions[index].name);
                                          },
                                          backgroundColor:
                                              const Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit_outlined,
                                          label: 'Редактировать',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(236, 236, 236, 0.8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Название: ' +
                                              revisions[index].name),
                                          SizedBox(height: 5),
                                          Text('Дата: ' +
                                              revisions[index].date.toString()),
                                          SizedBox(height: 5),
                                          Text('Описание: ' +
                                              revisions[index].description),
                                          SizedBox(height: 5),
                                          Text('Количество товара: ' +
                                              revisions[index]
                                                  .listProducts
                                                  .length
                                                  .toString()),
                                          SizedBox(height: 5),
                                          Text('Статус: ' +
                                              revisions[index]
                                                  .isClosed
                                                  .toString()),
                                          SizedBox(height: 5),
                                          Text('Общая сумма: ' +
                                              revisions[index]
                                                  .total
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 6.0,
                                  top: -30,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      primary:
                                          Color.fromARGB(146, 187, 17, 144),
                                    ),
                                    onPressed: () async {
                                      await context
                                          .read<RevisionActiveListCubit>()
                                          .closeRevision(
                                              revisionId: revisions[index].id);
                                    },
                                    icon:
                                        Icon(Icons.sim_card_download_outlined),
                                    label: Text('Закрыть ревизию'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Text('AppLocalizations.of(context).screenInitialization');
            }),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: ButtonAddRevision(),
            ),
          ),
        ],
      ),
    );
  }
}
