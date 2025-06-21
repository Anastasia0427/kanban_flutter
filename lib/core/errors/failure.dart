class Failure {
  final FailureType type;

  Failure(this.type);
}

enum FailureType { userAlredyExists, invalidCredentials, other }
