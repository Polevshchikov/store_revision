import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/widgets/build_home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
      if (state is BottomNavigationArchive) {
        return BuildHomePage(currentIndex: state.itemIndex);
      }
      if (state is BottomNavigationActive) {
        return BuildHomePage(currentIndex: state.itemIndex);
      }
      if (state is BottomNavigationPdf) {
        return BuildHomePage(currentIndex: state.itemIndex);
      }
      return const BuildHomePage(currentIndex: 0);
    });
  }
}
