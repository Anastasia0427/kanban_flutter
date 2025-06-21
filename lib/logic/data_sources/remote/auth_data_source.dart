import 'package:kanban_flutter/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return result;
    } on AuthApiException catch (e) {
      if (e.code == 'invalid_credentials') {
        throw InvalidCredentialsException();
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
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

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
