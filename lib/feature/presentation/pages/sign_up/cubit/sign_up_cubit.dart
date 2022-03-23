import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';
import 'package:store_revision/feature/domain/usecases/params/singup_params.dart';
import 'package:store_revision/feature/domain/usecases/singup_usecase.dart';
import 'package:store_revision/feature/domain/usecases/upload_camera_usecase.dart';
import 'package:store_revision/feature/domain/usecases/upload_gallery_usecase.dart';
import 'package:store_revision/feature/presentation/components/confirmed_password.dart';
import 'package:store_revision/feature/presentation/components/email.dart';
import 'package:store_revision/feature/presentation/components/password.dart';
import 'package:store_revision/feature/presentation/components/username.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._signupUseCase,
    this._authenticationBloc,
    this._uploadCameraImageUseCase,
    this._uploadFileUseCase,
  ) : super(const SignUpState());

  final SignupUseCase _signupUseCase;
  final UploadCameraImageUseCase _uploadCameraImageUseCase;
  final UploadFileUseCase _uploadFileUseCase;
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
    final username = Username.dirty(value);
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

  Future<void> photoChange({bool useCamera = false}) async {
    final result = useCamera
        ? await _uploadCameraImageUseCase.call(NoParams())
        : await _uploadFileUseCase.call(NoParams());
    await result.fold((failure) async {
      emit(state.copyWith(
        error: failure,
        status: FormzStatus.submissionFailure,
      ));
    }, (photo) async {
      emit(state.copyWith(photo: photo, status: FormzStatus.pure));
    });
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _signupUseCase.call(SignUpParams(
      username: state.username.value,
      email: state.email.value,
      password: state.password.value,
      photo: state.photo,
    ));
    await result.fold((failure) async {
      emit(state.copyWith(
        error: failure,
        status: FormzStatus.submissionFailure,
      ));
    }, (user) async {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      _authenticationBloc.add(AuthenticationLoad());
      _authenticationBloc.add(AuthenticationLoggedIn(user));
    });
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
