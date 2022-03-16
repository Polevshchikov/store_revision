import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';

class RevisionEditScreen extends StatefulWidget {
  const RevisionEditScreen({Key? key}) : super(key: key);

  @override
  State<RevisionEditScreen> createState() => _RevisionEditScreenState();
}

class _RevisionEditScreenState extends State<RevisionEditScreen> {
  late ChangeBodyCubit _changeBodyCubit;
  // late RevisionEditCubit _revisionEditCubit;
  late String revisionName;
  late String revisionDescr;
  @override
  void initState() {
    _changeBodyCubit = BlocProvider.of<ChangeBodyCubit>(context);
    // _revisionEditCubit = BlocProvider.of<RevisionEditCubit>(context);
    revisionName = _changeBodyCubit.state.revisionName;
    revisionDescr = _changeBodyCubit.state.revisionDescr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(236, 236, 236, 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Название: ' + revisionName),
                const SizedBox(height: 5),
                Text('Описание: ' + revisionDescr),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
