import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revision_edit/ui/revision_edit_screen.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/widgets/body_revision_widget.dart';
import 'package:store_revision/feature/presentation/pages/trusted_revision/ui/trusted_add_page.dart';
import 'package:store_revision/feature/presentation/pages/trusted_revision/ui/trusted_delete_page.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

class RevisionActiveScreen extends StatelessWidget {
  const RevisionActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 36, 153, 199),
          Color.fromARGB(255, 174, 222, 241),
          Color.fromARGB(255, 230, 230, 230),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      height: double.infinity,
      width: double.infinity,
      child: BlocBuilder<ChangeBodyCubit, ChangeBodyState>(
        buildWhen: (previous, current) => previous.bodyType != current.bodyType,
        builder: (context, changeState) {
          if (changeState.bodyType == BodyType.activeRevision) {
            return const BodyRevisionWidget();
          }
          if (changeState.bodyType == BodyType.trustedAdd) {
            return const TrustedAddPage();
          }
          if (changeState.bodyType == BodyType.editRevision) {
            return const RevisionEditScreen();
          }
          if (changeState.bodyType == BodyType.trustedDelete) {
            return const TrustedDeletePage();
          }
          return const PlugScreen();
        },
      ),
    );
  }
}
