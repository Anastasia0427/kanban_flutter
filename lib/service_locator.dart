import 'package:get_it/get_it.dart';
import 'package:kanban_flutter/core/constants/secret_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Supabase.initialize(
    url: SecretConstants.projectUrl,
    anonKey: SecretConstants.apiKey,
  );
  serviceLocator.registerSingleton<SupabaseClient>(Supabase.instance.client);
}
