import 'package:flutter/material.dart';
import 'package:kanban_flutter/presentation/auth/widgets/background_pattern.dart';
import 'package:kanban_flutter/presentation/auth/widgets/have_account_section.dart';
import 'package:kanban_flutter/presentation/auth/widgets/registration_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                  Expanded(child: RegistrationForm()),
                  SizedBox(width: 40),
                  Expanded(child: HaveAccountSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
