part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditUsername extends ProfileEvent {
  final String username;

  const EditUsername({required this.username});

  @override
  List<Object?> get props => [username];
}

class EditEmail extends ProfileEvent {
  final String email;
  final BuildContext context;

  const EditEmail({required this.email, required this.context});

  @override
  List<Object?> get props => [email];
}

class EditPassword extends ProfileEvent {
  final String password;

  const EditPassword({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignOut extends ProfileEvent {}

class InputChanged extends ProfileEvent {}
