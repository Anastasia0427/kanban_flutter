import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/color_picker_with_dialog.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';

class EditBoardDialog extends StatefulWidget {
  final BoardModel board;

  const EditBoardDialog({super.key, required this.board});

  @override
  State<EditBoardDialog> createState() => _EditBoardDialogState();
}

class _EditBoardDialogState extends State<EditBoardDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  late final List<Color> availableColors;
  late Color selectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _nameController.text = widget.board.name;
    _descController.text = widget.board.description;
    availableColors =
        context.color.boardPickerColors?.whereType<Color>().toList() ?? [];
    selectedColor = Utils.stringToColor(widget.board.color);
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
      title: Center(child: Text(context.l10n.editBoard)),
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
                UpdateBoard(
                  boardId: widget.board.boardId!,
                  name: name,
                  description: desc,
                  color: Utils.colorToStringWithAlpha(selectedColor),
                  creationDate: widget.board.creationDate,
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
              context.l10n.save,
              style: GoogleFonts.jost(textStyle: context.text.smallTitle),
            ),
          ),
        ),
      ],
    );
  }
}
