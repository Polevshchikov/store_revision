import 'package:flutter/material.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/list_bottom_tabs.dart';

class HomeTabBar extends StatelessWidget {
  final int actionIndex;
  const HomeTabBar({Key? key, required this.actionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Stack(
        children: [
          Container(
            color: AppColors.dialogBackgroundColor,
            height: 3.29,
          ),
          Row(
            children: listBottomTabs(context, actionIndex),
          )
        ],
      ),
    );
  }
}
