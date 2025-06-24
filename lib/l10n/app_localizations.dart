import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get language;

  /// No description provided for @welcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать!'**
  String get welcome;

  /// No description provided for @withThis.
  ///
  /// In ru, this message translates to:
  /// **'С '**
  String get withThis;

  /// No description provided for @appName.
  ///
  /// In ru, this message translates to:
  /// **'kanban master'**
  String get appName;

  /// No description provided for @youCan.
  ///
  /// In ru, this message translates to:
  /// **' ты сможешь эффективно управлять своими проектами'**
  String get youCan;

  /// No description provided for @firstTime.
  ///
  /// In ru, this message translates to:
  /// **'Впервые у нас?'**
  String get firstTime;

  /// No description provided for @signUpButton.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get signUpButton;

  /// No description provided for @signIn.
  ///
  /// In ru, this message translates to:
  /// **'Вход в аккаунт'**
  String get signIn;

  /// No description provided for @signInButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get signInButton;

  /// No description provided for @username.
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя'**
  String get username;

  /// No description provided for @email.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @signUp.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get signUp;

  /// No description provided for @userNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя'**
  String get userNameHint;

  /// No description provided for @createAccountButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать аккаунт'**
  String get createAccountButton;

  /// No description provided for @haveAccount.
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт?'**
  String get haveAccount;

  /// No description provided for @returnToSignIn.
  ///
  /// In ru, this message translates to:
  /// **'Вернись к отслеживанию задач\nв '**
  String get returnToSignIn;

  /// No description provided for @alreadyExists.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь с таким email уже существует'**
  String get alreadyExists;

  /// No description provided for @tooShortPassword.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен быть не менее 8 символов'**
  String get tooShortPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат email'**
  String get invalidEmail;

  /// No description provided for @emptyEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email не может быть пустым'**
  String get emptyEmail;

  /// No description provided for @emptyPassword.
  ///
  /// In ru, this message translates to:
  /// **'Пароль не может быть пустым'**
  String get emptyPassword;

  /// No description provided for @invalidCredentials.
  ///
  /// In ru, this message translates to:
  /// **'Неверный email или пароль'**
  String get invalidCredentials;

  /// No description provided for @myProjects.
  ///
  /// In ru, this message translates to:
  /// **'Мои проекты'**
  String get myProjects;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get edit;

  /// No description provided for @errorOccured.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка, попробуйте еще раз'**
  String get errorOccured;

  /// No description provided for @newProject.
  ///
  /// In ru, this message translates to:
  /// **'Новый проект'**
  String get newProject;

  /// No description provided for @name.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get name;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get description;

  /// No description provided for @color.
  ///
  /// In ru, this message translates to:
  /// **'Цвет'**
  String get color;

  /// No description provided for @add.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @emptyName.
  ///
  /// In ru, this message translates to:
  /// **'Название не может быть пустым'**
  String get emptyName;

  /// No description provided for @editBoard.
  ///
  /// In ru, this message translates to:
  /// **'Изменить проект'**
  String get editBoard;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
