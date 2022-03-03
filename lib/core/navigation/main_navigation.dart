import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/forum/ui/forum_screen.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/home_screen.dart';
import 'package:store_revision/feature/presentation/pages/login/cubit/login_cubit.dart';
import 'package:store_revision/feature/presentation/pages/login/ui/login_page.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart';
import 'package:store_revision/feature/presentation/pages/new_revision/ui/new_revision_screen.dart';
import 'package:store_revision/feature/presentation/pages/product_add/cubit/product_add_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/revision_screen.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/revisions_active_screen.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/ui/sign_up_page.dart';
import 'package:store_revision/injection.dart';

abstract class MainNavigationRouteNames {
  MainNavigationRouteNames._();
  static const homeScreen = '/';
  static const loginPage = '/logIn';
  static const signUpPage = '/signUp';
  static const addRevision = '/addRevision';
  static const revision = '/revision';
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
    MainNavigationRouteNames.addRevision: (context) => BlocProvider(
          create: (BuildContext context) => getIt<NewRevisionCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const AddRevisionScreen(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MainNavigationRouteNames.revision:
        final value = routeSettings.arguments as RevisionEntity;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext context) => getIt<RevisionCubit>(
                      param1: BlocProvider.of<AuthenticationBloc>(context))),
              BlocProvider(
                  create: (BuildContext context) => getIt<ChangeBodyToCubit>()),
              BlocProvider(
                  create: (BuildContext context) => getIt<ProductAddCubit>(
                      param1: BlocProvider.of<AuthenticationBloc>(context))),
            ],
            child: RevisionScreen(revision: value),
          ),
        );
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
