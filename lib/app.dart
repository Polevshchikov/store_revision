import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/navigation/main_navigation.dart';
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart';
import 'feature/presentation/pages/settings/language/bloc/language_event.dart';
import 'feature/presentation/pages/settings/language/bloc/language_state.dart';

import 'injection.dart';

class App extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  static final _navigatorKey = GlobalKey<NavigatorState>();
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              getIt<AuthenticationBloc>()..add(AuthenticationInitialize()),
        ),
        BlocProvider<LanguageBloc>(
          create: (context) {
            return getIt<LanguageBloc>()..add(LanguageInitialize());
          },
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) =>
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) => MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: _navigatorKey,
            title: 'Store revision',
            locale: languageState.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routes: mainNavigation.routes,
            initialRoute: mainNavigation.initialRoute(),
            onGenerateRoute: mainNavigation.onGenerateRoute,
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                          MainNavigationRouteNames.homeScreen,
                          (route) => false);
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                          MainNavigationRouteNames.loginPage, (route) => false);
                      break;
                    case AuthenticationStatus.noVerification:
                      _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                          MainNavigationRouteNames.verification,
                          (route) => false);
                      break;
                    case AuthenticationStatus.error:
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(S.of(context).authFailure)),
                        );
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
