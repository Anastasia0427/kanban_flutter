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
  String get youCan =>
      'С kanban master ты сможешь эффективно управлять своими проектами';

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
}
