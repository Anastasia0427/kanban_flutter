class Failure {
  final FailureType type;

  Failure(this.type);
}

enum FailureType {
  userAlredyExists,
  invalidCredentials,
  other,
  userBoardsFetchError,
  userBoardsInsertError,
  userBoardsDeleteError,
  userBoardsUpdateError,
  userEmailUpdateError,
  userPasswordUpdateError,
  usernameUpdateError,
  columnsSelectError,
  columnInsertError,
  columnDeleteError,
  columnUpdateError,
  tasksSelectError,
  taskInsertError,
  taskDeleteError,
  taskUpdateError,
}
