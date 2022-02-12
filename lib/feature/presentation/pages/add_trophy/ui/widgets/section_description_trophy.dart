import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_styles.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart';
import 'package:store_revision/generated/l10n.dart';

class SectionDescriptionTrophy extends StatelessWidget {
  const SectionDescriptionTrophy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTrophyCubit, AddTrophyState>(
      buildWhen: (previous, current) => previous.serialNum != current.serialNum,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextField(
            key: const Key('addTrophy_descriptionTrophyInput_textField'),
            cursorColor: AppColors.textColor,
            maxLines: 5,
            onChanged: (value) {
              context.read<AddTrophyCubit>().descriptionChanged(value);
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              hintText: S.of(context).addDescriptionNewIRLA,
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}
