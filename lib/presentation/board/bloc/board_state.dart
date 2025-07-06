part of 'board_bloc.dart';

sealed class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

final class BoardInitial extends BoardState {}

final class BoardLoading extends BoardState {}

final class BoardLoaded extends BoardState {
  final List<ColumnModel> columns;

  const BoardLoaded({required this.columns});

  @override
  List<Object> get props => [columns];
}

final class BoardFailure extends BoardState {
  final FailureType type;

  const BoardFailure({required this.type});

  @override
  List<Object> get props => [type];
}
