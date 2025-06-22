import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/loading_indicator.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/auth/bloc/auth_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

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
            onChanged: (_) {
              context.read<AuthBloc>().add(InputChanged());
            },
            style: GoogleFonts.jost(textStyle: context.text.textFieldInput),
            decoration: InputDecoration(
              hintText: context.l10n.username,
              hintStyle: GoogleFonts.jost(
                textStyle: context.text.textFieldHint,
              ),
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            controller: username,
          ),
          const SizedBox(height: 16),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String? emailError;
              if (state is AuthFailure) {
                if (state.type == FailureType.userAlredyExists) {
                  emailError = context.l10n.alreadyExists;
                }
              } else if (state is AuthValidationFailure) {
                emailError = state.emailError;
              }
              return TextField(
                onChanged: (_) {
                  context.read<AuthBloc>().add(InputChanged());
                },
                style: GoogleFonts.jost(textStyle: context.text.textFieldInput),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: InputDecoration(
                  hintText: context.l10n.email,
                  hintStyle: GoogleFonts.jost(
                    textStyle: context.text.textFieldHint,
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  errorText: emailError,
                  errorStyle: GoogleFonts.jost(
                    textStyle: context.text.textFieldError,
                  ),
                ),
                controller: email,
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String? passwordError;
              if (state is AuthValidationFailure) {
                passwordError = state.passwordError;
              }
              return TextField(
                onChanged: (_) {
                  context.read<AuthBloc>().add(InputChanged());
                },
                style: GoogleFonts.jost(textStyle: context.text.textFieldInput),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                obscureText: true,
                decoration: InputDecoration(
                  hintText: context.l10n.password,
                  hintStyle: GoogleFonts.jost(
                    textStyle: context.text.textFieldHint,
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  errorText: passwordError,
                  errorStyle: GoogleFonts.jost(
                    textStyle: context.text.textFieldError,
                  ),
                ),
                controller: password,
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                SignUp(
                  email: email.text,
                  password: password.text,
                  username: username.text,
                  context: context,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.color.buttonPrimaryBackground,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const LoadingIndicator();
                }
                return Text(
                  context.l10n.signUpButton,
                  style: GoogleFonts.jost(
                    textStyle: context.text.invertedButtonLabel,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
