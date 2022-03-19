// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i12;
import 'package:connectivity_plus/connectivity_plus.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i13;
import 'package:image_picker/image_picker.dart' as _i14;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import 'core/modules/local_module.dart' as _i62;
import 'feature/data/repositories/authentication_repository_impl.dart' as _i26;
import 'feature/data/repositories/file_pdf_repository_impl.dart' as _i8;
import 'feature/data/repositories/file_repository_impl.dart' as _i10;
import 'feature/data/repositories/product_repository_impl.dart' as _i16;
import 'feature/data/repositories/revision_repository_impl.dart' as _i19;
import 'feature/data/repositories/settings_repository_impl.dart' as _i51;
import 'feature/data/repositories/user_repository_impl.dart' as _i24;
import 'feature/domain/repositories/authentication_repository.dart' as _i25;
import 'feature/domain/repositories/file_pdf_repository.dart' as _i7;
import 'feature/domain/repositories/file_repository.dart' as _i9;
import 'feature/domain/repositories/product_repository.dart' as _i15;
import 'feature/domain/repositories/revision_repository.dart' as _i18;
import 'feature/domain/repositories/settings_repository.dart' as _i50;
import 'feature/domain/repositories/user_repository.dart' as _i23;
import 'feature/domain/usecases/add_trusted_usecase.dart' as _i53;
import 'feature/domain/usecases/create_product_usecase.dart' as _i27;
import 'feature/domain/usecases/create_revision_usecase.dart' as _i28;
import 'feature/domain/usecases/delete_product_usecase.dart' as _i29;
import 'feature/domain/usecases/delete_revision_usecase.dart' as _i30;
import 'feature/domain/usecases/delete_trusted_usecase.dart' as _i54;
import 'feature/domain/usecases/edit_product_usecase.dart' as _i31;
import 'feature/domain/usecases/edit_revision_usecase.dart' as _i32;
import 'feature/domain/usecases/get_authenticated_user_usecase.dart' as _i33;
import 'feature/domain/usecases/get_info_usecase.dart' as _i34;
import 'feature/domain/usecases/get_products_usecase.dart' as _i35;
import 'feature/domain/usecases/get_revisions_usecase.dart' as _i36;
import 'feature/domain/usecases/get_verification_usecase.dart' as _i37;
import 'feature/domain/usecases/login_usecase.dart' as _i38;
import 'feature/domain/usecases/logout_usecase.dart' as _i39;
import 'feature/domain/usecases/open_close_revision_usecase.dart' as _i40;
import 'feature/domain/usecases/open_revision_pdf_usecase.dart' as _i41;
import 'feature/domain/usecases/singup_usecase.dart' as _i52;
import 'feature/domain/usecases/upload_camera_usecase.dart' as _i21;
import 'feature/domain/usecases/upload_gallery_usecase.dart' as _i22;
import 'feature/domain/usecases/verification_email_usecase.dart' as _i55;
import 'feature/presentation/pages/archive/cubit/archive_cubit.dart' as _i56;
import 'feature/presentation/pages/archive/cubit/revision_pdf_cubit.dart'
    as _i49;
import 'feature/presentation/pages/authentication/bloc/authentication_bloc.dart'
    as _i57;
import 'feature/presentation/pages/home/cubit/bottom_navigation_cubit.dart'
    as _i3;
import 'feature/presentation/pages/login/cubit/login_cubit.dart' as _i59;
import 'feature/presentation/pages/product_add/cubit/product_add_cubit.dart'
    as _i42;
import 'feature/presentation/pages/product_edit/cubit/product_edit_cubit.dart'
    as _i43;
import 'feature/presentation/pages/profile/cubit/profile_cubit.dart' as _i17;
import 'feature/presentation/pages/revision/cubit/change_body_to_cubit.dart'
    as _i5;
import 'feature/presentation/pages/revision/cubit/revision_cubit.dart' as _i46;
import 'feature/presentation/pages/revision_create/cubit/revision_create_cubit.dart'
    as _i45;
import 'feature/presentation/pages/revision_edit/cubit/revision_edit_cubit.dart'
    as _i47;
import 'feature/presentation/pages/revision_info/cubit/revision_info_cubit.dart'
    as _i48;
import 'feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart'
    as _i4;
import 'feature/presentation/pages/revisions_active/cubit/revisions_active_list_cubit.dart'
    as _i44;
import 'feature/presentation/pages/settings/language/bloc/language_bloc.dart'
    as _i58;
import 'feature/presentation/pages/sign_up/cubit/sign_up_cubit.dart' as _i60;
import 'feature/presentation/pages/trusted_revision/cubit/trusted_change_cubit.dart'
    as _i61; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  gh.factory<_i3.BottomNavigationCubit>(() => _i3.BottomNavigationCubit());
  gh.factory<_i4.ChangeBodyCubit>(() => _i4.ChangeBodyCubit());
  gh.factory<_i5.ChangeBodyToCubit>(() => _i5.ChangeBodyToCubit());
  gh.factory<_i6.Connectivity>(() => localModule.connectivity);
  gh.factory<_i7.FilePDFRepository>(() => _i8.FilePDFRepositoryImpl());
  gh.factory<_i9.FileRepository>(() => _i10.FileRepositoryImpl());
  gh.factory<_i11.FirebaseAuth>(() => localModule.firebaseAuth);
  gh.factory<_i12.FirebaseFirestore>(() => localModule.firebaseFirestore);
  gh.factory<_i13.HiveInterface>(() => localModule.hive);
  gh.factory<_i14.ImagePicker>(() => localModule.imagePicker);
  gh.factory<_i15.ProductRepository>(() => _i16.ProductRepositoryImpl(
      get<_i12.FirebaseFirestore>(),
      get<_i13.HiveInterface>(),
      get<_i6.Connectivity>()));
  gh.factory<_i17.ProfileCubit>(() => _i17.ProfileCubit());
  gh.factory<_i18.RevisionRepository>(() => _i19.RevisionRepositoryImpl(
      get<_i12.FirebaseFirestore>(),
      get<_i13.HiveInterface>(),
      get<_i6.Connectivity>()));
  await gh.factoryAsync<_i20.SharedPreferences>(() => localModule.prefs,
      preResolve: true);
  gh.factory<_i21.UploadCameraImageUseCase>(() => _i21.UploadCameraImageUseCase(
      get<_i9.FileRepository>(), get<_i14.ImagePicker>()));
  gh.factory<_i22.UploadFileUseCase>(() => _i22.UploadFileUseCase(
      get<_i9.FileRepository>(), get<_i14.ImagePicker>()));
  gh.factory<_i23.UserRepository>(() => _i24.UserRepositoryImpl(
      get<_i12.FirebaseFirestore>(),
      get<_i11.FirebaseAuth>(),
      get<_i13.HiveInterface>(),
      get<_i6.Connectivity>()));
  gh.factory<_i25.AuthenticationRepository>(() =>
      _i26.AuthenticationRepositoryImpl(
          get<_i11.FirebaseAuth>(),
          get<_i12.FirebaseFirestore>(),
          get<_i13.HiveInterface>(),
          get<_i6.Connectivity>(),
          get<_i20.SharedPreferences>()));
  gh.factory<_i27.CreateProductUseCase>(() => _i27.CreateProductUseCase(
      get<_i15.ProductRepository>(), get<_i18.RevisionRepository>()));
  gh.factory<_i28.CreateRevisionUseCase>(() => _i28.CreateRevisionUseCase(
      get<_i18.RevisionRepository>(), get<_i23.UserRepository>()));
  gh.factory<_i29.DeleteProductsUseCase>(() => _i29.DeleteProductsUseCase(
      get<_i18.RevisionRepository>(), get<_i15.ProductRepository>()));
  gh.factory<_i30.DeleteRevisionUseCase>(() => _i30.DeleteRevisionUseCase(
      get<_i18.RevisionRepository>(), get<_i23.UserRepository>()));
  gh.factory<_i31.EditProductUseCase>(
      () => _i31.EditProductUseCase(get<_i15.ProductRepository>()));
  gh.factory<_i32.EditRevisionUseCase>(
      () => _i32.EditRevisionUseCase(get<_i18.RevisionRepository>()));
  gh.factory<_i33.GetAuthenticatedUserUseCase>(() =>
      _i33.GetAuthenticatedUserUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i34.GetInfoUseCase>(() => _i34.GetInfoUseCase(
      get<_i15.ProductRepository>(), get<_i23.UserRepository>()));
  gh.factory<_i35.GetProductsUseCase>(
      () => _i35.GetProductsUseCase(get<_i15.ProductRepository>()));
  gh.factory<_i36.GetRevisionsUseCase>(
      () => _i36.GetRevisionsUseCase(get<_i18.RevisionRepository>()));
  gh.factory<_i37.GetVerificationUseCase>(
      () => _i37.GetVerificationUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i38.LoginUseCase>(
      () => _i38.LoginUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i39.LogoutUseCase>(
      () => _i39.LogoutUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i40.OpenCloseRevisionUseCase>(
      () => _i40.OpenCloseRevisionUseCase(get<_i18.RevisionRepository>()));
  gh.factory<_i41.OpenRevisionPDFUseCase>(() => _i41.OpenRevisionPDFUseCase(
      get<_i7.FilePDFRepository>(), get<_i15.ProductRepository>()));
  gh.factory<_i42.ProductAddCubit>(
      () => _i42.ProductAddCubit(get<_i27.CreateProductUseCase>()));
  gh.factory<_i43.ProductEditCubit>(
      () => _i43.ProductEditCubit(get<_i31.EditProductUseCase>()));
  gh.factory<_i44.RevisionActiveListCubit>(() => _i44.RevisionActiveListCubit(
      get<_i36.GetRevisionsUseCase>(),
      get<_i30.DeleteRevisionUseCase>(),
      get<_i40.OpenCloseRevisionUseCase>()));
  gh.factory<_i45.RevisionCreateCubit>(
      () => _i45.RevisionCreateCubit(get<_i28.CreateRevisionUseCase>()));
  gh.factory<_i46.RevisionCubit>(() => _i46.RevisionCubit(
      get<_i35.GetProductsUseCase>(), get<_i29.DeleteProductsUseCase>()));
  gh.factory<_i47.RevisionEditCubit>(
      () => _i47.RevisionEditCubit(get<_i32.EditRevisionUseCase>()));
  gh.factory<_i48.RevisionInfoCubit>(
      () => _i48.RevisionInfoCubit(get<_i34.GetInfoUseCase>()));
  gh.factory<_i49.RevisionPdfCubit>(
      () => _i49.RevisionPdfCubit(get<_i41.OpenRevisionPDFUseCase>()));
  gh.factory<_i50.SettingsRepository>(
      () => _i51.SettingRepositoryImpl(get<_i20.SharedPreferences>()));
  gh.factory<_i52.SignupUseCase>(
      () => _i52.SignupUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i53.TrustedAddUseCase>(() => _i53.TrustedAddUseCase(
      get<_i18.RevisionRepository>(), get<_i23.UserRepository>()));
  gh.factory<_i54.TrustedDeleteUseCase>(() => _i54.TrustedDeleteUseCase(
      get<_i18.RevisionRepository>(), get<_i23.UserRepository>()));
  gh.factory<_i55.VerificationEmailUseCase>(() =>
      _i55.VerificationEmailUseCase(get<_i25.AuthenticationRepository>()));
  gh.factory<_i56.ArchiveCubit>(() => _i56.ArchiveCubit(
      get<_i36.GetRevisionsUseCase>(), get<_i40.OpenCloseRevisionUseCase>()));
  gh.singleton<_i57.AuthenticationBloc>(_i57.AuthenticationBloc(
      get<_i39.LogoutUseCase>(),
      get<_i11.FirebaseAuth>(),
      get<_i33.GetAuthenticatedUserUseCase>(),
      get<_i37.GetVerificationUseCase>(),
      get<_i55.VerificationEmailUseCase>()));
  gh.factory<_i58.LanguageBloc>(
      () => _i58.LanguageBloc(get<_i50.SettingsRepository>()));
  gh.factory<_i59.LoginCubit>(() => _i59.LoginCubit(
      get<_i38.LoginUseCase>(), get<_i57.AuthenticationBloc>()));
  gh.factory<_i60.SignUpCubit>(() => _i60.SignUpCubit(
      get<_i52.SignupUseCase>(), get<_i57.AuthenticationBloc>()));
  gh.factory<_i61.TrustedChangeCubit>(() => _i61.TrustedChangeCubit(
      get<_i53.TrustedAddUseCase>(), get<_i54.TrustedDeleteUseCase>()));
  return get;
}

class _$LocalModule extends _i62.LocalModule {}
