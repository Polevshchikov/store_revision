import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/enum_navbar_items.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/item_tab_widget.dart';

List<Widget> listBottomTabs(BuildContext context, int actionIndex) {
  final tabWidth = (MediaQuery.of(context).size.width) / 2;
  return [
    ItemTabWidget(
      callback: () => context
          .read<BottomNavigationCubit>()
          .changeScreen(NavbarItems.achievements),
      actionIndex: actionIndex,
      childTab: actionIndex == 0
          ? SvgPicture.asset(AppResources.meSelectedIcon)
          : SvgPicture.asset(AppResources.meIcon),
      tabWidth: tabWidth,
      colorBorder: actionIndex == 0 ? AppColors.mainColorApp : null,
    ),
    ItemTabWidget(
      callback: () =>
          context.read<BottomNavigationCubit>().changeScreen(NavbarItems.forum),
      actionIndex: actionIndex,
      childTab: actionIndex == 1
          ? SvgPicture.asset(AppResources.friendsSelectedIcon)
          : SvgPicture.asset(AppResources.friendsIcon),
      tabWidth: tabWidth,
      colorBorder: actionIndex == 1 ? AppColors.mainColorApp : null,
    ),
  ];
}
