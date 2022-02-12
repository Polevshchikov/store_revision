import 'package:flutter/material.dart';
import 'package:store_revision/common/app_styles.dart';
import 'package:store_revision/generated/l10n.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).informationNewIRLA,
      // style: AppStyles.addTrophyInformationTextStyle,
    );
  }
}
