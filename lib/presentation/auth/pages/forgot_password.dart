import 'package:flutter/material.dart';
import 'package:kanban_flutter/presentation/auth/widgets/background_pattern.dart';
import 'package:kanban_flutter/presentation/auth/widgets/forgot_password_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPattern(),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Expanded(child: ForgotPasswordForm()),
            ),
          ),
        ],
      ),
    );
  }
}
