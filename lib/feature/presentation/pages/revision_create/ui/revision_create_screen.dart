import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revision_create/cubit/revision_create_cubit.dart';

class RevisionCreateScreen extends StatelessWidget {
  const RevisionCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Новая ревизия'),
        leading: const BackButton(color: Colors.black),
        backgroundColor: const Color.fromARGB(160, 10, 99, 150),
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _NameInput(),
            const SizedBox(height: 8),
            _DescriptionInput(),
            const SizedBox(height: 8),
            _CreateRevisionButton(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevisionCreateCubit, RevisionCreateState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('revisionForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<RevisionCreateCubit>().revisionNameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Введите название',
            helperText: '',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevisionCreateCubit, RevisionCreateState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('revisionForm_descrInput_textField'),
          onChanged: (descr) =>
              context.read<RevisionCreateCubit>().revisionDescrChanged(descr),
          decoration: InputDecoration(
            labelText: 'Введите описание',
            helperText: '',
            errorText: state.description.invalid ? 'invalid description' : null,
          ),
        );
      },
    );
  }
}

class _CreateRevisionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return BlocBuilder<RevisionCreateCubit, RevisionCreateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('revisionForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color.fromARGB(255, 2, 122, 66),
                ),
                onPressed: state.status.isValidated
                    ? () async {
                        await context
                            .read<RevisionCreateCubit>()
                            .createRevision(uid: user.uid);
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text('Создать ревизию'),
              );
      },
    );
  }
}
