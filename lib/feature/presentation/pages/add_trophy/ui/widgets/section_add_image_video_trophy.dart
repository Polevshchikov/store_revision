import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/domain/entities/file_object.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/utils/enum_file_num.dart';
import 'package:store_revision/generated/l10n.dart';

class SectionAddImageVideoTrophy extends StatelessWidget {
  final FileNum fileNum;
  const SectionAddImageVideoTrophy({
    Key? key,
    required this.fileNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FileObject _file = const FileObject.initial('', '', '');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: AppColors.boxShadowAddTrophy,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Text(
                  S.of(context).uploadFileNewIRLA,
                ),
              ),
            ],
          ),
          BlocBuilder<AddTrophyCubit, AddTrophyState>(
              builder: (context, state) {
            switch (fileNum) {
              case FileNum.fileOne:
                _file = state.fileOne;
                break;
              case FileNum.fileTwo:
                _file = state.fileTwo;
                break;
              case FileNum.fileThree:
                _file = state.fileThree;
                break;
            }
            return _file.url.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(_file.url),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              child:
                                  SvgPicture.asset(AppResources.closeWhiteIcon),
                              onTap: () => context
                                  .read<AddTrophyCubit>()
                                  .deleteFile(fileNum: fileNum),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
