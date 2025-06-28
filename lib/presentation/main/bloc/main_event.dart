part of 'main_bloc.dart';

@immutable
sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class MainFetchUserBoards extends MainEvent {}

class CheckMainState extends MainEvent {}

class AddNewBoard extends MainEvent {
  final String name;
  final String description;
  final String color;
  final String defaultToDo;
  final String defaultInProgress;
  final String defaultDone;
  final Color defaultToDoColor;
  final Color defaultInProgressColor;
  final Color defaultDoneColor;

  const AddNewBoard({
    required this.name,
    required this.description,
    required this.color,
    required this.defaultToDo,
    required this.defaultInProgress,
    required this.defaultDone,
    required this.defaultToDoColor,
    required this.defaultInProgressColor,
    required this.defaultDoneColor,
  });

  @override
  List<Object?> get props => [
    name,
    description,
    color,
    defaultToDo,
    defaultInProgress,
    defaultDone,
    defaultToDoColor,
    defaultInProgressColor,
    defaultDoneColor,
  ];
}

class DeleteBoard extends MainEvent {
  final int boardId;

  const DeleteBoard({required this.boardId});

  @override
  List<Object?> get props => [boardId];
}

class UpdateBoard extends MainEvent {
  final String name;
  final String description;
  final String color;
  final int boardId;
  final DateTime creationDate;

  const UpdateBoard({
    required this.name,
    required this.description,
    required this.color,
    required this.boardId,
    required this.creationDate,
  });

  @override
  List<Object?> get props => [name, description, color, boardId, creationDate];
}

class GoToBoardPage extends MainEvent {
  final BoardModel board;

  const GoToBoardPage({required this.board});

  @override
  List<Object?> get props => [board];
}
