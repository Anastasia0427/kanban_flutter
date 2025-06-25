import 'package:fpdart/fpdart.dart';
import 'package:kanban_flutter/core/errors/exceptions.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/data_sources/remote/user_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<Either<Failure, UserResponse>> updateUserEmail(String email) async {
    try {
      final user = await userDataSource.updateUser(
        UserAttributes(email: email),
      );
      return right(user);
    } on UserAlreadyExistsException {
      return left(Failure(FailureType.userEmailUpdateError));
    } on Exception {
      return left(Failure(FailureType.other));
    }
  }

  Future<Either<Failure, UserResponse>> updateUserPassword(
    String password,
  ) async {
    try {
      final user = await userDataSource.updateUser(
        UserAttributes(password: password),
      );
      return right(user);
    } catch (e) {
      return left(Failure(FailureType.userPasswordUpdateError));
    }
  }

  Future<Either<Failure, UserResponse>> updateUserUsername(
    String username,
  ) async {
    try {
      final user = await userDataSource.updateUser(
        UserAttributes(data: {'username': username}),
      );
      return right(user);
    } catch (e) {
      return left(Failure(FailureType.usernameUpdateError));
    }
  }
}
