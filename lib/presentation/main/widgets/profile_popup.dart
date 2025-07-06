import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/errors/failure.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/presentation/main/bloc/profile_bloc.dart';
import 'package:kanban_flutter/presentation/main/widgets/edit_password_dialog.dart';
import 'package:kanban_flutter/presentation/main/widgets/editable_text_field.dart';

class ProfilePopup extends StatefulWidget {
  final String initialUsername;
  final String initialEmail;

  const ProfilePopup({
    super.key,
    required this.initialUsername,
    required this.initialEmail,
  });

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  late String username;
  late String email;
  bool isEditingUsername = false;
  bool isEditingEmail = false;
  bool hoverUsername = false;
  bool hoverEmail = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    username = widget.initialUsername;
    email = widget.initialEmail;
    usernameController.text = username;
    emailController.text = email;
  }

  void _saveUsername() {
    final newUsername = usernameController.text.trim();

    if (newUsername == username) {
      setState(() => isEditingUsername = false);
      return;
    }

    context.read<ProfileBloc>().add(EditUsername(username: newUsername));
  }

  void _saveEmail() {
    final newEmail = emailController.text.trim();

    if (newEmail == email) {
      setState(() => isEditingEmail = false);
      return;
    }

    context.read<ProfileBloc>().add(
      EditEmail(email: newEmail, context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSaved) {
            setState(() {
              if (isEditingUsername) {
                username = usernameController.text.trim();
                isEditingUsername = false;
              } else if (isEditingEmail) {
                email = emailController.text.trim();
                isEditingEmail = false;
              }
            });
          } else if (state is ProfileFailure) {
            final message = switch (state.type) {
              FailureType.usernameUpdateError =>
                context.l10n.usernameUpdateError,
              FailureType.userEmailUpdateError => context.l10n.emailUpdateError,
              _ => context.l10n.unknownError,
            };

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: GoogleFonts.jost(
                    textStyle: context.text.invertedButtonLabel,
                  ),
                ),
              ),
            );
          }
        },
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 8,
              top: 8,
              left: 8,
              bottom: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 32,
                        color: context.color.primaryText,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 42,
                      color: context.color.primaryText,
                    ),
                    const SizedBox(width: 12),
                    EditableTextField(
                      onChanged: (_) {
                        context.read<ProfileBloc>().add(InputChanged());
                      },
                      isEditing: isEditingUsername,
                      isHovered: hoverUsername,
                      value: username,
                      controller: usernameController,
                      onSave: _saveUsername,
                      onEdit: () => setState(() => isEditingUsername = true),
                      onHoverChange: (val) =>
                          setState(() => hoverUsername = val),
                      textStyle: context.text.mediumTitle!,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      String? emailError;
                      if (state is ProfileFailure) {
                        if (state.type == FailureType.userEmailUpdateError) {
                          emailError = context.l10n.alreadyExists;
                        }
                      } else if (state is ProfileValidationFailure) {
                        emailError = state.emailError;
                      }
                      return EditableTextField(
                        onChanged: (_) {
                          context.read<ProfileBloc>().add(InputChanged());
                        },
                        isEditing: isEditingEmail,
                        isHovered: hoverEmail,
                        value: email,
                        controller: emailController,
                        onSave: _saveEmail,
                        onEdit: () => setState(() => isEditingEmail = true),
                        onHoverChange: (val) =>
                            setState(() => hoverEmail = val),
                        textStyle: context.text.smallTitle!,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        errorText: emailError,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const ChangePasswordDialog(),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.vpn_key_outlined,
                      color: context.color.primaryText,
                      size: 24,
                    ),
                  ),
                  label: Text(
                    context.l10n.resetPasswordButton,
                    style: GoogleFonts.jost(
                      textStyle: context.text.buttonLabel,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: context.color.buttonPrimaryBackground!,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Center(
                          child: Text(
                            context.l10n.areYouSure,
                            style: GoogleFonts.jost(
                              textStyle: context.text.mediumTitle,
                            ),
                          ),
                        ),
                        actionsPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                context.l10n.cancel,
                                style: GoogleFonts.jost(
                                  textStyle: context.text.smallTitle,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<ProfileBloc>().add(SignOut());
                            },
                            child: Text(
                              context.l10n.exit,
                              style: GoogleFonts.jost(
                                textStyle: context.text.smallTitle?.copyWith(
                                  color: context.color.deleteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.logout,
                      color: context.color.deleteColor,
                      size: 24,
                    ),
                  ),
                  label: Text(
                    context.l10n.exitFromSystem,
                    style: GoogleFonts.jost(
                      textStyle: context.text.buttonLabel?.copyWith(
                        color: context.color.deleteColor,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: context.color.buttonPrimaryBackground!,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
