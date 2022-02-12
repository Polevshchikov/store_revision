import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}
