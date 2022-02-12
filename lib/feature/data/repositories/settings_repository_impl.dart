import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingRepositoryImpl implements SettingsRepository {
  static const _languageSettingsKey = 'language_key';
  final SharedPreferences _prefs;

  SettingRepositoryImpl(this._prefs);

  @override
  Future<Either<Failure, Locale>> getLanguageSettings() async {
    try {
      if (!_prefs.containsKey(_languageSettingsKey)) {
        final currentLocale = Locale(Intl.getCurrentLocale());
        return Right(currentLocale.languageCode.contains('ru')
            ? const Locale('ru')
            : const Locale('en'));
      }
      final language = _prefs.getString(_languageSettingsKey);
      if (language != null) {
        return Right(Locale(language));
      } else {
        return const Right(Locale('en'));
      }
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setLanguageSettings(Locale locale) async {
    try {
      await _prefs.setString(_languageSettingsKey, locale.languageCode);
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
