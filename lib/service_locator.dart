import 'package:get_it/get_it.dart';
import 'package:kanban_flutter/core/common/global_state/session/session_cubit.dart';
import 'package:kanban_flutter/core/common/global_state/user_boards/user_boards_cubit.dart';
import 'package:kanban_flutter/core/constants/secret_constants.dart';
import 'package:kanban_flutter/logic/data_sources/remote/auth_data_source.dart';
import 'package:kanban_flutter/logic/data_sources/remote/boards_data_source.dart';
import 'package:kanban_flutter/logic/data_sources/remote/user_data_source.dart';
import 'package:kanban_flutter/logic/repositories/auth_repository.dart';
import 'package:kanban_flutter/logic/repositories/boards_repository.dart';
import 'package:kanban_flutter/logic/repositories/user_repository.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:kanban_flutter/presentation/main/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Supabase.initialize(
    url: SecretConstants.projectUrl,
    anonKey: SecretConstants.apiKey,
  );

  serviceLocator.registerSingleton<SessionCubit>(SessionCubit());

  serviceLocator.registerFactory(() => AuthDataSource());
  serviceLocator.registerFactory(
    () => AuthRepository(authDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(() => BoardsDataSource());
  serviceLocator.registerFactory(() => UserDataSource());
  serviceLocator.registerFactory(
    () => BoardsRepository(boardsDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserRepository(userDataSource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UserBoardsCubit>(
    () => UserBoardsCubit(boardsRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => MainBloc(
      boardsRepository: serviceLocator(),
      userBoardsCubit: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ProfileBloc(
      userRepository: serviceLocator(),
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => BoardBloc(boardsRepository: serviceLocator()),
  );
}
