import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/generated/l10n.dart';

PreferredSize appBarAddTrophy(BuildContext context) => PreferredSize(
      preferredSize: const Size.fromHeight(106),
      child: Container(
        height: double.infinity,
        alignment: Alignment.bottomLeft,
        decoration: const BoxDecoration(
          color: AppColors.blackColorAddTrophy,
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 2),
                color: AppColors.mainColorApp)
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 26.1, left: 24),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(AppResources.backIcon),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.39),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'addIRLA',
                    // style: AppStyles.addTrophyTitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
