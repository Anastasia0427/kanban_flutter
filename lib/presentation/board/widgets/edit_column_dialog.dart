import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/color_picker_with_dialog.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';

class EditColumnDialog extends StatefulWidget {
  final ColumnModel column;

  const EditColumnDialog({super.key, required this.column});

  @override
  State<EditColumnDialog> createState() => _EditColumnDialogState();
}

class _EditColumnDialogState extends State<EditColumnDialog> {
  final _nameController = TextEditingController();

  late final List<Color> availableColors;
  late Color selectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _nameController.text = widget.column.columnName;
    availableColors =
        context.color.boardPickerColors?.whereType<Color>().toList() ?? [];
    selectedColor = Utils.stringToColor(widget.column.color);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: GoogleFonts.jost(textStyle: context.text.mediumTitle),
      title: Center(child: Text(context.l10n.editColumn)),
      content: SizedBox(
        width: 400,
        height: 200,
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

            if (name.isNotEmpty) {
              context.read<BoardBloc>().add(
                BoardEditColumn(
                  columnId: widget.column.columnId!,
                  boardId: widget.column.boardId,
                  name: name,
                  color: Utils.colorToStringWithAlpha(selectedColor),
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
