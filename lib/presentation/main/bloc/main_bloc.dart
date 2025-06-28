import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/common/global_state/user_boards/user_boards_cubit.dart';
import 'package:kanban_flutter/core/common/navigation/router.dart';
import 'package:kanban_flutter/core/common/navigation/routes.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/logic/repositories/boards_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final BoardsRepository boardsRepository;

  final UserBoardsCubit userBoardsCubit;

  late final StreamSubscription _userBoardsSubscription;

  MainBloc({required this.boardsRepository, required this.userBoardsCubit})
    : super(MainInitial()) {
    on<MainFetchUserBoards>(_onFetchUserBoards);
    on<CheckMainState>(_onCheckMainState);
    on<AddNewBoard>(_onAddNewBoard);
    on<DeleteBoard>(_onDeleteBoard);
    on<UpdateBoard>(_onUpdateBoard);
    on<GoToBoardPage>(_onGoToBoardPage);

    add(MainFetchUserBoards());

    _userBoardsSubscription = userBoardsCubit.stream.listen((_) {
      add(CheckMainState());
    });
  }

  void _onFetchUserBoards(
    MainFetchUserBoards event,
    Emitter<MainState> emit,
  ) async {
    userBoardsCubit.fetchUserBoards();
  }

  void _onCheckMainState(CheckMainState event, Emitter<MainState> emit) {
    if (userBoardsCubit.state is UserBoardsLoading) {
      emit(MainLoading());
      return;
    }
    if (userBoardsCubit.state is UserBoardsFailure) {
      emit(MainFailure(type: FailureType.userBoardsFetchError));
      return;
    }
    if (userBoardsCubit.state is UserBoardsLoaded) {
      emit(MainLoaded());
      return;
    }
  }

  void _onAddNewBoard(AddNewBoard event, Emitter<MainState> emit) async {
    final board = BoardModel(
      name: event.name,
      description: event.description,
      userId: Supabase.instance.client.auth.currentUser!.id,
      color: event.color,
      creationDate: DateTime.now(),
      editDate: DateTime.now(),
    );

    final result = await boardsRepository.insertBoard(board);
    result.fold((failure) {}, (success) async {
      final defaultColumns = [
        ColumnModel(
          columnName: event.defaultToDo,
          boardId: success.boardId!,
          color: Utils.colorToStringWithAlpha(event.defaultToDoColor),
          isEditable: false,
        ),
        ColumnModel(
          columnName: event.defaultInProgress,
          boardId: success.boardId!,
          color: Utils.colorToStringWithAlpha(event.defaultInProgressColor),
          isEditable: false,
        ),
        ColumnModel(
          columnName: event.defaultDone,
          boardId: success.boardId!,
          color: Utils.colorToStringWithAlpha(event.defaultDoneColor),
          isEditable: false,
        ),
      ];

      final columnsResult = await boardsRepository.addDefaultColumns(
        defaultColumns,
      );
      columnsResult.fold((failure) {}, (_) {
        userBoardsCubit.addNewBoard(success);
      });
    });
    emit(MainLoaded());
  }

  void _onDeleteBoard(DeleteBoard event, Emitter<MainState> emit) async {
    final result = await boardsRepository.deleteBoard(event.boardId);
    result.fold((failure) {}, (success) {
      userBoardsCubit.deleteBoard(event.boardId);
    });

    emit(MainLoaded());
  }

  void _onUpdateBoard(UpdateBoard event, Emitter<MainState> emit) async {
    final board = BoardModel(
      name: event.name,
      description: event.description,
      userId: Supabase.instance.client.auth.currentUser!.id,
      color: event.color,
      boardId: event.boardId,
      creationDate: event.creationDate,
      editDate: DateTime.now(),
    );
    final result = await boardsRepository.updateBoard(board);
    result.fold((failure) {}, (success) {
      userBoardsCubit.updateBoard(board);
    });

    emit(MainLoaded());
  }

  void _onGoToBoardPage(GoToBoardPage event, Emitter<MainState> emit) {
    router.pushNamed(Routes.boardPage, extra: event.board);
  }

  @override
  Future<void> close() {
    _userBoardsSubscription.cancel();
    return super.close();
  }
}
