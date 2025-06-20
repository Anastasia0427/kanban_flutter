import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.color.secondaryBackground?.withAlpha(200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.signUp,
            style: GoogleFonts.jost(textStyle: context.text.largeTitle),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              hintText: context.l10n.userNameHint,
              hintStyle: GoogleFonts.jost(
                textStyle: context.text.textFieldHint,
              ),
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: context.l10n.email,
              hintStyle: GoogleFonts.jost(
                textStyle: context.text.textFieldHint,
              ),
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: context.l10n.password,
              hintStyle: GoogleFonts.jost(
                textStyle: context.text.textFieldHint,
              ),
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: context.color.buttonPrimaryBackground,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(
              context.l10n.signUpButton,
              style: GoogleFonts.jost(
                textStyle: context.text.invertedButtonLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
