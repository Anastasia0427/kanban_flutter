import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/core/common/global_state/session/session_cubit.dart';
import 'package:kanban_flutter/core/common/navigation/routes.dart';
import 'package:kanban_flutter/presentation/auth/pages/sign_in_page.dart';
import 'package:kanban_flutter/presentation/auth/pages/sign_up_page.dart';
import 'package:kanban_flutter/presentation/loading/loading_page.dart';
import 'package:kanban_flutter/presentation/main/pages/main_page.dart';
import 'package:kanban_flutter/service_locator.dart';

final sessionCubit = serviceLocator<SessionCubit>();
bool _initalRedirectDone = false;

final router = GoRouter(
  refreshListenable: sessionCubit,
  redirect: (context, state) {
    final sessionState = context.read<SessionCubit>().state;
    print(sessionState.status.toString());
    if (!_initalRedirectDone) {
      _initalRedirectDone = true;
      switch (sessionState.status) {
        case SessionStatus.authenticated:
          return Routes.mainPage;
        case SessionStatus.unauthenticated:
          return Routes.signInPage;
        case SessionStatus.unknown:
          return Routes.loadingPage;
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: Routes.signUpPage,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: Routes.mainPage,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: Routes.loadingPage,
      builder: (context, state) => const LoadingPage(),
    ),
  ],
);
