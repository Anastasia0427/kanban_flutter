part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthFailure extends AuthState {
  final FailureType type;

  AuthFailure({required this.type});
}

final class AuthValidationFailure extends AuthState {
  final String? emailError;
  final String? passwordError;

  AuthValidationFailure({
    required this.emailError,
    required this.passwordError,
  });
}
