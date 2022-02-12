// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Facebook`
  String get logInFacebook {
    return Intl.message(
      'Log In with Facebook',
      name: 'logInFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Facebook`
  String get signUpFacebook {
    return Intl.message(
      'Sign Up with Facebook',
      name: 'signUpFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `CLICK HERE`
  String get clickHere {
    return Intl.message(
      'CLICK HERE',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Send Again`
  String get sendAgain {
    return Intl.message(
      'Send Again',
      name: 'sendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPassword {
    return Intl.message(
      'Create New Password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Restore Password`
  String get restorePassword {
    return Intl.message(
      'Restore Password',
      name: 'restorePassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message(
      'Send Email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check your Email`
  String get checkEmail {
    return Intl.message(
      'Check your Email',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email has been sent`
  String get confirmationEmailSent {
    return Intl.message(
      'A confirmation email has been sent',
      name: 'confirmationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `We will send you a confirmation email`
  String get sendConfirmationEmail {
    return Intl.message(
      'We will send you a confirmation email',
      name: 'sendConfirmationEmail',
      desc: '',
      args: [],
    );
  }

  /// `The e-mail address is incorrect. Please try again`
  String get errorEmailInputLogin {
    return Intl.message(
      'The e-mail address is incorrect. Please try again',
      name: 'errorEmailInputLogin',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect. Please try again`
  String get errorPasswordInputLogin {
    return Intl.message(
      'The password is incorrect. Please try again',
      name: 'errorPasswordInputLogin',
      desc: '',
      args: [],
    );
  }

  /// `Select your Country`
  String get selectCountry {
    return Intl.message(
      'Select your Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `The e-mail address is incorrect. Please try again`
  String get errorEmailInputForgot {
    return Intl.message(
      'The e-mail address is incorrect. Please try again',
      name: 'errorEmailInputForgot',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect. Please try again`
  String get errorPasswordInputForgot {
    return Intl.message(
      'The password is incorrect. Please try again',
      name: 'errorPasswordInputForgot',
      desc: '',
      args: [],
    );
  }

  /// `Min 10 characters`
  String get commentTextPasswordForgot {
    return Intl.message(
      'Min 10 characters',
      name: 'commentTextPasswordForgot',
      desc: '',
      args: [],
    );
  }

  /// `The e-mail address is incorrect. Please try again`
  String get errorEmailInputSignup {
    return Intl.message(
      'The e-mail address is incorrect. Please try again',
      name: 'errorEmailInputSignup',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect. Please try again`
  String get errorPasswordInputSignup {
    return Intl.message(
      'The password is incorrect. Please try again',
      name: 'errorPasswordInputSignup',
      desc: '',
      args: [],
    );
  }

  /// `Won't be publicly displayed`
  String get commentTextEmailSignup {
    return Intl.message(
      'Won\'t be publicly displayed',
      name: 'commentTextEmailSignup',
      desc: '',
      args: [],
    );
  }

  /// `Password should have at least 10 symbols`
  String get commentTextPasswordSignup {
    return Intl.message(
      'Password should have at least 10 symbols',
      name: 'commentTextPasswordSignup',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Failure`
  String get authFailure {
    return Intl.message(
      'Authentication Failure',
      name: 'authFailure',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Camera/Foto`
  String get cameraFoto {
    return Intl.message(
      'Camera/Foto',
      name: 'cameraFoto',
      desc: '',
      args: [],
    );
  }

  /// `Camera/Video`
  String get cameraVideo {
    return Intl.message(
      'Camera/Video',
      name: 'cameraVideo',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Gallery/Foto`
  String get galleryFoto {
    return Intl.message(
      'Gallery/Foto',
      name: 'galleryFoto',
      desc: '',
      args: [],
    );
  }

  /// `Gallery/Video`
  String get galleryVideo {
    return Intl.message(
      'Gallery/Video',
      name: 'galleryVideo',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Add IRLA`
  String get addIRLA {
    return Intl.message(
      'Add IRLA',
      name: 'addIRLA',
      desc: '',
      args: [],
    );
  }

  /// `Share It`
  String get shareIt {
    return Intl.message(
      'Share It',
      name: 'shareIt',
      desc: '',
      args: [],
    );
  }

  /// `Serial number`
  String get serialNumber {
    return Intl.message(
      'Serial number',
      name: 'serialNumber',
      desc: '',
      args: [],
    );
  }

  /// `12 Characters`
  String get characters12 {
    return Intl.message(
      '12 Characters',
      name: 'characters12',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `You have just added a new IRLA to your collection. Share this achievement with your friends.`
  String get addedNewIRLA {
    return Intl.message(
      'You have just added a new IRLA to your collection. Share this achievement with your friends.',
      name: 'addedNewIRLA',
      desc: '',
      args: [],
    );
  }

  /// `If you choose to upload memories for this IRLA, you will be eligible for additional leaderboard points (once verified by a moderator).`
  String get informationNewIRLA {
    return Intl.message(
      'If you choose to upload memories for this IRLA, you will be eligible for additional leaderboard points (once verified by a moderator).',
      name: 'informationNewIRLA',
      desc: '',
      args: [],
    );
  }

  /// `Upload a picture/video of yourself completing the IRLA (optional)`
  String get uploadFileNewIRLA {
    return Intl.message(
      'Upload a picture/video of yourself completing the IRLA (optional)',
      name: 'uploadFileNewIRLA',
      desc: '',
      args: [],
    );
  }

  /// `Add a journal entry to help you remember how you earned this IRLA (optional)`
  String get addDescriptionNewIRLA {
    return Intl.message(
      'Add a journal entry to help you remember how you earned this IRLA (optional)',
      name: 'addDescriptionNewIRLA',
      desc: '',
      args: [],
    );
  }

  /// `Tracked IRLAs`
  String get trackedIRLAs {
    return Intl.message(
      'Tracked IRLAs',
      name: 'trackedIRLAs',
      desc: '',
      args: [],
    );
  }

  /// `points`
  String get points {
    return Intl.message(
      'points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Trophy`
  String get trophy {
    return Intl.message(
      'Trophy',
      name: 'trophy',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Personal Account`
  String get personalAccount {
    return Intl.message(
      'Personal Account',
      name: 'personalAccount',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `My Friends`
  String get myFriends {
    return Intl.message(
      'My Friends',
      name: 'myFriends',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get leaderboard {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboard',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `File is not open`
  String get fileNotOpened {
    return Intl.message(
      'File is not open',
      name: 'fileNotOpened',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
