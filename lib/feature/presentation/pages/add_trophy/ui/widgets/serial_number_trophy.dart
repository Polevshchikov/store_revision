import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart';
import 'package:store_revision/generated/l10n.dart';

class SerialNumberTrophy extends StatelessWidget {
  const SerialNumberTrophy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTrophyCubit, AddTrophyState>(
      buildWhen: (previous, current) => previous.serialNum != current.serialNum,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'serialNumber' + ' *',
            ),
            TextField(
              key: const Key('addTrophy_serialNumberTrophyInput_textField'),
              cursorColor: AppColors.textColor,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              // maxLength: 12,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,

              onChanged: (value) {
                context.read<AddTrophyCubit>().serialNumChanged(value);
              },
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.addTrophyBorderSerialNumColor,
                  width: 1.5,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.mainColorApp, width: 1.5),
                ),
                contentPadding: const EdgeInsets.only(bottom: 2.0),
                isDense: true,
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          //TODO: Добавить переход на скинирование штрихкода
                          print('Scanner');
                        },
                        child: SvgPicture.asset(
                          AppResources.scanQrIcon,
                          width: 14,
                          height: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                suffix: const SizedBox(width: 30),
                hintText: "S.of(context).characters12",
              ),
            )
          ],
        );
      },
    );
  }
}
