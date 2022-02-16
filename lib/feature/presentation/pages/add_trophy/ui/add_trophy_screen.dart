import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/utils/enum_file_num.dart';

import 'package:formz/formz.dart';
import 'package:store_revision/generated/l10n.dart';
import '../cubit/add_trophy_cubit.dart';
import '../ui/utils/add_news_irla_dialog.dart';
import '../ui/utils/app_bar_add_trophy.dart';
import '../ui/widgets/information_widget.dart';
import '../ui/widgets/section_description_trophy.dart';
import '../ui/widgets/section_add_image_video_trophy.dart';
import '../ui/widgets/serial_number_trophy.dart';

class AddTrophyScreen extends StatelessWidget {
  const AddTrophyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAddTrophy(context),
      backgroundColor: AppColors.backgroundColorAddTrophy,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 42,
            bottom: 55,
            left: 40,
            right: 40,
          ),
          child: Column(
            children: [
              const SerialNumberTrophy(),
              const SizedBox(height: 22.0),
              const SectionAddImageVideoTrophy(fileNum: FileNum.fileOne),
              const SizedBox(height: 24.0),
              const SectionAddImageVideoTrophy(fileNum: FileNum.fileTwo),
              const SizedBox(height: 24.0),
              const SectionAddImageVideoTrophy(fileNum: FileNum.fileThree),
              const SizedBox(height: 24.0),
              const SectionDescriptionTrophy(),
              const SizedBox(height: 11.0),
              const InformationWidget(),
              const SizedBox(height: 23.0),
              _AddIRLAButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddIRLAButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTrophyCubit, AddTrophyState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox.shrink();
        // return AppMainButton(
        //   typeButton: TypeButtonStyle.addTrophy,
        //   text: S.of(context).addIRLA,
        //   isValidated: state.status.isValidated,
        //   textStyle: AppStyles.addTrophyTextStyle,
        //   backgroundColor: AppColors.blackColorAddTrophy,
        //   borderColor: null,
        //   onTap: () {
        //     addNewsIRLADialog(context);
        //   },
        // );
      },
    );
  }
}
