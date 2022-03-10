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
    return BottomAppBar(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
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
              case 2:
                context
                    .read<BottomNavigationCubit>()
                    .changeScreen(NavbarItems.pdf);
                break;
              default:
                context
                    .read<BottomNavigationCubit>()
                    .changeScreen(NavbarItems.active);
            }
          },
          margin: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 16,
            bottom: 25,
          ),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.indigo,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text("Likes"),
              selectedColor: Colors.pink,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
