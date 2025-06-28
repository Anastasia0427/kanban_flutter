part of 'board_bloc.dart';

sealed class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class BoardFetchColumns extends BoardEvent {
  final int boardId;

  const BoardFetchColumns({required this.boardId});

  @override
  List<Object> get props => [boardId];
}

class BoardAddColumn extends BoardEvent {
  final String name;
  final int boardId;
  final bool isEditable;
  final String color;

  const BoardAddColumn({
    required this.name,
    required this.boardId,
    required this.isEditable,
    required this.color,
  });

  @override
  List<Object> get props => [name, boardId, isEditable, color];
}

class BoardEditColumn extends BoardEvent {
  final String name;
  final String color;
  final int columnId;
  final int boardId;

  const BoardEditColumn({
    required this.name,
    required this.color,
    required this.columnId,
    required this.boardId,
  });

  @override
  List<Object> get props => [name, color, columnId];
}

class BoardDeleteColumn extends BoardEvent {
  final int columnId;

  const BoardDeleteColumn({required this.columnId});

  @override
  List<Object> get props => [columnId];
}
