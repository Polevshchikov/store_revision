import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/enum_navbar_items.dart';

class HomeTabBar extends StatelessWidget {
  final int actionIndex;
  const HomeTabBar({Key? key, required this.actionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BottomAppBar(
      elevation: 10,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SalomonBottomBar(
          currentIndex: actionIndex,
          onTap: (i) {
            switch (i) {
              case 0:
                context
                    .read<BottomNavigationCubit>()
                    .changeScreen(NavbarItems.active);
                break;
              case 1:
                context
                    .read<BottomNavigationCubit>()
                    .changeScreen(NavbarItems.archive);
                break;

              default:
                context
                    .read<BottomNavigationCubit>()
                    .changeScreen(NavbarItems.active);
            }
          },
          margin: EdgeInsets.only(
            left: screenWidth / 8,
            right: screenWidth / 8,
            top: 16,
            bottom: 10,
          ),
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          items: [
            /// Active
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.add_to_photos_rounded,
                size: 30,
              ),
              title: const Text("Активные"),
              selectedColor: const Color.fromARGB(255, 35, 147, 212),
            ),

            /// Archiv
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.cloud_circle_rounded,
                size: 30,
              ),
              title: const Text("Архивные"),
              selectedColor: const Color.fromARGB(255, 212, 35, 153),
            ),
          ],
        ),
      ),
    );
  }
}
