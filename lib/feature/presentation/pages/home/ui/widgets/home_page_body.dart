import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/enum_navbar_items.dart';

class HomePageBody extends StatefulWidget {
  final int actionIndex;
  const HomePageBody({Key? key, required this.actionIndex}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.actionIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _animateTo(int _page) async {
    _pageController.animateToPage(
      _page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
      listener: (context, state) async {
        if (state is BottomNavigationArchive) {
          await _animateTo(state.itemIndex);
        }
        if (state is BottomNavigationActive) {
          await _animateTo(state.itemIndex);
        }
        if (state is BottomNavigationPdf) {
          await _animateTo(state.itemIndex);
        }
      },
      builder: (context, state) {
        return PageView(
          controller: _pageController,
          onPageChanged: (i) {
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
          children: tabGroups,
        );
      },
    );
  }
}
