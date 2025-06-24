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

  const AddNewBoard({
    required this.name,
    required this.description,
    required this.color,
  });

  @override
  List<Object?> get props => [name, description, color];
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

  const UpdateBoard({
    required this.name,
    required this.description,
    required this.color,
    required this.boardId,
  });

  @override
  List<Object?> get props => [name, description, color, boardId];
}
