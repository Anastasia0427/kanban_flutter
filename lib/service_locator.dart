import 'package:get_it/get_it.dart';
import 'package:kanban_flutter/core/constants/secret_constants.dart';
import 'package:kanban_flutter/logic/data_sources/remote/auth_data_source.dart';
import 'package:kanban_flutter/logic/repositories/auth_repository.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Supabase.initialize(
    url: SecretConstants.projectUrl,
    anonKey: SecretConstants.apiKey,
  );

  serviceLocator.registerFactory(() => AuthDataSource());
  serviceLocator.registerFactory(
    () => AuthRepository(authDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: serviceLocator()),
  );
}
