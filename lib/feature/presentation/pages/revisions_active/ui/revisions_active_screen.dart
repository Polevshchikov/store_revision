import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/widgets/body_revision_card.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionActiveScreen extends StatefulWidget {
  const RevisionActiveScreen({Key? key}) : super(key: key);

  @override
  State<RevisionActiveScreen> createState() => _RevisionActiveScreenState();
}

class _RevisionActiveScreenState extends State<RevisionActiveScreen> {
  late RevisionActiveListCubit _revisionActiveListCubit;
  late UserEntity user;
  final scrollController = ScrollController();
  bool isShowText = true;
  String textButton = 'Новая ревизия';
  @override
  void initState() {
    context.read<RevisionActiveListCubit>().getRevisions();
    _revisionActiveListCubit =
        BlocProvider.of<RevisionActiveListCubit>(context);
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    scrollController.addListener(listenScrolling);
    super.initState();
  }

  void listenScrolling() {
    if (scrollController.position.pixels <= 50) {
      if (!isShowText) {
        setState(() {
          isShowText = true;
        });
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            textButton = 'Новая ревизия';
          });
        });
      }
    } else {
      if (isShowText) {
        setState(() {
          isShowText = false;
          textButton = '';
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              await _revisionActiveListCubit.getRevisions();
            },
            child:
                BlocBuilder<RevisionActiveListCubit, RevisionActiveListState>(
                    builder:
                        (BuildContext context, RevisionActiveListState state) {
              if (state.status == Status.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == Status.success && state.revisions.isEmpty) {
                return const Text('ПУСТО!!');
              }

              if (state.status == Status.success &&
                  state.revisions.isNotEmpty) {
                final revisions = state.revisions;

                return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(top: 35),
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
                            ).then(
                                (_) => _revisionActiveListCubit.getRevisions());
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
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
                                  child: (revisions[index].uid == user.uid)
                                      ? Slidable(
                                          key: ValueKey(index),
                                          startActionPane: ActionPane(
                                            extentRatio: 0.6,
                                            dragDismissible: false,
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                flex: 2,
                                                onPressed: (context) {
                                                  promptDialog(
                                                      context: context,
                                                      dialog: Text(
                                                          'Вы действительно хотите удалить товар ${revisions[index].name} ?',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                      onPressed: () {
                                                        _revisionActiveListCubit
                                                            .deleteRevision(
                                                          revisionId:
                                                              revisions[index]
                                                                  .id,
                                                          userId: user.uid,
                                                        );
                                                      });
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
                                                  // promptRemoveRevision(
                                                  //     context: context,
                                                  //     revisionId: revisions[index].id,
                                                  //     userId: user.uid,
                                                  //     title: revisions[index].name);
                                                },
                                                backgroundColor:
                                                    const Color(0xFF21B7CA),
                                                foregroundColor: Colors.white,
                                                icon: Icons.edit_outlined,
                                                label: 'Редактировать',
                                              ),
                                            ],
                                          ),
                                          child: BodyRevisionCard(
                                              revision: revisions[index]),
                                        )
                                      : BodyRevisionCard(
                                          revision: revisions[index]),
                                ),
                              ),
                              (revisions[index].uid == user.uid)
                                  ? Positioned(
                                      right: 6.0,
                                      bottom: 12,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          primary: const Color.fromARGB(
                                              146, 187, 17, 144),
                                        ),
                                        onPressed: () {
                                          promptDialog(
                                            context: context,
                                            onPressed: () {
                                              context
                                                  .read<
                                                      RevisionActiveListCubit>()
                                                  .closeRevision(
                                                      revisionId:
                                                          revisions[index].id);
                                            },
                                            dialog: Text(
                                                'Вы действительно хотите завершить ревизию: ${revisions[index].name}?',
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.sim_card_download_outlined),
                                        label: const Text('Закрыть ревизию'),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const Text(
                  'AppLocalizations.of(context).screenInitialization');
            }),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: isShowText ? 180 : 45,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const SweepGradient(
                      center: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 5, 119, 1),
                        Color.fromARGB(255, 0, 161, 161),
                        Color.fromARGB(255, 152, 30, 168),
                        Color.fromARGB(255, 86, 60, 202)
                      ],
                      endAngle: 3.3,
                      startAngle: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                  border: Border.all(
                    width: 2,
                    color: Colors.white24,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(172, 255, 1, 1),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                        border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(172, 0, 0, 0),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      textButton,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteNames.addRevision)
                    .then((_) =>
                        context.read<RevisionActiveListCubit>().getRevisions());
              },
            ),
          ),
        ],
      ),
    );
  }
}
