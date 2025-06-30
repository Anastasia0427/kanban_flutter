import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/logic/models/task_model.dart';
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
    on<BoardAddTask>(_onBoardAddTask);
    on<BoardUpdateTask>(_onBoardUpdateTask);
    on<BoardDeleteTask>(_onBoardDeleteTask);
    on<BoardDragTask>(_onBoardDragTask);
  }

  void _onBoardFetchColumns(
    BoardFetchColumns event,
    Emitter<BoardState> emit,
  ) async {
    emit(BoardLoading());

    final columnsResult = await boardsRepository.selectColumnsByBoardId(
      event.boardId,
    );

    if (columnsResult.isLeft()) {
      final failure = columnsResult.fold((f) => f, (_) => throw Exception());
      emit(BoardFailure(type: failure.type));
      return;
    }

    final columns = columnsResult.fold((_) => [], (columns) => columns);

    final List<ColumnModel> columnsWithTasks = await Future.wait(
      columns.map((column) async {
        final tasksResult = await boardsRepository.selectTasksByColumnId(
          column.columnId!,
        );
        return tasksResult.fold(
          (_) => column,
          (tasks) => column.copyWith(tasks: tasks),
        );
      }),
    );

    emit(BoardLoaded(columns: columnsWithTasks));
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

  void _onBoardAddTask(BoardAddTask event, Emitter<BoardState> emit) async {
    final currentState = state;
    if (currentState is! BoardLoaded) return;

    final targetColumn = currentState.columns.firstWhere(
      (c) => c.isEditable == false,
      orElse: () => currentState.columns.first,
    );

    final result = await boardsRepository.addTask(
      TaskModel(
        taskTitle: event.taskTitle,
        taskDescription: event.taskDescription,
        deadline: event.deadline,
        columnId: targetColumn.columnId!,
        creationDate: DateTime.now(),
      ),
    );
    result.fold((failure) {}, (success) {
      final updatedColumns = currentState.columns.map((col) {
        if (col.columnId == targetColumn.columnId) {
          return col.copyWith(tasks: [...col.tasks, success]);
        }
        return col;
      }).toList();

      emit(BoardLoaded(columns: updatedColumns));
    });
  }

  void _onBoardUpdateTask(
    BoardUpdateTask event,
    Emitter<BoardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BoardLoaded) return;

    ColumnModel? targetColumn;
    TaskModel? existingTask;

    for (final column in currentState.columns) {
      final task = column.tasks.firstWhere((t) => t.taskId == event.taskId);
      targetColumn = column;
      existingTask = task;
      break;
    }

    if (existingTask == null || targetColumn == null) return;

    final updatedTask = existingTask.copyWith(
      taskTitle: event.taskTitle,
      taskDescription: event.taskDescription,
      deadline: event.deadline,
      creationDate: event.creationDate,
      resetDeadline: event.resetDeadline,
    );

    final result = await boardsRepository.updateTask(updatedTask);

    result.fold(
      (failure) {
        emit(BoardFailure(type: failure.type));
      },
      (success) {
        final updatedColumns = currentState.columns.map((col) {
          if (col.columnId == targetColumn!.columnId) {
            final updatedTasks = col.tasks.map((task) {
              return task.taskId == updatedTask.taskId ? updatedTask : task;
            }).toList();
            return col.copyWith(tasks: updatedTasks);
          }
          return col;
        }).toList();

        emit(BoardLoaded(columns: updatedColumns));
      },
    );
  }

  void _onBoardDeleteTask(
    BoardDeleteTask event,
    Emitter<BoardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! BoardLoaded) return;

    ColumnModel? targetColumn;
    TaskModel? existingTask;

    for (final column in currentState.columns) {
      final task = column.tasks.firstWhere((t) => t.taskId == event.taskId);
      targetColumn = column;
      existingTask = task;
      break;
    }

    if (existingTask == null || targetColumn == null) return;

    final result = await boardsRepository.deleteTask(event.taskId);

    result.fold(
      (failure) {
        emit(BoardFailure(type: failure.type));
      },
      (success) {
        final updatedColumns = currentState.columns.map((col) {
          if (col.columnId == targetColumn!.columnId) {
            final updatedTasks = col.tasks.where((task) {
              return task.taskId != event.taskId;
            }).toList();
            return col.copyWith(tasks: updatedTasks);
          }
          return col;
        }).toList();

        emit(BoardLoaded(columns: updatedColumns));
      },
    );
  }

  void _onBoardDragTask(BoardDragTask event, Emitter<BoardState> emit) async {
    final currentState = state;
    if (currentState is! BoardLoaded) return;

    ColumnModel? oldColumn;
    TaskModel? existingTask;

    for (final column in currentState.columns) {
      try {
        final task = column.tasks.firstWhere(
          (t) => t.taskId == event.task.taskId,
        );
        oldColumn = column;
        existingTask = task;
        break;
      } catch (_) {
        continue;
      }
    }

    if (existingTask == null || oldColumn == null) return;

    final newTask = existingTask.copyWith(columnId: event.newColumnId);

    final result = await boardsRepository.updateTaskColumn(newTask);

    result.fold(
      (failure) {
        emit(BoardFailure(type: failure.type));
      },
      (_) {
        final updatedColumns = currentState.columns.map((column) {
          if (column.columnId == oldColumn!.columnId) {
            final updatedTasks = column.tasks
                .where((task) => task.taskId != newTask.taskId)
                .toList();
            return column.copyWith(tasks: updatedTasks);
          } else if (column.columnId == event.newColumnId) {
            return column.copyWith(tasks: [...column.tasks, newTask]);
          } else {
            return column;
          }
        }).toList();

        emit(BoardLoaded(columns: updatedColumns));
      },
    );
  }
}
