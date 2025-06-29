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

class BoardAddTask extends BoardEvent {
  final String taskTitle;
  final String taskDescription;
  final DateTime? deadline;

  const BoardAddTask({
    required this.taskTitle,
    required this.taskDescription,
    required this.deadline,
  });

  @override
  List<Object> get props => [taskTitle, taskDescription];
}

class BoardUpdateTask extends BoardEvent {
  final String taskTitle;
  final String taskDescription;
  final DateTime? deadline;
  final int taskId;
  final DateTime creationDate;

  const BoardUpdateTask({
    required this.taskTitle,
    required this.taskDescription,
    required this.deadline,
    required this.taskId,
    required this.creationDate,
  });

  @override
  List<Object> get props => [taskTitle, taskDescription, taskId];
}

class BoardDeleteTask extends BoardEvent {
  final int taskId;

  const BoardDeleteTask({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
