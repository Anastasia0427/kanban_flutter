import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/color_picker_with_dialog.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';

class AddBoardDialog extends StatefulWidget {
  const AddBoardDialog({super.key});

  @override
  State<AddBoardDialog> createState() => _AddBoardDialogState();
}

class _AddBoardDialogState extends State<AddBoardDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  late final List<Color> availableColors;
  late Color selectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    availableColors =
        context.color.boardPickerColors?.whereType<Color>().toList() ?? [];
    selectedColor = availableColors.first;
  }

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
      title: Center(child: Text(context.l10n.newProject)),
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
                  context.l10n.color,
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
                const SizedBox(width: 16),
                ColorPickerWithDialog(
                  pickerColor: selectedColor,
                  availableColors: availableColors,
                  onColorChanged: (color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
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
              context.read<MainBloc>().add(
                AddNewBoard(
                  name: name,
                  description: desc,
                  color: Utils.colorToStringWithAlpha(selectedColor),
                  defaultToDo: context.l10n.defaultToDo,
                  defaultInProgress: context.l10n.defaultInProgress,
                  defaultDone: context.l10n.defaultDone,
                  defaultToDoColor: context.color.defaultToDo!,
                  defaultInProgressColor: context.color.defaultInProgress!,
                  defaultDoneColor: context.color.defaultDone!,
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
