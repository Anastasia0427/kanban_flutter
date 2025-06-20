import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/common/navigation/router.dart';
import 'package:kanban_flutter/core/common/navigation/routes.dart';
import 'package:kanban_flutter/logic/data_sources/remote/auth_data_source.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataSource _authDataSource;

  AuthBloc({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource,
      super(AuthInitial()) {
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<GoToSignUpPage>(_onGoToSignUpPage);
    on<GoToSignInPage>(_onGoToSignInPage);
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    try {
      await _authDataSource.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
    } catch (e) {
      emit(AuthFailure(error: e));
    }
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    try {
      await _authDataSource.signUpWithEmailAndPassword(
        event.email,
        event.password,
      );
    } catch (e) {
      emit(AuthFailure(error: e));
    }
  }

  void _onGoToSignUpPage(GoToSignUpPage event, Emitter<AuthState> emit) {
    router.replace(Routes.signUpPage);
  }

  void _onGoToSignInPage(GoToSignInPage event, Emitter<AuthState> emit) {
    router.replace(Routes.signInPage);
  }
}
