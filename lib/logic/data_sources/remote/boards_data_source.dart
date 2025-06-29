import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/logic/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardsDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<BoardModel>> selectAllBoards() async {
    try {
      final result = await _supabaseClient
          .from('boards')
          .select()
          .eq('user_id', _supabaseClient.auth.currentUser!.id);
      return result.map((e) => BoardModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<BoardModel> insertBoard(BoardModel board) async {
    try {
      final result = await _supabaseClient
          .from('boards')
          .insert(board.toJson())
          .select();
      return result.map((e) => BoardModel.fromJson(e)).toList().first;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteBoard(int boardId) async {
    try {
      await _supabaseClient.from('boards').delete().eq('board_id', boardId);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateBoard(BoardModel board) async {
    try {
      await _supabaseClient
          .from('boards')
          .update({
            'name': board.name,
            'description': board.description,
            'color': board.color,
          })
          .eq('board_id', board.boardId!);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ColumnModel>> selectColumnsByBoardId(int boardId) async {
    try {
      final result = await _supabaseClient
          .from('columns')
          .select()
          .eq('board_id', boardId);
      return result.map((e) => ColumnModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ColumnModel> insertColumn(ColumnModel column) async {
    try {
      final result = await _supabaseClient
          .from('columns')
          .insert(column.toJson())
          .select();
      return result.map((e) => ColumnModel.fromJson(e)).toList().first;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> bulkInsertColumns(List<ColumnModel> columns) async {
    try {
      await _supabaseClient
          .from('columns')
          .insert(columns.map((e) => e.toJson()).toList());
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteColumn(int columnId) async {
    try {
      await _supabaseClient.from('columns').delete().eq('column_id', columnId);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateColumn(ColumnModel column) async {
    try {
      await _supabaseClient
          .from('columns')
          .update({'column_name': column.columnName, 'color': column.color})
          .eq('column_id', column.columnId!);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TaskModel>> selectTasksByColumnId(int columnId) async {
    try {
      final result = await _supabaseClient
          .from('tasks')
          .select()
          .eq('column_id', columnId);
      return result.map((e) => TaskModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TaskModel> insertTask(TaskModel task) async {
    try {
      final result = await _supabaseClient
          .from('tasks')
          .insert(task.toJson())
          .select();
      return result.map((e) => TaskModel.fromJson(e)).toList().first;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await _supabaseClient.from('tasks').delete().eq('task_id', taskId);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _supabaseClient
          .from('tasks')
          .update({
            'task_title': task.taskTitle,
            'task_description': task.taskDescription,
            'deadline': task.deadline != null
                ? Utils.dateDBFormat.format(task.deadline!)
                : null,
          })
          .eq('task_id', task.taskId!);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
