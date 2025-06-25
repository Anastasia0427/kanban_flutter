import 'package:kanban_flutter/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<UserResponse> updateUser(UserAttributes attributes) async {
    try {
      final result = await _supabaseClient.auth.updateUser(attributes);
      return result;
    } on AuthApiException catch (e) {
      if (e.code == 'user_already_exists') {
        throw UserAlreadyExistsException();
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
