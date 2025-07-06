part of 'user_boards_cubit.dart';

@immutable
sealed class UserBoardsState extends Equatable {
  const UserBoardsState();

  @override
  List<Object?> get props => [];
}

final class UserBoardsInitial extends UserBoardsState {}

final class UserBoardsLoading extends UserBoardsState {}

final class UserBoardsLoaded extends UserBoardsState {
  final List<BoardModel> boards;

  const UserBoardsLoaded({required this.boards});

  @override
  List<Object?> get props => [boards];
}

final class UserBoardsFailure extends UserBoardsState {
  final FailureType type;

  const UserBoardsFailure({required this.type});
}
