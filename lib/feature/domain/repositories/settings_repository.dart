import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:store_revision/core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Locale>> getLanguageSettings();

  Future<Either<Failure, void>> setLanguageSettings(Locale locale);
}
