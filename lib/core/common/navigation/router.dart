import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/core/common/navigation/routes.dart';
import 'package:kanban_flutter/presentation/auth/pages/sign_in_page.dart';
import 'package:kanban_flutter/presentation/auth/pages/sign_up_page.dart';
import 'package:kanban_flutter/presentation/main/pages/main_page.dart';

final router = GoRouter(
  initialLocation: Routes.signInPage,
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
  ],
);
