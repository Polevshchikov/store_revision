import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/cubit/revision_info_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/body_footer_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/body_header_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/info_product_widget.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/info_trusted_widget.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

class RevisionInfoScreen extends StatelessWidget {
  final RevisionEntity revision;
  const RevisionInfoScreen({Key? key, required this.revision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<RevisionInfoCubit>()
        .getInfo(revisionId: revision.id, listTrustedsId: revision.listTrusted);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 31, 30, 30),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 207, 202, 202),
                    Color.fromARGB(255, 194, 137, 137),
                    Color.fromARGB(255, 112, 104, 179),
                    Color.fromARGB(255, 41, 38, 38),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(
                    AppResources.iconApp,
                    color: Colors.white,
                    width: 150,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 30,
              child: Image.asset(
                AppResources.myLogo,
                color: const Color.fromARGB(155, 255, 255, 255),
                width: 40,
              ),
            ),
            BlocBuilder<RevisionInfoCubit, RevisionInfoState>(
              builder: (context, state) {
                if (state.status == Status.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.status == Status.success) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyHeaderWidget(revision: revision),
                          InfoTrustedWidget(users: state.revisionInfo.users),
                          const SizedBox(height: 10),
                          InfoProductWidget(
                              products: state.revisionInfo.products),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                            height: 6,
                          ),
                          const Divider(
                            color: Colors.blue,
                            thickness: 1.5,
                            height: 6,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                            height: 6,
                          ),
                          const SizedBox(height: 10),
                          BodyFooterWidget(total: revision.total),
                        ],
                      ),
                    ),
                  );
                }
                return const PlugScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
