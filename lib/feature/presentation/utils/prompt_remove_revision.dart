import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';

/// Всплывающая подсказка подтверждения удалить запись из списка
void promptRemoveRevision({
  required BuildContext context,
  required String revisionId,
  required String userId,
  required String title,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Вы уверены что хотите удалить $title ?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<RevisionActiveListCubit>().deleteRevision(
                            revisionId: revisionId,
                            userId: userId,
                          );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Да',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Нет',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ]);
      });
}
