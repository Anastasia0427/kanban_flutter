part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class MainLoading extends MainState {}

final class MainLoaded extends MainState {}

final class MainFailure extends MainState {
  final FailureType type;

  MainFailure({required this.type});
}
