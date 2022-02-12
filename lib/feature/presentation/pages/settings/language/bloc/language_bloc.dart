import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:store_revision/feature/domain/repositories/settings_repository.dart';

import 'language_event.dart';
import 'language_state.dart';

@injectable
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final SettingsRepository _settingsRepository;

  LanguageBloc(this._settingsRepository)
      : super(const LanguageState(Locale('en', ''))) {
    on<LanguageInitialize>(_onInitialize);
    on<LanguageChanged>(_onChanged);
  }
  Future<void> _onInitialize(
    LanguageInitialize event,
    Emitter<LanguageState> emit,
  ) async {
    final savedLanguage = await _settingsRepository.getLanguageSettings();
    if (savedLanguage.isLeft()) {
      print('failed to load settings');
    }
    await initializeDateFormatting();
    emit(LanguageState(
        savedLanguage.fold((l) => const Locale('en', ''), (locale) {
      Intl.defaultLocale = locale.languageCode;
      return locale;
    })));
  }

  Future<void> _onChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    final result = await _settingsRepository.setLanguageSettings(event.locale);
    if (result.isLeft()) {
      print('failed to save settings');
    }
    await initializeDateFormatting();
    Intl.defaultLocale = event.locale.languageCode;
    emit(LanguageState(event.locale));
  }
}
