import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart';

class AddRevisionScreen extends StatelessWidget {
  const AddRevisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _NameInput(),
          const SizedBox(height: 8),
          _DescriptionInput(),
          const SizedBox(height: 8),
          _CreateRevisionButton(),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRevisionCubit, NewRevisionState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('revisionForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<NewRevisionCubit>().revisionNameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'name',
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
    return BlocBuilder<NewRevisionCubit, NewRevisionState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('revisionForm_descrInput_textField'),
          onChanged: (descr) =>
              context.read<NewRevisionCubit>().revisionDescrChanged(descr),
          decoration: InputDecoration(
            labelText: 'description',
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
    return BlocBuilder<NewRevisionCubit, NewRevisionState>(
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
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () async {
                        await context
                            .read<NewRevisionCubit>()
                            .createRevision(uid: user.uid);
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}
