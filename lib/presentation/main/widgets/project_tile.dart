import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/board_model.dart';
import 'package:kanban_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:kanban_flutter/presentation/main/widgets/edit_board_dialog.dart';

class ProjectTile extends StatelessWidget {
  final BoardModel board;

  const ProjectTile({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Utils.stringToColor(board.color),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    board.name,
                    style: GoogleFonts.jost(
                      textStyle: context.text.headerTitle,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: context.color.invertedPrimaryText,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditBoardDialog(board: board),
                        );
                      },
                      child: Center(
                        child: Text(
                          context.l10n.edit,
                          style: GoogleFonts.jost(
                            textStyle: context.text.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      onTap: () => context.read<MainBloc>().add(
                        DeleteBoard(boardId: board.boardId!),
                      ),
                      child: Center(
                        child: Text(
                          context.l10n.delete,
                          style: GoogleFonts.jost(
                            textStyle: context.text.deleteButtonLabel,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                board.description,
                style: GoogleFonts.jost(textStyle: context.text.smallTitle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
