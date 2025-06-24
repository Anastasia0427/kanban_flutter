import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/logic/repositories/boards_repository.dart';
import 'package:meta/meta.dart';

part 'user_boards_state.dart';

class UserBoardsCubit extends Cubit<UserBoardsState> {
  final BoardsRepository boardsRepository;

  UserBoardsCubit({required this.boardsRepository})
    : super(UserBoardsInitial());

  Future<void> fetchUserBoards() async {
    emit(UserBoardsLoading());

    final result = await boardsRepository.selectUserBoards();

    result.fold(
      (failure) =>
          emit(UserBoardsFailure(type: FailureType.userBoardsFetchError)),
      (success) => emit(UserBoardsLoaded(boards: success)),
    );
  }

  void addNewBoard(BoardModel board) {
    if (state is! UserBoardsLoaded) return;
    final current = (state as UserBoardsLoaded).boards;
    emit(UserBoardsLoaded(boards: [board, ...current]));
  }

  void deleteBoard(int boardId) {
    if (state is! UserBoardsLoaded) return;
    final current = (state as UserBoardsLoaded).boards;
    final newBoards = current.where((e) => e.boardId != boardId).toList();
    emit(UserBoardsLoaded(boards: newBoards));
  }

  void updateBoard(BoardModel board) {
    if (state is! UserBoardsLoaded) return;
    final current = (state as UserBoardsLoaded).boards;
    final updatedList = current
        .where((e) => e.boardId != board.boardId)
        .toList();
    updatedList.insert(0, board);

    emit(UserBoardsLoaded(boards: updatedList));
  }
}
