import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:store_revision/feature/presentation/widgets/upload_widget.dart';

class SignUpAvatar extends StatelessWidget {
  const SignUpAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UploadWidget(
      pickCamera: () =>
          context.read<SignUpCubit>().photoChange(useCamera: true),
      pickup: () => context.read<SignUpCubit>().photoChange(),
      actionChild:
          BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: (state.photo != null && state.photo!.path.isNotEmpty)
              ? Container(
                  width: 200,
                  height: 200,
                  color: const Color.fromARGB(255, 197, 197, 197),
                  child: Image.file(
                    File(state.photo!.path),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: const Color.fromARGB(255, 197, 197, 197),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                      ),
                    ),
                    const Positioned(
                      right: 10,
                      child: Icon(
                        Icons.add,
                        size: 60,
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
