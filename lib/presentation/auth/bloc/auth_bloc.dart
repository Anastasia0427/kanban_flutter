import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/common/navigation/router.dart';
import 'package:kanban_flutter/core/common/navigation/routes.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<GoToSignUpPage>(_onGoToSignUpPage);
    on<GoToSignInPage>(_onGoToSignInPage);
    on<InputChanged>(_onInputChanged);
    on<GoToResetPassword>(_onGoToResetPassword);
    on<ResetPassword>(_onResetPassword);
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    String? emailError;
    String? passwordError;

    if (event.email.isEmpty) {
      emailError = event.context.l10n.emptyEmail;
    } else if (!Utils.isValidEmail(event.email)) {
      emailError = event.context.l10n.invalidEmail;
    }

    if (event.password.isEmpty) {
      passwordError = event.context.l10n.emptyPassword;
    } else if (!Utils.isValidPassword(event.password)) {
      passwordError = event.context.l10n.tooShortPassword;
    }

    if (emailError != null || passwordError != null) {
      emit(
        AuthValidationFailure(
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    final result = await _authRepository.signInWithEmailAndPassword(
      event.email,
      event.password,
    );
    result.fold((failure) => emit(AuthFailure(type: failure.type)), (success) {
      emit(AuthSuccess());
      router.replace(Routes.mainPage);
    });
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    String? emailError;
    String? passwordError;

    if (event.email.isEmpty) {
      emailError = event.context.l10n.emptyEmail;
    } else if (!Utils.isValidEmail(event.email)) {
      emailError = event.context.l10n.invalidEmail;
    }

    if (event.password.isEmpty) {
      passwordError = event.context.l10n.emptyPassword;
    } else if (!Utils.isValidPassword(event.password)) {
      passwordError = event.context.l10n.tooShortPassword;
    }

    if (emailError != null || passwordError != null) {
      emit(
        AuthValidationFailure(
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    final result = await _authRepository.signUpWithEmailAndPassword(
      event.email,
      event.password,
      event.username,
    );
    result.fold((failure) => emit(AuthFailure(type: failure.type)), (success) {
      emit(AuthSuccess());
      router.replace(Routes.mainPage);
    });
  }

  void _onGoToSignUpPage(GoToSignUpPage event, Emitter<AuthState> emit) {
    router.replace(Routes.signUpPage);
  }

  void _onGoToSignInPage(GoToSignInPage event, Emitter<AuthState> emit) {
    router.replace(Routes.signInPage);
  }

  void _onInputChanged(InputChanged event, Emitter<AuthState> emit) {
    if (state is AuthValidationFailure || state is AuthFailure) {
      emit(AuthInitial());
    }
  }

  void _onGoToResetPassword(GoToResetPassword event, Emitter<AuthState> emit) {
    router.replace(Routes.forgotPasswordPage);
  }

  void _onResetPassword(ResetPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    String? emailError;

    if (event.email.isEmpty) {
      emailError = event.context.l10n.emptyEmail;
    } else if (!Utils.isValidEmail(event.email)) {
      emailError = event.context.l10n.invalidEmail;
    }

    if (emailError != null) {
      emit(AuthValidationFailure(emailError: emailError, passwordError: null));
      return;
    }

    final result = await _authRepository.resetPasswordWithEmail(event.email);
    result.fold((failure) => emit(AuthFailure(type: failure.type)), (success) {
      emit(AuthSuccess());
      router.replace(Routes.signInPage);
    });
  }
}
