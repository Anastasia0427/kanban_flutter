import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/repositories/auth_repository.dart';
import 'package:kanban_flutter/logic/repositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  ProfileBloc({required this.userRepository, required this.authRepository})
    : super(ProfileInitial()) {
    on<EditUsername>(_onEditUsername);
    on<EditEmail>(_onEditEmail);
    on<EditPassword>(_onEditPassword);
    on<SignOut>(_onSignOut);
    on<InputChanged>(_onInputChanged);
  }

  void _onEditUsername(EditUsername event, Emitter<ProfileState> emit) async {
    emit(ProfileSaving());
    final result = await userRepository.updateUserUsername(event.username);
    result.fold(
      (failure) => emit(ProfileFailure(type: FailureType.usernameUpdateError)),
      (success) => emit(ProfileSaved()),
    );
  }

  void _onEditEmail(EditEmail event, Emitter<ProfileState> emit) async {
    emit(ProfileSaving());

    String? emailError;
    if (event.email.isEmpty) {
      emailError = event.context.l10n.emptyEmail;
    } else if (!Utils.isValidEmail(event.email)) {
      emailError = event.context.l10n.invalidEmail;
    }

    if (emailError != null) {
      emit(ProfileValidationFailure(emailError: emailError));
      return;
    }

    final result = await userRepository.updateUserEmail(event.email);
    result.fold(
      (failure) => emit(ProfileFailure(type: FailureType.userEmailUpdateError)),
      (success) => emit(ProfileSaved()),
    );
  }

  void _onEditPassword(EditPassword event, Emitter<ProfileState> emit) async {
    emit(ProfileSaving());
    final result = await userRepository.updateUserPassword(event.password);
    result.fold(
      (failure) =>
          emit(ProfileFailure(type: FailureType.userPasswordUpdateError)),
      (success) => emit(ProfileSaved()),
    );
  }

  void _onSignOut(SignOut event, Emitter<ProfileState> emit) async {
    await authRepository.signOut();
    emit(ProfileInitial());
  }

  void _onInputChanged(InputChanged event, Emitter<ProfileState> emit) {
    if (state is ProfileValidationFailure || state is ProfileFailure) {
      emit(ProfileInitial());
    }
  }
}
