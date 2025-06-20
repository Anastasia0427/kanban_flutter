import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.welcome,
          style: GoogleFonts.jost(textStyle: context.text.largeTitle),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            children: [
              TextSpan(
                text: context.l10n.withThis,
                style: GoogleFonts.jost(textStyle: context.text.smallTitle),
              ),
              TextSpan(
                text: context.l10n.appName,
                style: GoogleFonts.jost(
                  textStyle: context.text.smallTitle?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextSpan(
                text: context.l10n.youCan,
                style: GoogleFonts.jost(textStyle: context.text.smallTitle),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Text(
          context.l10n.firstTime,
          style: GoogleFonts.jost(textStyle: context.text.mediumTitle),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            context.read<AuthBloc>().add(GoToSignUpPage());
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            context.l10n.signUpButton,
            style: GoogleFonts.jost(textStyle: context.text.buttonLabel),
          ),
        ),
      ],
    );
  }
}
