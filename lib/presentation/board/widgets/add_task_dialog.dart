import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDeadline;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: GoogleFonts.jost(textStyle: context.text.mediumTitle),
      title: Center(child: Text(context.l10n.newTask)),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: GoogleFonts.jost(textStyle: context.text.textFieldInput),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: context.l10n.name,
                labelStyle: GoogleFonts.jost(
                  textStyle: context.text.smallTitle,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: GoogleFonts.jost(textStyle: context.text.textFieldInput),
              controller: _descController,
              decoration: InputDecoration(
                labelText: context.l10n.description,
                labelStyle: GoogleFonts.jost(
                  textStyle: context.text.smallTitle,
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  context.l10n.deadline,
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDeadline = picked;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _selectedDeadline != null
                        ? Utils.dateFormat.format(
                            _selectedDeadline!,
                          ) // локализованный формат
                        : context.l10n.pickDate,
                    style: GoogleFonts.jost(
                      textStyle: context.text.textFieldInput,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
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
          onPressed: () {
            final name = _nameController.text.trim();
            final desc = _descController.text.trim();

            if (name.isNotEmpty) {
              context.read<BoardBloc>().add(
                BoardAddTask(
                  taskTitle: name,
                  taskDescription: desc,
                  deadline: _selectedDeadline,
                ),
              );
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.emptyName,
                    style: GoogleFonts.jost(
                      textStyle: context.text.invertedButtonLabel,
                    ),
                  ),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n.add,
              style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            ),
          ),
        ),
      ],
    );
  }
}
