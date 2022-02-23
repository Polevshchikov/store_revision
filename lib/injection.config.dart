// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i9;
import 'package:image_picker/image_picker.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import 'core/modules/local_module.dart' as _i43;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i21;
import 'feature/data/repositories/file_repository_impl.dart' as _i6;
import 'feature/data/repositories/product_repository_impl.dart' as _i12;
import 'feature/data/repositories/revision_repository_impl.dart' as _i14;
import 'feature/data/repositories/settings_repository_impl.dart' as _i37;
import 'feature/data/repositories/user_repository_impl.dart' as _i19;
import 'feature/domain/repositories/authentication_repository.dart' as _i20;
import 'feature/domain/repositories/file_repository.dart' as _i5;
import 'feature/domain/repositories/product_repository.dart' as _i11;
import 'feature/domain/repositories/revision_repository.dart' as _i13;
import 'feature/domain/repositories/settings_repository.dart' as _i36;
import 'feature/domain/repositories/user_repository.dart' as _i18;
import 'feature/domain/usecases/create_product_usecase.dart' as _i22;
import 'feature/domain/usecases/create_revision_usecase.dart' as _i23;
import 'feature/domain/usecases/delete_revision_usecase.dart' as _i24;
import 'feature/domain/usecases/get_all_users_usecase.dart' as _i25;
import 'feature/domain/usecases/get_authenticated_user_usecase.dart' as _i26;
import 'feature/domain/usecases/get_products_usecase.dart' as _i27;
import 'feature/domain/usecases/get_revisions_usecase.dart' as _i28;
import 'feature/domain/usecases/login_usecase.dart' as _i30;
import 'feature/domain/usecases/logIn_with_google_usecase.dart' as _i29;
import 'feature/domain/usecases/logout_usecase.dart' as _i31;
import 'feature/domain/usecases/singup_usecase.dart' as _i38;
import 'feature/domain/usecases/upload_camera_image_usecase.dart' as _i16;
import 'feature/domain/usecases/upload_file_usecase.dart' as _i17;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i39;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i41;
import 'feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart'
    as _i32;
import 'feature/presentation/pages/product_add/cubit/product_add_cubit.dart'
    as _i33;
import 'feature/presentation/pages/revision/cubit/change_body_to_cubit.dart'
    as _i4;
import 'feature/presentation/pages/revision/cubit/revision_cubit.dart' as _i35;
import 'feature/presentation/pages/revision_active/cubit/revision_active_list_cubit.dart'
    as _i34;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i40;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i42; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  gh.factory<_i3.BottomNavigationCubit>(() => _i3.BottomNavigationCubit());
  gh.factory<_i4.ChangeBodyToCubit>(() => _i4.ChangeBodyToCubit());
  gh.factory<_i5.FileRepository>(() => _i6.FileRepositoryImpl());
  gh.factory<_i7.FirebaseAuth>(() => localModule.firebaseAuth);
  gh.factory<_i8.FirebaseFirestore>(() => localModule.firebaseFirestore);
  gh.factory<_i9.HiveInterface>(() => localModule.hive);
  gh.factory<_i10.ImagePicker>(() => localModule.imagePicker);
  gh.factory<_i11.ProductRepository>(
      () => _i12.ProductRepositoryImpl(get<_i8.FirebaseFirestore>()));
  gh.factory<_i13.RevisionRepository>(
      () => _i14.RevisionRepositoryImpl(get<_i8.FirebaseFirestore>()));
  await gh.factoryAsync<_i15.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i16.UploadCameraImageUseCase>(() => _i16.UploadCameraImageUseCase(
      get<_i5.FileRepository>(), get<_i10.ImagePicker>()));
  gh.factory<_i17.UploadFileUseCase>(() => _i17.UploadFileUseCase(
      get<_i5.FileRepository>(), get<_i10.ImagePicker>()));
  gh.factory<_i18.UserRepository>(() => _i19.UserRepositoryImpl(
      get<_i8.FirebaseFirestore>(), get<_i7.FirebaseAuth>()));
  gh.factory<_i20.AuthenticationRepository>(() =>
      _i21.AuthenticationRepositoryImpl(
          get<_i7.FirebaseAuth>(), get<_i8.FirebaseFirestore>()));
  gh.factory<_i22.CreateProductUseCase>(() => _i22.CreateProductUseCase(
      get<_i11.ProductRepository>(), get<_i13.RevisionRepository>()));
  gh.factory<_i23.CreateRevisionUseCase>(() => _i23.CreateRevisionUseCase(
      get<_i13.RevisionRepository>(), get<_i18.UserRepository>()));
  gh.factory<_i24.DeleteRevisionUseCase>(
      () => _i24.DeleteRevisionUseCase(get<_i13.RevisionRepository>()));
  gh.factory<_i25.GetAllUserUseCase>(
      () => _i25.GetAllUserUseCase(get<_i18.UserRepository>()));
  gh.factory<_i26.GetAuthenticatedUserUseCase>(() =>
      _i26.GetAuthenticatedUserUseCase(get<_i20.AuthenticationRepository>()));
  gh.factory<_i27.GetProductsUseCase>(
      () => _i27.GetProductsUseCase(get<_i11.ProductRepository>()));
  gh.factory<_i28.GetRevisionsUseCase>(
      () => _i28.GetRevisionsUseCase(get<_i13.RevisionRepository>()));
  gh.factory<_i29.LogInWithGoogleUseCase>(
      () => _i29.LogInWithGoogleUseCase(get<_i20.AuthenticationRepository>()));
  gh.factory<_i30.LoginUseCase>(
      () => _i30.LoginUseCase(get<_i20.AuthenticationRepository>()));
  gh.factory<_i31.LogoutUseCase>(
      () => _i31.LogoutUseCase(get<_i20.AuthenticationRepository>()));
  gh.factory<_i32.NewRevisionCubit>(
      () => _i32.NewRevisionCubit(get<_i23.CreateRevisionUseCase>()));
  gh.factory<_i33.ProductAddCubit>(
      () => _i33.ProductAddCubit(get<_i22.CreateProductUseCase>()));
  gh.factory<_i34.RevisionActiveListCubit>(
      () => _i34.RevisionActiveListCubit(get<_i28.GetRevisionsUseCase>()));
  gh.factory<_i35.RevisionCubit>(
      () => _i35.RevisionCubit(get<_i27.GetProductsUseCase>()));
  gh.factory<_i36.SettingsRepository>(
      () => _i37.SettingRepositoryImpl(get<_i15.SharedPreferences>()));
  gh.factory<_i38.SignupUseCase>(
      () => _i38.SignupUseCase(get<_i20.AuthenticationRepository>()));
  gh.singleton<_i39.AuthenticationBloc>(_i39.AuthenticationBloc(
      get<_i31.LogoutUseCase>(),
      get<_i7.FirebaseAuth>(),
      get<_i26.GetAuthenticatedUserUseCase>()));
  gh.factory<_i40.LanguageBloc>(
      () => _i40.LanguageBloc(get<_i36.SettingsRepository>()));
  gh.factory<_i41.LoginCubit>(() => _i41.LoginCubit(get<_i30.LoginUseCase>(),
      get<_i39.AuthenticationBloc>(), get<_i29.LogInWithGoogleUseCase>()));
  gh.factory<_i42.SignUpCubit>(() => _i42.SignUpCubit(
      get<_i38.SignupUseCase>(), get<_i39.AuthenticationBloc>()));
  return get;
}

class _$LocalModule extends _i43.LocalModule {}
