import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/api/pdf_api.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/archive/cubit/archive_cubit.dart';
import 'package:store_revision/feature/presentation/pages/archive/cubit/revision_pdf_cubit.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/utils/prompt_remove.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'dart:math' as math;

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  late ArchiveCubit _archiveCubit;
  late RevisionPdfCubit _revisionPdfCubit;
  late UserEntity user;
  @override
  void initState() {
    context.read<ArchiveCubit>().getRevisions();
    _archiveCubit = BlocProvider.of<ArchiveCubit>(context);
    _revisionPdfCubit = BlocProvider.of<RevisionPdfCubit>(context);
    user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: SweepGradient(
          center: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 97, 187, 240),
            Color.fromARGB(255, 58, 6, 6),
            Color.fromARGB(255, 212, 83, 195),
            Color.fromARGB(255, 207, 197, 57),
          ],
          endAngle: math.pi * 2,
          startAngle: math.pi,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: RefreshIndicator(
        onRefresh: () async {
          await _archiveCubit.getRevisions();
        },
        child: BlocBuilder<ArchiveCubit, ArchiveState>(
            builder: (BuildContext context, ArchiveState state) {
          if (state.status == Status.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == Status.success && state.revisions.isEmpty) {
            return const Text('ПУСТО!!');
          }

          if (state.status == Status.success && state.revisions.isNotEmpty) {
            final revisions = state.revisions;

            return ListView.builder(
                padding: const EdgeInsets.only(top: 35),
                itemCount: revisions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: index + 1 == revisions.length
                        ? const EdgeInsets.only(bottom: 60)
                        : EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   MainNavigationRouteNames.revision,
                        //   arguments: revisions[index],
                        // ).then((_) => _revisionActiveListCubit.getRevisions());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: BlocBuilder<RevisionPdfCubit, RevisionPdfState>(
                          builder: (context, statePDF) {
                            if (statePDF.status == Status.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (statePDF.status == Status.success &&
                                statePDF.filePDF != null) {
                              PdfApi.openFile(statePDF.filePDF!);
                            }
                            return DecoratedBox(
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
                              child: Slidable(
                                key: ValueKey(index),
                                startActionPane: ActionPane(
                                  extentRatio: 0.6,
                                  dragDismissible: false,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        promptDialog(
                                            context: context,
                                            dialog:
                                                'Вы действительно хотите ревизию ${revisions[index].name} сделать активной для изменений ?',
                                            onPressed: () {
                                              _archiveCubit.openRevision(
                                                  revisionId:
                                                      revisions[index].id);
                                            });
                                      },
                                      backgroundColor: const Color.fromARGB(
                                          255, 30, 172, 94),
                                      foregroundColor: Colors.white,
                                      icon: Icons.eject_outlined,
                                      label: 'Активировать',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        _revisionPdfCubit
                                            .openRevisionPDF(revisions[index]);
                                      },
                                      backgroundColor: const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.picture_as_pdf,
                                      label: 'Открыть файл',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(236, 236, 236, 0.8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Название: ' + revisions[index].name),
                                      const SizedBox(height: 5),
                                      Text('Дата: ' +
                                          DateFormat('dd.MM.yyyy')
                                              .format(revisions[index].date)),
                                      const SizedBox(height: 5),
                                      Text('Описание: ' +
                                          revisions[index].description),
                                      const SizedBox(height: 5),
                                      Text('Количество наименований: ' +
                                          revisions[index]
                                              .listProducts
                                              .length
                                              .toString()),
                                      const SizedBox(height: 5),
                                      Text('Статус: ' +
                                          revisions[index].isClosed.toString()),
                                      const SizedBox(height: 5),
                                      Text('Общая сумма: ' +
                                          revisions[index]
                                              .total
                                              .toStringAsFixed(2)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Text(
              'AppLocalizations.of(context).screenInitialization');
        }),
      ),
    );
  }
}
