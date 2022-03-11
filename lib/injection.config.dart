// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i11;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import 'core/modules/local_module.dart' as _i50;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i23;
import 'feature/data/repositories/file_pdf_repository_impl.dart' as _i6;
import 'feature/data/repositories/file_repository_impl.dart' as _i8;
import 'feature/data/repositories/product_repository_impl.dart' as _i13;
import 'feature/data/repositories/revision_repository_impl.dart' as _i16;
import 'feature/data/repositories/settings_repository_impl.dart' as _i43;
import 'feature/data/repositories/user_repository_impl.dart' as _i21;
import 'feature/domain/repositories/authentication_repository.dart' as _i22;
import 'feature/domain/repositories/file_pdf_repository.dart' as _i5;
import 'feature/domain/repositories/file_repository.dart' as _i7;
import 'feature/domain/repositories/product_repository.dart' as _i12;
import 'feature/domain/repositories/revision_repository.dart' as _i15;
import 'feature/domain/repositories/settings_repository.dart' as _i42;
import 'feature/domain/repositories/user_repository.dart' as _i20;
import 'feature/domain/usecases/create_product_usecase.dart' as _i24;
import 'feature/domain/usecases/create_revision_usecase.dart' as _i25;
import 'feature/domain/usecases/delete_product_usecase.dart' as _i26;
import 'feature/domain/usecases/delete_revision_usecase.dart' as _i27;
import 'feature/domain/usecases/get_all_users_usecase.dart' as _i28;
import 'feature/domain/usecases/get_authenticated_user_usecase.dart' as _i29;
import 'feature/domain/usecases/get_products_usecase.dart' as _i30;
import 'feature/domain/usecases/get_revisions_usecase.dart' as _i31;
import 'feature/domain/usecases/login_usecase.dart' as _i33;
import 'feature/domain/usecases/login_with_google_usecase.dart' as _i32;
import 'feature/domain/usecases/logout_usecase.dart' as _i34;
import 'feature/domain/usecases/open_close_revision_usecase.dart' as _i36;
import 'feature/domain/usecases/open_revision_pdf_usecase.dart' as _i37;
import 'feature/domain/usecases/singup_usecase.dart' as _i44;
import 'feature/domain/usecases/upload_camera_image_usecase.dart' as _i18;
import 'feature/domain/usecases/upload_file_usecase.dart' as _i19;
import 'feature/presentation/pages/archive/cubit/archive_cubit.dart' as _i45;
import 'feature/presentation/pages/archive/cubit/revision_pdf_cubit.dart'
    as _i41;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i46;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i48;
import 'feature/presentation/pages/new_revision/cubit/new_revision_cubit.dart'
    as _i35;
import 'feature/presentation/pages/product_add/cubit/product_add_cubit.dart'
    as _i38;
import 'feature/presentation/pages/profile/cubit/profile_cubit.dart' as _i14;
import 'feature/presentation/pages/revision/cubit/change_body_to_cubit.dart'
    as _i4;
import 'feature/presentation/pages/revision/cubit/revision_cubit.dart' as _i40;
import 'feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart'
    as _i39;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i47;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i49; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  gh.factory<_i3.BottomNavigationCubit>(() => _i3.BottomNavigationCubit());
  gh.factory<_i4.ChangeBodyToCubit>(() => _i4.ChangeBodyToCubit());
  gh.factory<_i5.FilePDFRepository>(() => _i6.FilePDFRepositoryImpl());
  gh.factory<_i7.FileRepository>(() => _i8.FileRepositoryImpl());
  gh.factory<_i9.FirebaseAuth>(() => localModule.firebaseAuth);
  gh.factory<_i10.FirebaseFirestore>(() => localModule.firebaseFirestore);
  gh.factory<_i11.ImagePicker>(() => localModule.imagePicker);
  gh.factory<_i12.ProductRepository>(
      () => _i13.ProductRepositoryImpl(get<_i10.FirebaseFirestore>()));
  gh.factory<_i14.ProfileCubit>(() => _i14.ProfileCubit());
  gh.factory<_i15.RevisionRepository>(
      () => _i16.RevisionRepositoryImpl(get<_i10.FirebaseFirestore>()));
  await gh.factoryAsync<_i17.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i18.UploadCameraImageUseCase>(() => _i18.UploadCameraImageUseCase(
      get<_i7.FileRepository>(), get<_i11.ImagePicker>()));
  gh.factory<_i19.UploadFileUseCase>(() => _i19.UploadFileUseCase(
      get<_i7.FileRepository>(), get<_i11.ImagePicker>()));
  gh.factory<_i20.UserRepository>(() => _i21.UserRepositoryImpl(
      get<_i10.FirebaseFirestore>(), get<_i9.FirebaseAuth>()));
  gh.factory<_i22.AuthenticationRepository>(() =>
      _i23.AuthenticationRepositoryImpl(
          get<_i9.FirebaseAuth>(), get<_i10.FirebaseFirestore>()));
  gh.factory<_i24.CreateProductUseCase>(() => _i24.CreateProductUseCase(
      get<_i12.ProductRepository>(), get<_i15.RevisionRepository>()));
  gh.factory<_i25.CreateRevisionUseCase>(() => _i25.CreateRevisionUseCase(
      get<_i15.RevisionRepository>(), get<_i20.UserRepository>()));
  gh.factory<_i26.DeleteProductsUseCase>(() => _i26.DeleteProductsUseCase(
      get<_i15.RevisionRepository>(), get<_i12.ProductRepository>()));
  gh.factory<_i27.DeleteRevisionUseCase>(() => _i27.DeleteRevisionUseCase(
      get<_i15.RevisionRepository>(), get<_i20.UserRepository>()));
  gh.factory<_i28.GetAllUserUseCase>(
      () => _i28.GetAllUserUseCase(get<_i20.UserRepository>()));
  gh.factory<_i29.GetAuthenticatedUserUseCase>(() =>
      _i29.GetAuthenticatedUserUseCase(get<_i22.AuthenticationRepository>()));
  gh.factory<_i30.GetProductsUseCase>(
      () => _i30.GetProductsUseCase(get<_i12.ProductRepository>()));
  gh.factory<_i31.GetRevisionsUseCase>(
      () => _i31.GetRevisionsUseCase(get<_i15.RevisionRepository>()));
  gh.factory<_i32.LogInWithGoogleUseCase>(
      () => _i32.LogInWithGoogleUseCase(get<_i22.AuthenticationRepository>()));
  gh.factory<_i33.LoginUseCase>(
      () => _i33.LoginUseCase(get<_i22.AuthenticationRepository>()));
  gh.factory<_i34.LogoutUseCase>(
      () => _i34.LogoutUseCase(get<_i22.AuthenticationRepository>()));
  gh.factory<_i35.NewRevisionCubit>(
      () => _i35.NewRevisionCubit(get<_i25.CreateRevisionUseCase>()));
  gh.factory<_i36.OpenCloseRevisionUseCase>(
      () => _i36.OpenCloseRevisionUseCase(get<_i15.RevisionRepository>()));
  gh.factory<_i37.OpenRevisionPDFUseCase>(() => _i37.OpenRevisionPDFUseCase(
      get<_i5.FilePDFRepository>(), get<_i12.ProductRepository>()));
  gh.factory<_i38.ProductAddCubit>(
      () => _i38.ProductAddCubit(get<_i24.CreateProductUseCase>()));
  gh.factory<_i39.RevisionActiveListCubit>(() => _i39.RevisionActiveListCubit(
      get<_i31.GetRevisionsUseCase>(),
      get<_i27.DeleteRevisionUseCase>(),
      get<_i36.OpenCloseRevisionUseCase>()));
  gh.factory<_i40.RevisionCubit>(() => _i40.RevisionCubit(
      get<_i30.GetProductsUseCase>(), get<_i26.DeleteProductsUseCase>()));
  gh.factory<_i41.RevisionPdfCubit>(
      () => _i41.RevisionPdfCubit(get<_i37.OpenRevisionPDFUseCase>()));
  gh.factory<_i42.SettingsRepository>(
      () => _i43.SettingRepositoryImpl(get<_i17.SharedPreferences>()));
  gh.factory<_i44.SignupUseCase>(
      () => _i44.SignupUseCase(get<_i22.AuthenticationRepository>()));
  gh.factory<_i45.ArchiveCubit>(() => _i45.ArchiveCubit(
      get<_i31.GetRevisionsUseCase>(), get<_i36.OpenCloseRevisionUseCase>()));
  gh.singleton<_i46.AuthenticationBloc>(_i46.AuthenticationBloc(
      get<_i34.LogoutUseCase>(),
      get<_i9.FirebaseAuth>(),
      get<_i29.GetAuthenticatedUserUseCase>()));
  gh.factory<_i47.LanguageBloc>(
      () => _i47.LanguageBloc(get<_i42.SettingsRepository>()));
  gh.factory<_i48.LoginCubit>(() => _i48.LoginCubit(get<_i33.LoginUseCase>(),
      get<_i46.AuthenticationBloc>(), get<_i32.LogInWithGoogleUseCase>()));
  gh.factory<_i49.SignUpCubit>(() => _i49.SignUpCubit(
      get<_i44.SignupUseCase>(), get<_i46.AuthenticationBloc>()));
  return get;
}

class _$LocalModule extends _i50.LocalModule {}
