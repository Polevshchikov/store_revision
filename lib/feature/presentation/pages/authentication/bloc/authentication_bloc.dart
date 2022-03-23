import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/usecases/get_authenticated_user_usecase.dart';
import 'package:store_revision/feature/domain/usecases/get_verification_usecase.dart';
import 'package:store_revision/feature/domain/usecases/logout_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/domain/usecases/verification_email_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LogoutUseCase _logoutUseCase;
  final GetAuthenticatedUserUseCase _getAuthenticatedUserUseCase;
  final GetVerificationUseCase _getVerificationUseCase;
  final VerificationEmailUseCase _verificationEmailUseCase;
  final FirebaseAuth _firebaseAuth;
  late StreamSubscription<User?> streamSubscription;

  AuthenticationBloc(
    this._logoutUseCase,
    this._firebaseAuth,
    this._getAuthenticatedUserUseCase,
    this._getVerificationUseCase,
    this._verificationEmailUseCase,
  ) : super(const AuthenticationState.initial()) {
    streamSubscription =
        _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        add(Unauthenticated());
      }
    });
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
    on<Unauthenticated>(_unauthenticated);
    on<AuthenticationLoggedError>(_onLoggedError);
    on<AuthenticationInitialize>(_onAuthInitialize);
    on<AuthenticationLoad>(_onLoad);
    on<AuthenticationVerifivation>(_onVerifivation);
  }

  Future<void> _onVerifivation(
    AuthenticationVerifivation event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _verificationEmailUseCase.call(NoParams());
    emit(
      (result.isLeft())
          ? const AuthenticationState.initial()
          : AuthenticationState.noVerification(user: event.user),
    );
  }

  Future<void> _onLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _logoutUseCase.call(NoParams());
    emit(
      (result.isLeft())
          ? const AuthenticationState.initial()
          : const AuthenticationState.logOuted(),
    );
  }

  Future<void> _unauthenticated(
    Unauthenticated event,
    Emitter<AuthenticationState> emit,
  ) async =>
      emit(const AuthenticationState.logOuted());

  Future<void> _onAuthInitialize(
    AuthenticationInitialize event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.status != AuthenticationStatus.initial) {
      emit(const AuthenticationState.load());
    }
    final result = await _getAuthenticatedUserUseCase.call(NoParams());

    await result.fold(
      (failure) async {
        emit(const AuthenticationState.logOuted());
      },
      (user) async => add(AuthenticationLoggedIn(user)),
    );
  }

  Future<void> _onLoggedIn(
    AuthenticationLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _getVerificationUseCase.call(NoParams());

    await result.fold(
      (failure) async {
        emit(AuthenticationState.error(failure));
        emit(const AuthenticationState.logOuted());
      },
      (isVerif) async => (isVerif)
          ? emit(AuthenticationState.authenticated(user: event.user))
          : emit(AuthenticationState.noVerification(user: event.user)),
    );
  }

  Future<void> _onLoggedError(
    AuthenticationLoggedError event,
    Emitter<AuthenticationState> emit,
  ) async =>
      emit(AuthenticationState.error(event.failure));

  Future<void> _onLoad(
    AuthenticationLoad event,
    Emitter<AuthenticationState> emit,
  ) async =>
      emit(const AuthenticationState.load());
}
