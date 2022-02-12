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
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import 'core/modules/local_module.dart' as _i26;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i15;
import 'feature/data/repositories/file_repository_impl.dart' as _i5;
import 'feature/data/repositories/settings_repository_impl.dart' as _i20;
import 'feature/domain/repositories/authentication_repository.dart' as _i14;
import 'feature/domain/repositories/file_repository.dart' as _i4;
import 'feature/domain/repositories/settings_repository.dart' as _i19;
import 'feature/domain/usecases/login_usecase.dart' as _i17;
import 'feature/domain/usecases/logIn_with_google_usecase.dart' as _i16;
import 'feature/domain/usecases/logout_usecase.dart' as _i18;
import 'feature/domain/usecases/singup_usecase.dart' as _i21;
import 'feature/domain/usecases/upload_camera_image_usecase.dart' as _i11;
import 'feature/domain/usecases/upload_file_usecase.dart' as _i12;
import 'feature/presentation/pages/add_trophy/cubit/add_trophy_cubit.dart'
    as _i13;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i22;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i24;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i23;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

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
  await gh.factoryAsync<_i10.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i11.UploadCameraImageUseCase>(() => _i11.UploadCameraImageUseCase(
      get<_i4.FileRepository>(), get<_i9.ImagePicker>()));
  gh.factory<_i12.UploadFileUseCase>(() => _i12.UploadFileUseCase(
      get<_i4.FileRepository>(), get<_i9.ImagePicker>()));
  gh.factory<_i13.AddTrophyCubit>(() => _i13.AddTrophyCubit(
      get<_i11.UploadCameraImageUseCase>(), get<_i12.UploadFileUseCase>()));
  gh.factory<_i14.AuthenticationRepository>(() =>
      _i15.AuthenticationRepositoryImpl(
          get<_i6.FirebaseAuth>(), get<_i7.FirebaseFirestore>()));
  gh.factory<_i16.LogInWithGoogleUseCase>(
      () => _i16.LogInWithGoogleUseCase(get<_i14.AuthenticationRepository>()));
  gh.factory<_i17.LoginUseCase>(
      () => _i17.LoginUseCase(get<_i14.AuthenticationRepository>()));
  gh.factory<_i18.LogoutUseCase>(
      () => _i18.LogoutUseCase(get<_i14.AuthenticationRepository>()));
  gh.factory<_i19.SettingsRepository>(
      () => _i20.SettingRepositoryImpl(get<_i10.SharedPreferences>()));
  gh.factory<_i21.SignupUseCase>(
      () => _i21.SignupUseCase(get<_i14.AuthenticationRepository>()));
  gh.singleton<_i22.AuthenticationBloc>(
      _i22.AuthenticationBloc(get<_i18.LogoutUseCase>()));
  gh.factory<_i23.LanguageBloc>(
      () => _i23.LanguageBloc(get<_i19.SettingsRepository>()));
  gh.factory<_i24.LoginCubit>(() => _i24.LoginCubit(get<_i17.LoginUseCase>(),
      get<_i22.AuthenticationBloc>(), get<_i16.LogInWithGoogleUseCase>()));
  gh.factory<_i25.SignUpCubit>(() => _i25.SignUpCubit(
      get<_i21.SignupUseCase>(), get<_i22.AuthenticationBloc>()));
  return get;
}

class _$LocalModule extends _i26.LocalModule {}
