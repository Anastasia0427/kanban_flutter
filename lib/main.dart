import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/core/common/global_state/user_boards/user_boards_cubit.dart';
import 'package:kanban_flutter/core/theme/app_theme.dart';
import 'package:kanban_flutter/l10n/app_localizations.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:kanban_flutter/presentation/main/bloc/profile_bloc.dart';
import 'package:kanban_flutter/service_locator.dart';
import 'package:kanban_flutter/core/common/navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserBoardsCubit>()),
        BlocProvider(create: (_) => serviceLocator<MainBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
