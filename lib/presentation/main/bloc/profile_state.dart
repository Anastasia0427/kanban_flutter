part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSaving extends ProfileState {}

final class ProfileSaved extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final FailureType type;

  const ProfileFailure({required this.type});
}

final class ProfileValidationFailure extends ProfileState {
  final String? emailError;

  const ProfileValidationFailure({this.emailError});
}
