import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';

class ButtonAddRevision extends StatelessWidget {
  const ButtonAddRevision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MainNavigationRouteNames.addRevision)
            .then(
                (_) => context.read<RevisionActiveListCubit>().getRevisions());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                    color: Colors.black87)
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Colors.blueAccent,
            ),
            child: const Text(
              'Добавить ревизию',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                    color: Colors.black87)
              ],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.blueAccent,
            ),
            child: const Icon(Icons.post_add_rounded),
          ),
        ],
      ),
    );
  }
}
