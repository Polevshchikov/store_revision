import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/params/singup_params.dart';
import 'package:store_revision/feature/domain/usecases/singup_usecase.dart';
import 'package:store_revision/feature/presentation/components/confirmed_password.dart';
import 'package:store_revision/feature/presentation/components/email.dart';
import 'package:store_revision/feature/presentation/components/password.dart';
import 'package:store_revision/feature/presentation/components/username.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signupUseCase, this._authenticationBloc)
      : super(const SignUpState());

  final SignupUseCase _signupUseCase;
  final AuthenticationBloc _authenticationBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(
      value,
    );
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        username,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _signupUseCase.call(SignUpParams(
      username: state.username.value,
      email: state.email.value,
      password: state.password.value,
    ));
    await result.fold((failure) async {
      emit(state.copyWith(
        error: failure,
        status: FormzStatus.submissionFailure,
      ));
    }, (user) async {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      _authenticationBloc.add(AuthenticationLoggedIn(user));
    });
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
