import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/gradient_castom.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/widgets/home_page_body.dart';
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
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradientCastom(),
            ),
          ),
          elevation: 10,
          title: const Text('Home'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10, top: 12),
              child: GestureDetector(
                child: Container(
                  width: 55,
                  decoration: BoxDecoration(
                    gradient: gradientCastom(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                      color: Colors.white24,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  )),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MainNavigationRouteNames.profile,
                  );
                },
              ),
            ),
          ]),
      bottomNavigationBar: HomeTabBar(actionIndex: currentIndex),
      body: HomePageBody(actionIndex: currentIndex),
    );
  }
}
