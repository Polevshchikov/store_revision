import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/usecases/logout_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LogoutUseCase _logoutUseCase;

  AuthenticationBloc(
    this._logoutUseCase,
  ) : super(const AuthenticationState.initial()) {
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
    on<AuthenticationLoggedError>(_onLoggedError);
    on<AuthenticationInitialize>(_onAuthInitialize);
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

  Future<void> _onAuthInitialize(
    AuthenticationInitialize event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.status != AuthenticationStatus.initial) {
      emit(const AuthenticationState.load());
    }
    emit(const AuthenticationState.unauthenticated());
    // final result = await _authRepository.getAuthenticatedUserOrNull();

    // await result.fold(
    //   (failure) async => emit(AuthenticationState.error(failure)),
    //   (user) async => (user == null)
    //       ? emit(const AuthenticationState.unauthenticated())
    //       : emit(AuthenticationState.authenticated(user: user)),
    // );
  }

  Future<void> _onLoggedIn(
    AuthenticationLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async =>
      emit(AuthenticationState.authenticated(user: event.user));

  Future<void> _onLoggedError(
    AuthenticationLoggedError event,
    Emitter<AuthenticationState> emit,
  ) async =>
      emit(AuthenticationState.error(event.failure));
}
