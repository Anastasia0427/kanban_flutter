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

  /// No description provided for @resetPasswordButton.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить пароль'**
  String get resetPasswordButton;

  /// No description provided for @exitFromSystem.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из системы'**
  String get exitFromSystem;

  /// No description provided for @usernameUpdateError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при обновлении имени пользователя'**
  String get usernameUpdateError;

  /// No description provided for @emailUpdateError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при обновлении email'**
  String get emailUpdateError;

  /// No description provided for @passwordUpdateError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при обновлении пароля'**
  String get passwordUpdateError;

  /// No description provided for @unknownError.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная ошибка'**
  String get unknownError;

  /// No description provided for @enterNewPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите новый пароль'**
  String get enterNewPassword;

  /// No description provided for @change.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get change;

  /// No description provided for @areYouSure.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены?'**
  String get areYouSure;

  /// No description provided for @exit.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get exit;

  /// No description provided for @defaultToDo.
  ///
  /// In ru, this message translates to:
  /// **'Нужно сделать'**
  String get defaultToDo;

  /// No description provided for @defaultInProgress.
  ///
  /// In ru, this message translates to:
  /// **'В процессе'**
  String get defaultInProgress;

  /// No description provided for @defaultDone.
  ///
  /// In ru, this message translates to:
  /// **'Готово'**
  String get defaultDone;

  /// No description provided for @addTask.
  ///
  /// In ru, this message translates to:
  /// **'Добавить задачу'**
  String get addTask;

  /// No description provided for @addColumn.
  ///
  /// In ru, this message translates to:
  /// **'Добавить колонку'**
  String get addColumn;

  /// No description provided for @newColumn.
  ///
  /// In ru, this message translates to:
  /// **'Новая колонка'**
  String get newColumn;

  /// No description provided for @editColumn.
  ///
  /// In ru, this message translates to:
  /// **'Изменить колонку'**
  String get editColumn;

  /// No description provided for @created.
  ///
  /// In ru, this message translates to:
  /// **'Создано'**
  String get created;

  /// No description provided for @edited.
  ///
  /// In ru, this message translates to:
  /// **'Изменено'**
  String get edited;

  /// No description provided for @newTask.
  ///
  /// In ru, this message translates to:
  /// **'Новая задача'**
  String get newTask;

  /// No description provided for @deadline.
  ///
  /// In ru, this message translates to:
  /// **'Дедлайн'**
  String get deadline;

  /// No description provided for @pickDate.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать дату'**
  String get pickDate;

  /// No description provided for @close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get close;

  /// No description provided for @noDeadline.
  ///
  /// In ru, this message translates to:
  /// **'Без дедлайна'**
  String get noDeadline;

  /// No description provided for @removeDeadline.
  ///
  /// In ru, this message translates to:
  /// **'Убрать дедлайн'**
  String get removeDeadline;

  /// No description provided for @forgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// No description provided for @iRemembered.
  ///
  /// In ru, this message translates to:
  /// **'Я вспомнил'**
  String get iRemembered;

  /// No description provided for @resetPassword.
  ///
  /// In ru, this message translates to:
  /// **'Восстановление пароля'**
  String get resetPassword;

  /// No description provided for @resetPasswordMessage.
  ///
  /// In ru, this message translates to:
  /// **'Введите email для восстановления пароля'**
  String get resetPasswordMessage;

  /// No description provided for @emptyUsername.
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя не может быть пустым'**
  String get emptyUsername;
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
