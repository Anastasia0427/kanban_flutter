import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/main/bloc/profile_bloc.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final passwordController = TextEditingController();
  String? errorText;
  bool isSaving = false;

  void _submit() {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      setState(() => errorText = context.l10n.emptyPassword);
      return;
    } else if (password.length < 6) {
      setState(() => errorText = context.l10n.tooShortPassword);
      return;
    }

    setState(() {
      errorText = null;
      isSaving = true;
    });

    context.read<ProfileBloc>().add(EditPassword(password: password));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSaved) {
            Navigator.of(context).pop();
          } else if (state is ProfileFailure) {
            setState(() {
              isSaving = false;
              errorText = context.l10n.passwordUpdateError;
            });
          }
        },
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.enterNewPassword,
                  style: GoogleFonts.jost(textStyle: context.text.mediumTitle),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: errorText,
                    errorStyle: GoogleFonts.jost(
                      textStyle: context.text.textFieldError,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n.cancel,
              style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isSaving ? null : _submit,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n.change,
              style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            ),
          ),
        ),
      ],
    );
  }
}
