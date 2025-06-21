import 'package:fpdart/fpdart.dart';
import 'package:kanban_flutter/core/errors/exceptions.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/data_sources/remote/auth_data_source.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<Either<Failure, void>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await authDataSource.signInWithEmailAndPassword(email, password);
      return right(null);
    } on InvalidCredentialsException {
      return left(Failure(FailureType.invalidCredentials));
    } on Exception {
      return left(Failure(FailureType.other));
    }
  }

  Future<Either<Failure, void>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await authDataSource.signUpWithEmailAndPassword(email, password);
      return right(null);
    } on UserAlreadyExistsException {
      return left(Failure(FailureType.userAlredyExists));
    } on Exception {
      return left(Failure(FailureType.other));
    }
  }

  Future<void> signOut() async {
    await authDataSource.signOut();
  }
}
