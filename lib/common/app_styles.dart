import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const TextStyle textPrimaryStyle = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.48,
  );
  static const TextStyle textButtonFacebookStyle = TextStyle(
    color: AppColors.facebookColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.48,
  );
  static const TextStyle splitTextStyle = TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    fontSize: 10,
  );
  static const TextStyle forgotTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    fontSize: 12,
  );

  static const TextStyle forgotTextButtonStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: AppColors.mainColorApp,
    fontSize: 11,
  );

  static const TextStyle forgotSubtitleStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.primaryColorLight,
  );
}
