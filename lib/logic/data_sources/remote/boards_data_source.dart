import 'package:kanban_flutter/logic/models/board_model.dart';
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
}
