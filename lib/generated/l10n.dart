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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Password Safe`
  String get appName {
    return Intl.message(
      'Password Safe',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Add a password`
  String get screensPasswordAddTitle {
    return Intl.message(
      'Add a password',
      name: 'screensPasswordAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get screensPasswordEditTitle {
    return Intl.message(
      'Edit',
      name: 'screensPasswordEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get screensPassPhraseSetTitle {
    return Intl.message(
      'Configuration',
      name: 'screensPassPhraseSetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Authentification`
  String get screensPassPhraseAuthTitle {
    return Intl.message(
      'Authentification',
      name: 'screensPassPhraseAuthTitle',
      desc: '',
      args: [],
    );
  }

  /// `List passwords`
  String get screensPasswordListTitle {
    return Intl.message(
      'List passwords',
      name: 'screensPasswordListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get screensSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'screensSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Development`
  String get screensDevelopmentTitle {
    return Intl.message(
      'Development',
      name: 'screensDevelopmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get listPasswordEdit {
    return Intl.message(
      'Edit',
      name: 'listPasswordEdit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get listPasswordDelete {
    return Intl.message(
      'Delete',
      name: 'listPasswordDelete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get listPasswordDeleteAlertTitle {
    return Intl.message(
      'Confirm deletion',
      name: 'listPasswordDeleteAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password decrypted and copied`
  String get listPasswordPasswordCopied {
    return Intl.message(
      'Password decrypted and copied',
      name: 'listPasswordPasswordCopied',
      desc: '',
      args: [],
    );
  }

  /// `Visit link`
  String get listPasswordLink {
    return Intl.message(
      'Visit link',
      name: 'listPasswordLink',
      desc: '',
      args: [],
    );
  }

  /// `Define a passphrase.\nIt will be used to encrypt your password and it will be asked for each access to the application.\nPlease choose your passphrase carefully.\nThis action is irreversible.`
  String get formsPasswordSetPassWarning {
    return Intl.message(
      'Define a passphrase.\nIt will be used to encrypt your password and it will be asked for each access to the application.\nPlease choose your passphrase carefully.\nThis action is irreversible.',
      name: 'formsPasswordSetPassWarning',
      desc: '',
      args: [],
    );
  }

  /// `Choose a passphrase`
  String get formsPasswordSetPassPhraseLabel {
    return Intl.message(
      'Choose a passphrase',
      name: 'formsPasswordSetPassPhraseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Use to encrypt your password`
  String get formsPasswordSetPassPhraseHint {
    return Intl.message(
      'Use to encrypt your password',
      name: 'formsPasswordSetPassPhraseHint',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase is required.`
  String get formsPasswordSetPassPhraseEmpty {
    return Intl.message(
      'Passphrase is required.',
      name: 'formsPasswordSetPassPhraseEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passphrase must contain more than 8 characters.`
  String get formsPasswordSetPassPhraseLenght {
    return Intl.message(
      'Passphrase must contain more than 8 characters.',
      name: 'formsPasswordSetPassPhraseLenght',
      desc: '',
      args: [],
    );
  }

  /// `Authentification`
  String get formsPassPhraseSetAuthLabel {
    return Intl.message(
      'Authentification',
      name: 'formsPassPhraseSetAuthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your passphrase`
  String get formsPassPhraseSetAuthHint {
    return Intl.message(
      'Enter your passphrase',
      name: 'formsPassPhraseSetAuthHint',
      desc: '',
      args: [],
    );
  }

  /// `Easily find your password.`
  String get formsPasswordAddNameHint {
    return Intl.message(
      'Easily find your password.',
      name: 'formsPasswordAddNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Choose a name`
  String get formsPasswordAddNameLabel {
    return Intl.message(
      'Choose a name',
      name: 'formsPasswordAddNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Name is required.`
  String get formsPasswordAddValidatorNameEmpty {
    return Intl.message(
      'Name is required.',
      name: 'formsPasswordAddValidatorNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name must contain more than 3 characters.`
  String get formsPasswordAddValidatorNameLenght {
    return Intl.message(
      'Name must contain more than 3 characters.',
      name: 'formsPasswordAddValidatorNameLenght',
      desc: '',
      args: [],
    );
  }

  /// `Easily find your password.`
  String get formsPasswordAddCategoryHint {
    return Intl.message(
      'Easily find your password.',
      name: 'formsPasswordAddCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category (optional)`
  String get formsPasswordAddCategoryLabel {
    return Intl.message(
      'Choose a category (optional)',
      name: 'formsPasswordAddCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `No category created`
  String get formsPasswordAddCategoryEmpty {
    return Intl.message(
      'No category created',
      name: 'formsPasswordAddCategoryEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Webiste (optional)`
  String get formsPasswordAddWebsiteLabel {
    return Intl.message(
      'Webiste (optional)',
      name: 'formsPasswordAddWebsiteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Is the password linked to a website?`
  String get formsPasswordAddWebsiteHint {
    return Intl.message(
      'Is the password linked to a website?',
      name: 'formsPasswordAddWebsiteHint',
      desc: '',
      args: [],
    );
  }

  /// `Is not a valid domain name.`
  String get formsPasswordAddWebsiteValidatorUrl {
    return Intl.message(
      'Is not a valid domain name.',
      name: 'formsPasswordAddWebsiteValidatorUrl',
      desc: '',
      args: [],
    );
  }

  /// `Service (optional)`
  String get formsPasswordAddServiceLabel {
    return Intl.message(
      'Service (optional)',
      name: 'formsPasswordAddServiceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Service (ex: Hotmail, Gmail, ...).`
  String get formsPasswordAddServiceHint {
    return Intl.message(
      'Service (ex: Hotmail, Gmail, ...).',
      name: 'formsPasswordAddServiceHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get formsPasswordAddPasswordLabel {
    return Intl.message(
      'Password',
      name: 'formsPasswordAddPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `The password will be encrypted (AES).`
  String get formsPasswordAddPasswordHint {
    return Intl.message(
      'The password will be encrypted (AES).',
      name: 'formsPasswordAddPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password is required.`
  String get formsPasswordAddValidatorPasswordEmpty {
    return Intl.message(
      'Password is required.',
      name: 'formsPasswordAddValidatorPasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Change color`
  String get formsPasswordAddChangeColor {
    return Intl.message(
      'Change color',
      name: 'formsPasswordAddChangeColor',
      desc: '',
      args: [],
    );
  }

  /// `Authentication request (minutes)`
  String get formsSettingsTimeoutLabel {
    return Intl.message(
      'Authentication request (minutes)',
      name: 'formsSettingsTimeoutLabel',
      desc: '',
      args: [],
    );
  }

  /// `L'authentification sera demandé tous les x minutes`
  String get formsSettingsTimeoutHint {
    return Intl.message(
      'L\'authentification sera demandé tous les x minutes',
      name: 'formsSettingsTimeoutHint',
      desc: '',
      args: [],
    );
  }

  /// `Authentication request is required`
  String get formsSettingsTimeoutEmpty {
    return Intl.message(
      'Authentication request is required',
      name: 'formsSettingsTimeoutEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Authentication must be equal or higher than 1 minutes`
  String get formsSettingsTimeoutNotLess {
    return Intl.message(
      'Authentication must be equal or higher than 1 minutes',
      name: 'formsSettingsTimeoutNotLess',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved.`
  String get settingsScreenFormSaveScaffoldMessenger {
    return Intl.message(
      'Settings saved.',
      name: 'settingsScreenFormSaveScaffoldMessenger',
      desc: '',
      args: [],
    );
  }

  /// `s left`
  String get navDrawerSecondsLeft {
    return Intl.message(
      's left',
      name: 'navDrawerSecondsLeft',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
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
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}