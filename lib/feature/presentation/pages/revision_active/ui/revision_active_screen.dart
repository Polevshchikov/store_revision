import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revision_active/cubit/revision_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision_active/ui/widgets/button_add_revision.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionActiveScreen extends StatelessWidget {
  const RevisionActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RevisionActiveListCubit>().getRevisions();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.purple[200]!, Colors.amber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          GridPaper(
            interval: 180,
            divisions: 4,
            subdivisions: 5,
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<RevisionActiveListCubit>().getRevisions();
              },
              child:
                  BlocBuilder<RevisionActiveListCubit, RevisionActiveListState>(
                      builder: (BuildContext context,
                          RevisionActiveListState state) {
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
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemCount: revisions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: index + 1 == revisions.length
                              ? const EdgeInsets.only(bottom: 60)
                              : EdgeInsets.zero,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
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
                                  Text(revisions[index].name),
                                  SizedBox(height: 5),
                                  Text(revisions[index].date.toString()),
                                  SizedBox(height: 5),
                                  Text(revisions[index].description),
                                  SizedBox(height: 5),
                                  Text(revisions[index].isClosed.toString()),
                                  SizedBox(height: 5),
                                  Text(revisions[index].total.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Text(
                    'AppLocalizations.of(context).screenInitialization');
              }),
            ),
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
