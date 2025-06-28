import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/logic/repositories/boards_repository.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardsRepository boardsRepository;

  BoardBloc({required this.boardsRepository}) : super(BoardInitial()) {
    on<BoardFetchColumns>(_onBoardFetchColumns);
    on<BoardAddColumn>(_onBoardAddColumn);
    on<BoardEditColumn>(_onBoardEditColumn);
    on<BoardDeleteColumn>(_onBoardDeleteColumn);
  }

  void _onBoardFetchColumns(
    BoardFetchColumns event,
    Emitter<BoardState> emit,
  ) async {
    emit(BoardLoading());
    final result = await boardsRepository.selectColumnsByBoardId(event.boardId);
    result.fold(
      (failure) {
        emit(BoardFailure(type: failure.type));
      },
      (columns) {
        emit(BoardLoaded(columns: columns));
      },
    );
  }

  void _onBoardAddColumn(BoardAddColumn event, Emitter<BoardState> emit) async {
    final result = await boardsRepository.addColumn(
      ColumnModel(
        columnName: event.name,
        boardId: event.boardId,
        color: event.color,
        isEditable: event.isEditable,
      ),
    );
    result.fold(
      (failure) {
        emit(BoardFailure(type: failure.type));
      },
      (success) {
        final current = (state as BoardLoaded).columns;
        emit(BoardLoaded(columns: [...current, success]));
      },
    );
  }

  void _onBoardEditColumn(
    BoardEditColumn event,
    Emitter<BoardState> emit,
  ) async {
    final column = ColumnModel(
      columnName: event.name,
      columnId: event.columnId,
      color: event.color,
      boardId: event.boardId,
      isEditable: true,
    );
    final result = await boardsRepository.updateColumn(column);
    result.fold((failure) {}, (success) {
      final current = (state as BoardLoaded).columns;
      final oldIndex = current.indexWhere((e) => e.columnId == event.columnId);
      if (oldIndex == -1) return;
      final updatedList = List<ColumnModel>.from(current)..removeAt(oldIndex);
      updatedList.insert(oldIndex, column);

      emit(BoardLoaded(columns: updatedList));
    });
  }

  void _onBoardDeleteColumn(
    BoardDeleteColumn event,
    Emitter<BoardState> emit,
  ) async {
    final result = await boardsRepository.deleteColumn(event.columnId);
    result.fold((failure) {}, (success) {
      final current = (state as BoardLoaded).columns;
      final updatedList = current
          .where((e) => e.columnId != event.columnId)
          .toList();

      emit(BoardLoaded(columns: updatedList));
    });
  }
}
