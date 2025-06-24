import 'package:fpdart/fpdart.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/data_sources/remote/boards_data_source.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';

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

  Future<Either<Failure, void>> updateBoard(BoardModel board) async {
    try {
      await boardsDataSource.updateBoard(board);
      return right(null);
    } catch (e) {
      return left(Failure(FailureType.userBoardsUpdateError));
    }
  }
}
