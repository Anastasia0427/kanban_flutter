import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/actions_popup_menu.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';

class BoardDetailsOverlay extends StatelessWidget {
  final BoardModel board;

  const BoardDetailsOverlay({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: context.color.tertiaryBackground,
                  size: 40,
                ),
              ),
              ActionsPopupMenu(
                firstActionLabel: context.l10n.edit,
                secondActionLabel: context.l10n.delete,
                firstActionLabelStyle: GoogleFonts.jost(
                  textStyle: context.text.smallTitle,
                ),
                secondActionLabelStyle: GoogleFonts.jost(
                  textStyle: context.text.deleteButtonLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            board.name,
            style: GoogleFonts.jost(
              textStyle: context.text.mediumTitle?.copyWith(
                color: context.color.invertedPrimaryText,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Text(
                  board.description,
                  style: GoogleFonts.jost(
                    textStyle: context.text.smallTitle?.copyWith(
                      color: context.color.invertedPrimaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '${context.l10n.created}: ${Utils.dateFormat.format(board.creationDate)}',
            style: GoogleFonts.jost(
              textStyle: context.text.smallTitle?.copyWith(
                color: context.color.invertedPrimaryText,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${context.l10n.edited}: ${Utils.dateFormat.format(board.editDate)}',
            style: GoogleFonts.jost(
              textStyle: context.text.smallTitle?.copyWith(
                color: context.color.invertedPrimaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
