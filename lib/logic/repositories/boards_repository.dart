import 'package:fpdart/fpdart.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/data_sources/remote/boards_data_source.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/logic/models/task_model.dart';

class BoardsRepository {
  final BoardsDataSource boardsDataSource;

  BoardsRepository({required this.boardsDataSource});

  Future<Either<Failure, List<BoardModel>>> selectUserBoards() async {
    try {
      final boards = await boardsDataSource.selectAllBoards();
      return right(boards);
    } catch (e) {
      return left(Failure(FailureType.other));
    }
  }

  Future<Either<Failure, BoardModel>> insertBoard(BoardModel board) async {
    try {
      final insertedBoard = await boardsDataSource.insertBoard(board);
      return right(insertedBoard);
    } catch (e) {
      return left(Failure(FailureType.userBoardsInsertError));
    }
  }

  Future<Either<Failure, void>> deleteBoard(int boardId) async {
    try {
      await boardsDataSource.deleteBoard(boardId);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.userBoardsDeleteError));
    }
  }

  Future<Either<Failure, List<ColumnModel>>> selectColumnsByBoardId(
    int boardId,
  ) async {
    try {
      final columns = await boardsDataSource.selectColumnsByBoardId(boardId);
      return right(columns);
    } catch (e) {
      return left(Failure(FailureType.columnsSelectError));
    }
  }

  Future<Either<Failure, void>> updateBoard(BoardModel board) async {
    try {
      await boardsDataSource.updateBoard(board);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.userBoardsUpdateError));
    }
  }

  Future<Either<Failure, void>> addDefaultColumns(
    List<ColumnModel> columns,
  ) async {
    try {
      await boardsDataSource.bulkInsertColumns(columns);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.columnInsertError));
    }
  }

  Future<Either<Failure, ColumnModel>> addColumn(ColumnModel column) async {
    try {
      final insertedColumn = await boardsDataSource.insertColumn(column);
      return right(insertedColumn);
    } catch (e) {
      return left(Failure(FailureType.columnInsertError));
    }
  }

  Future<Either<Failure, void>> updateColumn(ColumnModel column) async {
    try {
      await boardsDataSource.updateColumn(column);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.columnUpdateError));
    }
  }

  Future<Either<Failure, void>> deleteColumn(int columnId) async {
    try {
      await boardsDataSource.deleteColumn(columnId);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.columnDeleteError));
    }
  }

  Future<Either<Failure, List<TaskModel>>> selectTasksByColumnId(
    int columnId,
  ) async {
    try {
      final tasks = await boardsDataSource.selectTasksByColumnId(columnId);
      return right(tasks);
    } catch (e) {
      return left(Failure(FailureType.tasksSelectError));
    }
  }

  Future<Either<Failure, TaskModel>> addTask(TaskModel task) async {
    try {
      final insertedTask = await boardsDataSource.insertTask(task);
      return right(insertedTask);
    } catch (e) {
      return left(Failure(FailureType.taskInsertError));
    }
  }

  Future<Either<Failure, void>> deleteTask(int taskId) async {
    try {
      await boardsDataSource.deleteTask(taskId);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.taskDeleteError));
    }
  }

  Future<Either<Failure, void>> updateTask(TaskModel task) async {
    try {
      await boardsDataSource.updateTask(task);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.taskUpdateError));
    }
  }
}
