import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';

class HaveAccountSection extends StatelessWidget {
  const HaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.haveAccount,
          style: GoogleFonts.jost(textStyle: context.text.largeTitle),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            children: [
              TextSpan(
                text: context.l10n.returnToSignIn,
                style: GoogleFonts.jost(
                  textStyle: GoogleFonts.jost(
                    textStyle: context.text.smallTitle,
                  ),
                ),
              ),
              TextSpan(
                text: context.l10n.appName,
                style: GoogleFonts.jost(
                  textStyle: context.text.smallTitle?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        OutlinedButton(
          onPressed: () {
            context.read<AuthBloc>().add(GoToSignInPage());
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            context.l10n.signInButton,
            style: GoogleFonts.jost(textStyle: context.text.buttonLabel),
          ),
        ),
      ],
    );
  }
}
