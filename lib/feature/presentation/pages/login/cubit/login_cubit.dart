import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/login_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/login_params.dart';
import 'package:store_revision/feature/presentation/components/email.dart';
import 'package:store_revision/feature/presentation/components/password.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._authenticationBloc)
      : super(const LoginState());
  final LoginUseCase _loginUseCase;
  final AuthenticationBloc _authenticationBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await _loginUseCase.call(LoginParams(
      email: state.email.value,
      password: state.password.value,
    ));
    await result.fold((failure) async {
      emit(state.copyWith(
        failure: failure,
        status: FormzStatus.submissionFailure,
      ));
      _authenticationBloc.add(AuthenticationLoggedError(failure));
    }, (user) async {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        email: Email.dirty(user.email),
      ));
      _authenticationBloc.add(AuthenticationLoad());
      _authenticationBloc.add(AuthenticationLoggedIn(user));
    });
  }
}
