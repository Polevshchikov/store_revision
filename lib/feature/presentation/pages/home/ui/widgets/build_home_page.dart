import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/build_tab.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/widgets/home_tab_bar.dart';

class BuildHomePage extends StatelessWidget {
  final int currentIndex;
  const BuildHomePage({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(414, 896),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      bottomNavigationBar: HomeTabBar(
        actionIndex: currentIndex,
      ),
      body: buildTab(currentIndex),
    );
  }
}
