import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_revision/feature/presentation/pages/revision_edit/cubit/revision_edit_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';

class RevisionEditScreen extends StatefulWidget {
  const RevisionEditScreen({Key? key}) : super(key: key);

  @override
  State<RevisionEditScreen> createState() => _RevisionEditScreenState();
}

class _RevisionEditScreenState extends State<RevisionEditScreen> {
  late ChangeBodyCubit _changeBodyCubit;
  late String revisionName;
  late String revisionDescr;
  late String revisionId;
  late TextEditingController controllerName;
  late TextEditingController controllerDescr;
  late FocusNode focusName;
  late FocusNode focusDescr;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerDescr = TextEditingController();
    focusName = FocusNode();
    focusDescr = FocusNode();
    _changeBodyCubit = BlocProvider.of<ChangeBodyCubit>(context);
    revisionName = _changeBodyCubit.state.revisionName;
    revisionDescr = _changeBodyCubit.state.revisionDescr;
    revisionId = _changeBodyCubit.state.revisionId;
    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerDescr.dispose();
    focusName.dispose();
    focusDescr.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<RevisionEditCubit>().resetState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300.h,
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          margin: EdgeInsets.only(right: 15.0.w, left: 15.0.w, top: 20.h),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 252, 147, 99),
              Color.fromARGB(255, 139, 238, 255),
              Color.fromARGB(255, 114, 199, 90),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 150, 143, 143),
                offset: Offset(6, 6),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 131, 123, 123),
                offset: Offset(-6, -6),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                      child: Text(
                    'Название: ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 79, 143)),
                  )),
                  const SizedBox(width: 5),
                  Flexible(
                      flex: 2,
                      child: TextFormField(
                        autofocus: true,
                        focusNode: focusName,
                        controller: controllerName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.only(top: 20, bottom: 2),
                          alignLabelWithHint: true,
                          hintText: revisionName,
                          helperText: '',
                        ),
                        onFieldSubmitted: (term) {
                          focusName.unfocus();
                          FocusScope.of(context).requestFocus(focusDescr);
                        },
                      )),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      'Описание: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 0, 79, 143)),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      focusNode: focusDescr,
                      controller: controllerDescr,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 2),
                        alignLabelWithHint: true,
                        hintText: revisionDescr,
                        helperText: '',
                      ),
                      onFieldSubmitted: (term) {
                        focusDescr.unfocus();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 290.h),
          child: BlocBuilder<RevisionEditCubit, RevisionEditState>(
            builder: (context, state) {
              if (state.status == Status.success) {
                BlocProvider.of<ChangeBodyCubit>(context)
                    .changeToActiveRevision();
              }
              return state.status == Status.waiting
                  ? const CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: const Color.fromARGB(255, 255, 81, 0),
                          ),
                          onPressed: () =>
                              BlocProvider.of<ChangeBodyCubit>(context)
                                  .changeToActiveRevision(),
                          child: const Text('Отменить'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: const Color.fromARGB(255, 0, 167, 14),
                          ),
                          onPressed: () async {
                            await context
                                .read<RevisionEditCubit>()
                                .editRevision(
                                  revisionId: revisionId,
                                  revisionName: controllerName.text,
                                  revisionDescr: controllerDescr.text,
                                );
                          },
                          child: const Text('Изменить'),
                        ),
                      ],
                    );
            },
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 30.h, left: 40.h),
            child: const Text(
              'Редактирование ревизии',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0)),
            )),
      ],
    );
  }
}
