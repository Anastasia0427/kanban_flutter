part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthFailure extends AuthState {
  final Object error;

  AuthFailure({required this.error});
}
