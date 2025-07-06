import 'package:flutter/material.dart';
import 'package:kanban_flutter/presentation/auth/widgets/background_pattern.dart';
import 'package:kanban_flutter/presentation/auth/widgets/login_form.dart';
import 'package:kanban_flutter/presentation/auth/widgets/welcome_section.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPattern(),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(child: WelcomeSection()),
                  SizedBox(width: 40),
                  Expanded(child: LoginForm()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
