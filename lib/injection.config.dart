// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i11;
import 'package:firebase_auth/firebase_auth.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i18;

import 'core/modules/local_module.dart' as _i54;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i24;
import 'feature/data/repositories/file_pdf_repository_impl.dart' as _i7;
import 'feature/data/repositories/file_repository_impl.dart' as _i9;
import 'feature/data/repositories/product_repository_impl.dart' as _i14;
import 'feature/data/repositories/revision_repository_impl.dart' as _i17;
import 'feature/data/repositories/settings_repository_impl.dart' as _i43;
import 'feature/data/repositories/user_repository_impl.dart' as _i22;
import 'feature/domain/repositories/authentication_repository.dart' as _i23;
import 'feature/domain/repositories/file_pdf_repository.dart' as _i6;
import 'feature/domain/repositories/file_repository.dart' as _i8;
import 'feature/domain/repositories/product_repository.dart' as _i13;
import 'feature/domain/repositories/revision_repository.dart' as _i16;
import 'feature/domain/repositories/settings_repository.dart' as _i42;
import 'feature/domain/repositories/user_repository.dart' as _i21;
import 'feature/domain/usecases/add_trusted_usecase.dart' as _i45;
import 'feature/domain/usecases/create_product_usecase.dart' as _i25;
import 'feature/domain/usecases/create_revision_usecase.dart' as _i26;
import 'feature/domain/usecases/delete_product_usecase.dart' as _i27;
import 'feature/domain/usecases/delete_revision_usecase.dart' as _i28;
import 'feature/domain/usecases/delete_trusted_usecase.dart' as _i46;
import 'feature/domain/usecases/get_authenticated_user_usecase.dart' as _i29;
import 'feature/domain/usecases/get_products_usecase.dart' as _i30;
import 'feature/domain/usecases/get_revisions_usecase.dart' as _i31;
import 'feature/domain/usecases/get_verification_usecase.dart' as _i32;
import 'feature/domain/usecases/login_usecase.dart' as _i33;
import 'feature/domain/usecases/logout_usecase.dart' as _i34;
import 'feature/domain/usecases/open_close_revision_usecase.dart' as _i35;
import 'feature/domain/usecases/open_revision_pdf_usecase.dart' as _i36;
import 'feature/domain/usecases/singup_usecase.dart' as _i44;
import 'feature/domain/usecases/upload_camera_usecase.dart' as _i19;
import 'feature/domain/usecases/upload_gallery_usecase.dart' as _i20;
import 'feature/domain/usecases/verification_email_usecase.dart' as _i47;
import 'feature/presentation/pages/archive/cubit/archive_cubit.dart' as _i48;
import 'feature/presentation/pages/archive/cubit/revision_pdf_cubit.dart'
    as _i41;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i49;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i51;
import 'feature/presentation/pages/product_add/cubit/product_add_cubit.dart'
    as _i37;
import 'feature/presentation/pages/profile/cubit/profile_cubit.dart' as _i15;
import 'feature/presentation/pages/revision/cubit/change_body_to_cubit.dart'
    as _i5;
import 'feature/presentation/pages/revision/cubit/revision_cubit.dart' as _i40;
import 'feature/presentation/pages/revision_create/cubit/revision_create_cubit.dart'
    as _i39;
import 'feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart'
    as _i4;
import 'feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart'
    as _i38;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i50;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart' as _i52;
import 'feature/presentation/pages/trusted_revision/cubit/trusted_change_cubit.dart'
    as _i53; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  gh.factory<_i3.BottomNavigationCubit>(() => _i3.BottomNavigationCubit());
  gh.factory<_i4.ChangeBodyCubit>(() => _i4.ChangeBodyCubit());
  gh.factory<_i5.ChangeBodyToCubit>(() => _i5.ChangeBodyToCubit());
  gh.factory<_i6.FilePDFRepository>(() => _i7.FilePDFRepositoryImpl());
  gh.factory<_i8.FileRepository>(() => _i9.FileRepositoryImpl());
  gh.factory<_i10.FirebaseAuth>(() => localModule.firebaseAuth);
  gh.factory<_i11.FirebaseFirestore>(() => localModule.firebaseFirestore);
  gh.factory<_i12.ImagePicker>(() => localModule.imagePicker);
  gh.factory<_i13.ProductRepository>(
      () => _i14.ProductRepositoryImpl(get<_i11.FirebaseFirestore>()));
  gh.factory<_i15.ProfileCubit>(() => _i15.ProfileCubit());
  gh.factory<_i16.RevisionRepository>(
      () => _i17.RevisionRepositoryImpl(get<_i11.FirebaseFirestore>()));
  await gh.factoryAsync<_i18.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i19.UploadCameraImageUseCase>(() => _i19.UploadCameraImageUseCase(
      get<_i8.FileRepository>(), get<_i12.ImagePicker>()));
  gh.factory<_i20.UploadFileUseCase>(() => _i20.UploadFileUseCase(
      get<_i8.FileRepository>(), get<_i12.ImagePicker>()));
  gh.factory<_i21.UserRepository>(() => _i22.UserRepositoryImpl(
      get<_i11.FirebaseFirestore>(), get<_i10.FirebaseAuth>()));
  gh.factory<_i23.AuthenticationRepository>(() =>
      _i24.AuthenticationRepositoryImpl(
          get<_i10.FirebaseAuth>(), get<_i11.FirebaseFirestore>()));
  gh.factory<_i25.CreateProductUseCase>(() => _i25.CreateProductUseCase(
      get<_i13.ProductRepository>(), get<_i16.RevisionRepository>()));
  gh.factory<_i26.CreateRevisionUseCase>(() => _i26.CreateRevisionUseCase(
      get<_i16.RevisionRepository>(), get<_i21.UserRepository>()));
  gh.factory<_i27.DeleteProductsUseCase>(() => _i27.DeleteProductsUseCase(
      get<_i16.RevisionRepository>(), get<_i13.ProductRepository>()));
  gh.factory<_i28.DeleteRevisionUseCase>(() => _i28.DeleteRevisionUseCase(
      get<_i16.RevisionRepository>(), get<_i21.UserRepository>()));
  gh.factory<_i29.GetAuthenticatedUserUseCase>(() =>
      _i29.GetAuthenticatedUserUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i30.GetProductsUseCase>(
      () => _i30.GetProductsUseCase(get<_i13.ProductRepository>()));
  gh.factory<_i31.GetRevisionsUseCase>(
      () => _i31.GetRevisionsUseCase(get<_i16.RevisionRepository>()));
  gh.factory<_i32.GetVerificationUseCase>(
      () => _i32.GetVerificationUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i33.LoginUseCase>(
      () => _i33.LoginUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i34.LogoutUseCase>(
      () => _i34.LogoutUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i35.OpenCloseRevisionUseCase>(
      () => _i35.OpenCloseRevisionUseCase(get<_i16.RevisionRepository>()));
  gh.factory<_i36.OpenRevisionPDFUseCase>(() => _i36.OpenRevisionPDFUseCase(
      get<_i6.FilePDFRepository>(), get<_i13.ProductRepository>()));
  gh.factory<_i37.ProductAddCubit>(
      () => _i37.ProductAddCubit(get<_i25.CreateProductUseCase>()));
  gh.factory<_i38.RevisionActiveListCubit>(() => _i38.RevisionActiveListCubit(
      get<_i31.GetRevisionsUseCase>(),
      get<_i28.DeleteRevisionUseCase>(),
      get<_i35.OpenCloseRevisionUseCase>()));
  gh.factory<_i39.RevisionCreateCubit>(
      () => _i39.RevisionCreateCubit(get<_i26.CreateRevisionUseCase>()));
  gh.factory<_i40.RevisionCubit>(() => _i40.RevisionCubit(
      get<_i30.GetProductsUseCase>(), get<_i27.DeleteProductsUseCase>()));
  gh.factory<_i41.RevisionPdfCubit>(
      () => _i41.RevisionPdfCubit(get<_i36.OpenRevisionPDFUseCase>()));
  gh.factory<_i42.SettingsRepository>(
      () => _i43.SettingRepositoryImpl(get<_i18.SharedPreferences>()));
  gh.factory<_i44.SignupUseCase>(
      () => _i44.SignupUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i45.TrustedAddUseCase>(() => _i45.TrustedAddUseCase(
      get<_i16.RevisionRepository>(), get<_i21.UserRepository>()));
  gh.factory<_i46.TrustedDeleteUseCase>(() => _i46.TrustedDeleteUseCase(
      get<_i16.RevisionRepository>(), get<_i21.UserRepository>()));
  gh.factory<_i47.VerificationEmailUseCase>(() =>
      _i47.VerificationEmailUseCase(get<_i23.AuthenticationRepository>()));
  gh.factory<_i48.ArchiveCubit>(() => _i48.ArchiveCubit(
      get<_i31.GetRevisionsUseCase>(), get<_i35.OpenCloseRevisionUseCase>()));
  gh.singleton<_i49.AuthenticationBloc>(_i49.AuthenticationBloc(
      get<_i34.LogoutUseCase>(),
      get<_i10.FirebaseAuth>(),
      get<_i29.GetAuthenticatedUserUseCase>(),
      get<_i32.GetVerificationUseCase>(),
      get<_i47.VerificationEmailUseCase>()));
  gh.factory<_i50.LanguageBloc>(
      () => _i50.LanguageBloc(get<_i42.SettingsRepository>()));
  gh.factory<_i51.LoginCubit>(() => _i51.LoginCubit(
      get<_i33.LoginUseCase>(), get<_i49.AuthenticationBloc>()));
  gh.factory<_i52.SignUpCubit>(() => _i52.SignUpCubit(
      get<_i44.SignupUseCase>(), get<_i49.AuthenticationBloc>()));
  gh.factory<_i53.TrustedChangeCubit>(() => _i53.TrustedChangeCubit(
      get<_i45.TrustedAddUseCase>(), get<_i46.TrustedDeleteUseCase>()));
  return get;
}

class _$LocalModule extends _i54.LocalModule {}
