part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignIn extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignIn({required this.email, required this.password, required this.context});
}

class SignUp extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final BuildContext context;

  SignUp({
    required this.email,
    required this.password,
    required this.username,
    required this.context,
  });
}

class GoToSignUpPage extends AuthEvent {}

class GoToSignInPage extends AuthEvent {}

class InputChanged extends AuthEvent {}

class GoToResetPassword extends AuthEvent {}

class ResetPassword extends AuthEvent {
  final String email;
  final BuildContext context;

  ResetPassword({required this.email, required this.context});
}
