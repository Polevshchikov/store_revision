import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/common/app_colors.dart';
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
          ? const Icon(Icons.reviews)
          : const Icon(Icons.reviews_outlined),
      tabWidth: tabWidth,
      colorBorder: actionIndex == 0 ? AppColors.mainColorApp : null,
    ),
    ItemTabWidget(
      callback: () =>
          context.read<BottomNavigationCubit>().changeScreen(NavbarItems.forum),
      actionIndex: actionIndex,
      childTab: actionIndex == 1
          ? const Icon(Icons.archive)
          : const Icon(Icons.archive_outlined),
      tabWidth: tabWidth,
      colorBorder: actionIndex == 1 ? AppColors.mainColorApp : null,
    ),
  ];
}
