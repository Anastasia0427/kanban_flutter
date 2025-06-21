// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Русский';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get withThis => 'С ';

  @override
  String get appName => 'kanban master';

  @override
  String get youCan => ' ты сможешь эффективно управлять своими проектами';

  @override
  String get firstTime => 'Впервые у нас?';

  @override
  String get signUpButton => 'Регистрация';

  @override
  String get signIn => 'Вход в аккаунт';

  @override
  String get signInButton => 'Войти';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get signUp => 'Регистрация';

  @override
  String get userNameHint => 'Имя пользователя';

  @override
  String get createAccountButton => 'Создать аккаунт';

  @override
  String get haveAccount => 'Уже есть аккаунт?';

  @override
  String get returnToSignIn => 'Вернись к отслеживанию задач\nв ';

  @override
  String get alreadyExists => 'Пользователь с таким email уже существует';

  @override
  String get tooShortPassword => 'Пароль должен быть не менее 8 символов';

  @override
  String get invalidEmail => 'Неверный формат email';

  @override
  String get emptyEmail => 'Email не может быть пустым';

  @override
  String get emptyPassword => 'Пароль не может быть пустым';

  @override
  String get invalidCredentials => 'Неверный email или пароль';
}
