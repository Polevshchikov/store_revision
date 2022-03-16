import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/core/navigation/arguments/revision_details_arguments.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/presentation/pages/archive/cubit/archive_cubit.dart';
import 'package:store_revision/feature/presentation/pages/archive/cubit/revision_pdf_cubit.dart';
import 'package:store_revision/feature/presentation/pages/archive/ui/archive_screen.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/home_screen.dart';
import 'package:store_revision/feature/presentation/pages/login/cubit/login_cubit.dart';
import 'package:store_revision/feature/presentation/pages/login/ui/login_page.dart';
import 'package:store_revision/feature/presentation/pages/product_add/cubit/product_add_cubit.dart';
import 'package:store_revision/feature/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:store_revision/feature/presentation/pages/profile/ui/profile_page.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/change_body_to_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/cubit/revision_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/revision_screen.dart';
import 'package:store_revision/feature/presentation/pages/revision_create/cubit/revision_create_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revision_create/ui/revision_create_screen.dart';
import 'package:store_revision/feature/presentation/pages/revision_details/ui/revision_details.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/revision_info_screen.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/ui/revisions_active_screen.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/ui/sign_up_page.dart';
import 'package:store_revision/feature/presentation/pages/splash/ui/splash_screen.dart';
import 'package:store_revision/feature/presentation/pages/trusted_revision/cubit/trusted_change_cubit.dart';
import 'package:store_revision/feature/presentation/pages/verification/ui/verification_screen.dart';
import 'package:store_revision/injection.dart';

abstract class MainNavigationRouteNames {
  MainNavigationRouteNames._();
  static const homeScreen = '/';
  static const loginPage = '/logIn';
  static const signUpPage = '/signUp';
  static const revisionCreate = '/revisionCreate';
  static const revision = '/revision';
  static const profile = '/profile';
  static const revisionDetails = '/revisionDetails';
  static const revisionInfo = '/revisionInfo';
  static const splash = '/splash';
  static const verification = '/verification';
}

class MainNavigation {
  String initialRoute() => MainNavigationRouteNames.splash;

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
    MainNavigationRouteNames.profile: (context) => BlocProvider(
          create: (BuildContext context) => getIt<ProfileCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const ProfilePage(),
        ),
    MainNavigationRouteNames.revisionCreate: (context) => BlocProvider(
          create: (BuildContext context) => getIt<RevisionCreateCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context)),
          child: const RevisionCreateScreen(),
        ),
    MainNavigationRouteNames.splash: (context) => const SplashScreen(),
    MainNavigationRouteNames.verification: (context) =>
        const VerificationScreen(),
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
      case MainNavigationRouteNames.revisionDetails:
        final value = routeSettings.arguments as RevisionDetailsArguments;
        return MaterialPageRoute(
          builder: (_) => RevisionDetailsPage(revisionDetailsArguments: value),
        );

      case MainNavigationRouteNames.revisionInfo:
        final value = routeSettings.arguments as RevisionEntity;
        return MaterialPageRoute(
            builder: (_) => RevisionInfoScreen(revision: value));

      default:
        const widget = Center(child: Text('Navigation Error!!!'));
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

final List<Widget> tabGroups = [
  MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (BuildContext context) => getIt<RevisionActiveListCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context))),
      BlocProvider(
          create: (BuildContext context) => getIt<TrustedChangeCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context))),
      BlocProvider(create: (BuildContext context) => getIt<ChangeBodyCubit>()),
    ],
    child: const RevisionActiveScreen(),
  ),
  MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (BuildContext context) => getIt<ArchiveCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context))),
      BlocProvider(
          create: (BuildContext context) => getIt<RevisionPdfCubit>(
              param1: BlocProvider.of<AuthenticationBloc>(context))),
    ],
    child: const ArchiveScreen(),
  ),
];
