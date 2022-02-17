import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/add_trophy_screen.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/forum/ui/forum_screen.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/home_screen.dart';
import 'package:store_revision/feature/presentation/pages/login/cubit/login_cubit.dart';
import 'package:store_revision/feature/presentation/pages/login/ui/login_page.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/ui/new_revision_screen.dart';
import 'package:store_revision/feature/presentation/pages/revision_active/cubit/revision_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision_active/ui/revision_active_screen.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/ui/sign_up_page.dart';
import 'package:store_revision/injection.dart';

abstract class MainNavigationRouteNames {
  MainNavigationRouteNames._();
  static const homeScreen = '/';
  static const loginPage = '/home';
  static const signUpPage = '/signUp';
  static const forgotScreen = '/forgotPassword';
  static const addProduct = '/addProduct';
  static const profileSettingsWidget = '/profileSettings';
  static const changePasswordWidget = '/changePassword';
  static const newRevision = '/newRevision';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.loginPage
      : MainNavigationRouteNames.homeScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.homeScreen: (context) => BlocProvider(
          create: (BuildContext context) => getIt<BottomNavigationCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const HomeScreen(),
        ),
    MainNavigationRouteNames.addProduct: (context) => BlocProvider(
          create: (BuildContext context) => getIt<AddTrophyCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const AddTrophyScreen(),
        ),
    MainNavigationRouteNames.loginPage: (context) => BlocProvider(
          create: (BuildContext context) => getIt<LoginCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const LoginPage(),
        ),
    MainNavigationRouteNames.signUpPage: (context) => BlocProvider(
          create: (BuildContext context) => getIt<SignUpCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const SignUpPage(),
        ),
    MainNavigationRouteNames.newRevision: (context) => BlocProvider(
          create: (BuildContext context) => getIt<NewRevisionCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const NewRevisionScreen(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      default:
        const widget = Center(child: Text('Navigation Error!!!'));
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

final List<Widget> tabGroups = [
  BlocProvider(
    create: (BuildContext context) => getIt<RevisionActiveListCubit>(
        param1: BlocProvider.of<AuthenticationBloc>(context)),
    child: const RevisionActiveScreen(),
  ),
  const ForumScreen(),
];
