import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_revision/common/app_colors.dart';
import 'package:store_revision/common/app_resources.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';

class RevisionScreen extends StatelessWidget {
  const RevisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 54,
        height: 54,
        child: GestureDetector(
          onTap: () async => Navigator.of(context)
              .pushNamed(MainNavigationRouteNames.addProduct),
          child: Container(
            height: 54,
            width: 54,
            decoration: const BoxDecoration(
              color: AppColors.blackColorAddTrophy,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainColorApp,
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 6,
                ),
                child: SvgPicture.asset(AppResources.addTrophyIcon),
              ),
            ),
          ),
        ),
      ),
      body: GridPaper(
        interval: 180,
        divisions: 4,
        subdivisions: 5,
        child: Container(
          color: Colors.blueGrey,
          height: double.infinity,
          child: ListTile(
            title: Text('Product1'),
          ),
        ),
      ),
    );
  }
}
