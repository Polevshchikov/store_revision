import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/widgets/body_revision_card.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

class BodyRevisionWidget extends StatefulWidget {
  const BodyRevisionWidget({Key? key}) : super(key: key);

  @override
  State<BodyRevisionWidget> createState() => _BodyRevisionWidgetState();
}

class _BodyRevisionWidgetState extends State<BodyRevisionWidget> {
  late RevisionActiveListCubit _revisionActiveListCubit;
  late ChangeBodyCubit _changeBodyCubit;
  late UserEntity user;
  final scrollController = ScrollController();
  bool isShowText = true;
  String textButton = 'Новая ревизия';
  @override
  void initState() {
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    _revisionActiveListCubit =
        BlocProvider.of<RevisionActiveListCubit>(context);
    _changeBodyCubit = BlocProvider.of<ChangeBodyCubit>(context);
    _revisionActiveListCubit.getRevisions(userId: user.uid);
    scrollController.addListener(listenScrolling);
    super.initState();
  }

  void listenScrolling() {
    if (scrollController.position.pixels <= 50) {
      if (!isShowText) {
        setState(() {
          isShowText = true;
        });
        Timer(const Duration(milliseconds: 310), () {
          if (scrollController.position.pixels <= 50) {
            setState(() {
              textButton = 'Новая ревизия';
            });
          }
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
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            await _revisionActiveListCubit.getRevisions(userId: user.uid);
          },
          child: BlocBuilder<RevisionActiveListCubit, RevisionActiveListState>(
              builder: (BuildContext context, RevisionActiveListState state) {
            if (state.status == Status.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == Status.success && state.revisions.isEmpty) {
              return const Center(
                  child: Text(
                'Список пуст',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ));
            }

            if (state.status == Status.success && state.revisions.isNotEmpty) {
              final revisions = state.revisions;

              return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(top: 25),
                  itemCount: revisions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (revisions[index].listTrusted.contains(user.uid) ||
                            revisions[index].uid == user.uid)
                        ? Padding(
                            padding: index + 1 == revisions.length
                                ? const EdgeInsets.only(bottom: 60)
                                : EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MainNavigationRouteNames.revision,
                                  arguments: revisions[index],
                                ).then((_) {
                                  _revisionActiveListCubit.getRevisions(
                                      userId: user.uid);
                                  setState(() {
                                    isShowText = true;
                                    Timer(const Duration(milliseconds: 310),
                                        () {
                                      if (scrollController.position.pixels <=
                                          50) {
                                        setState(() {
                                          textButton = 'Новая ревизия';
                                        });
                                      }
                                    });
                                  });
                                });
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 40.0),
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
                                                              'Вы действительно хотите удалить ревизию: ${revisions[index].name}?',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          onPressed: () {
                                                            _revisionActiveListCubit
                                                                .deleteRevision(
                                                              revisionId:
                                                                  revisions[
                                                                          index]
                                                                      .id,
                                                              userId: user.uid,
                                                            );
                                                          });
                                                    },
                                                    backgroundColor:
                                                        const Color(0xFFFE4A49),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: 'Удалить',
                                                  ),
                                                  SlidableAction(
                                                    flex: 3,
                                                    onPressed: (context) {
                                                      _changeBodyCubit
                                                          .changeToEditRevision(
                                                        revisionId:
                                                            revisions[index].id,
                                                        revisionName:
                                                            revisions[index]
                                                                .name,
                                                        revisionDescr:
                                                            revisions[index]
                                                                .description,
                                                      );
                                                    },
                                                    backgroundColor:
                                                        const Color(0xFF21B7CA),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.edit_outlined,
                                                    label: 'Редактировать',
                                                  ),
                                                ],
                                              ),
                                              endActionPane: ActionPane(
                                                extentRatio: 0.6,
                                                dragDismissible: false,
                                                motion: const ScrollMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (context) {
                                                      promptDialog(
                                                          context: context,
                                                          dialog: const Text(
                                                            'Добавить сотрудника к ревизии, чтобы он мог вносить изменения (добавлять / удалять товар)?',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          onPressed: () {
                                                            _changeBodyCubit
                                                                .changeToAddTrusted(
                                                                    revisions[
                                                                            index]
                                                                        .id);
                                                          });
                                                    },
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            214, 12, 155, 20),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.person_add,
                                                    label:
                                                        'Добавить \nсотрудника',
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (context) {
                                                      promptDialog(
                                                          context: context,
                                                          dialog: const Text(
                                                            'Удалить сотрудника из ревизии, чтобы он не мог вносить изменения (добавлять / удалять товар)?',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          onPressed: () {
                                                            _changeBodyCubit
                                                                .changeToDeleteTrusted(
                                                                    revisions[
                                                                            index]
                                                                        .id);
                                                          });
                                                    },
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            210, 155, 81, 12),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons
                                                        .person_remove_rounded,
                                                    label:
                                                        'Удалить \nсотрудника',
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
                                                              revisions[index]
                                                                  .id,
                                                          userId: user.uid);
                                                },
                                                dialog: Text(
                                                    'Вы действительно хотите завершить ревизию: ${revisions[index].name}?',
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              );
                                            },
                                            icon: const Icon(Icons
                                                .sim_card_download_outlined),
                                            label:
                                                const Text('Завершить ревизию'),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  });
            }
            return const PlugScreen();
          }),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: GestureDetector(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  .pushNamed(MainNavigationRouteNames.revisionCreate)
                  .then((_) => context
                      .read<RevisionActiveListCubit>()
                      .getRevisions(userId: user.uid));
            },
          ),
        ),
      ],
    );
  }
}
