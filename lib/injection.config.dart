// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i8;
import 'package:image_picker/image_picker.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import 'core/modules/local_module.dart' as _i34;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i19;
import 'feature/data/repositories/file_repository_impl.dart' as _i5;
import 'feature/data/repositories/revision_repository_impl.dart' as _i11;
import 'feature/data/repositories/settings_repository_impl.dart' as _i28;
import 'feature/data/repositories/user_repository_impl.dart' as _i16;
import 'feature/domain/repositories/authentication_repository.dart' as _i18;
import 'feature/domain/repositories/file_repository.dart' as _i4;
import 'feature/domain/repositories/revision_repository.dart' as _i10;
import 'feature/domain/repositories/settings_repository.dart' as _i27;
import 'feature/domain/repositories/user_repository.dart' as _i15;
import 'feature/domain/usecases/create_revision_usecase.dart' as _i20;
import 'feature/domain/usecases/delete_revision_usecase.dart' as _i21;
import 'feature/domain/usecases/get_authenticated_user_usecase.dart' as _i22;
import 'feature/domain/usecases/login_usecase.dart' as _i24;
import 'feature/domain/usecases/logIn_with_google_usecase.dart' as _i23;
import 'feature/domain/usecases/logout_usecase.dart' as _i25;
import 'feature/domain/usecases/singup_usecase.dart' as _i29;
import 'feature/domain/usecases/upload_camera_image_usecase.dart' as _i13;
import 'feature/domain/usecases/upload_file_usecase.dart' as _i14;
import 'feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart'
    as _i17;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i30;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i32;
import 'feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart'
    as _i26;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i31;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i33; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  gh.factory<_i3.BottomNavigationCubit>(() => _i3.BottomNavigationCubit());
  gh.factory<_i4.FileRepository>(() => _i5.FileRepositoryImpl());
  gh.factory<_i6.FirebaseAuth>(() => localModule.firebaseAuth);
  gh.factory<_i7.FirebaseFirestore>(() => localModule.firebaseFirestore);
  gh.factory<_i8.HiveInterface>(() => localModule.hive);
  gh.factory<_i9.ImagePicker>(() => localModule.imagePicker);
  gh.factory<_i10.RevisionRepository>(
      () => _i11.RevisionRepositoryImpl(get<_i7.FirebaseFirestore>()));
  await gh.factoryAsync<_i12.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i13.UploadCameraImageUseCase>(() => _i13.UploadCameraImageUseCase(
      get<_i4.FileRepository>(), get<_i9.ImagePicker>()));
  gh.factory<_i14.UploadFileUseCase>(() => _i14.UploadFileUseCase(
      get<_i4.FileRepository>(), get<_i9.ImagePicker>()));
  gh.factory<_i15.UserRepository>(
      () => _i16.UserRepositoryImpl(get<_i7.FirebaseFirestore>()));
  gh.factory<_i17.AddTrophyCubit>(() => _i17.AddTrophyCubit(
      get<_i13.UploadCameraImageUseCase>(), get<_i14.UploadFileUseCase>()));
  gh.factory<_i18.AuthenticationRepository>(() =>
      _i19.AuthenticationRepositoryImpl(
          get<_i6.FirebaseAuth>(), get<_i7.FirebaseFirestore>()));
  gh.factory<_i20.CreateRevisionUseCase>(() => _i20.CreateRevisionUseCase(
      get<_i10.RevisionRepository>(), get<_i15.UserRepository>()));
  gh.factory<_i21.DeleteRevisionUseCase>(
      () => _i21.DeleteRevisionUseCase(get<_i10.RevisionRepository>()));
  gh.factory<_i22.GetAuthenticatedUserUseCase>(() =>
      _i22.GetAuthenticatedUserUseCase(get<_i18.AuthenticationRepository>()));
  gh.factory<_i23.LogInWithGoogleUseCase>(
      () => _i23.LogInWithGoogleUseCase(get<_i18.AuthenticationRepository>()));
  gh.factory<_i24.LoginUseCase>(
      () => _i24.LoginUseCase(get<_i18.AuthenticationRepository>()));
  gh.factory<_i25.LogoutUseCase>(
      () => _i25.LogoutUseCase(get<_i18.AuthenticationRepository>()));
  gh.factory<_i26.NewRevisionCubit>(
      () => _i26.NewRevisionCubit(get<_i20.CreateRevisionUseCase>()));
  gh.factory<_i27.SettingsRepository>(
      () => _i28.SettingRepositoryImpl(get<_i12.SharedPreferences>()));
  gh.factory<_i29.SignupUseCase>(
      () => _i29.SignupUseCase(get<_i18.AuthenticationRepository>()));
  gh.singleton<_i30.AuthenticationBloc>(_i30.AuthenticationBloc(
      get<_i25.LogoutUseCase>(),
      get<_i6.FirebaseAuth>(),
      get<_i22.GetAuthenticatedUserUseCase>()));
  gh.factory<_i31.LanguageBloc>(
      () => _i31.LanguageBloc(get<_i27.SettingsRepository>()));
  gh.factory<_i32.LoginCubit>(() => _i32.LoginCubit(get<_i24.LoginUseCase>(),
      get<_i30.AuthenticationBloc>(), get<_i23.LogInWithGoogleUseCase>()));
  gh.factory<_i33.SignUpCubit>(() => _i33.SignUpCubit(
      get<_i29.SignupUseCase>(), get<_i30.AuthenticationBloc>()));
  return get;
}

class _$LocalModule extends _i34.LocalModule {}
