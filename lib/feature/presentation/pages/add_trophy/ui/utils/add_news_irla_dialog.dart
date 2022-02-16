import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/widgets/dialog_wrapper_widget.dart';
import 'package:store_revision/generated/l10n.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/widgets/dialog_wrapper_widget.dart';

addNewsIRLADialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        double _deviceHeight = MediaQuery.of(context).size.height;
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
              horizontal: 20, vertical: _deviceHeight >= 750.0 ? 100 : 50),
          child: DialogWrapperWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'congratulations',
                ),
                const SizedBox(height: 40.0),
                SvgPicture.asset(AppResources.congratulationsIcon),
                const SizedBox(height: 24.0),
                Text(
                  'addedNewIRLA',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                // AppMainButton(
                //   typeButton: TypeButtonStyle.addTrophy,
                //   text: S.of(context).shareIt,
                //   textStyle: AppStyles.addTrophyTextStyle,
                //   backgroundColor: AppColors.blackColorAddTrophy,
                //   borderColor: null,
                //   onTap: () {
                //     //TODO:переход на главную страницу и рассказать друзьям
                //   },
                //   childButton: true,
                // ),
              ],
            ),
          ),
        );
      });
}
