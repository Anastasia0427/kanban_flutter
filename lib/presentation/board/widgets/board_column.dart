import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/common/widgets/actions_popup_menu.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/column_model.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';
import 'package:kanban_flutter/presentation/board/widgets/edit_column_dialog.dart';
import 'package:kanban_flutter/presentation/board/widgets/task_tile.dart';

class BoardColumn extends StatelessWidget {
  final ColumnModel column;
  final List<String> mockTasks;

  const BoardColumn({super.key, required this.column, required this.mockTasks});

  @override
  Widget build(BuildContext context) {
    final color = Utils.stringToColor(column.color);
    final showScroll = mockTasks.length > 4;
    final ScrollController scrollController = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          clipBehavior: Clip.antiAlias,
          width: 400,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.color.secondaryBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(100),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          column.columnName,
                          style: GoogleFonts.jost(
                            textStyle: context.text.mediumTitle?.copyWith(
                              color: context.color.invertedPrimaryText,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (column.isEditable)
                      ActionsPopupMenu(
                        firstActionLabel: context.l10n.edit,
                        secondActionLabel: context.l10n.delete,
                        firstActionLabelStyle: GoogleFonts.jost(
                          textStyle: context.text.smallTitle,
                        ),
                        secondActionLabelStyle: GoogleFonts.jost(
                          textStyle: context.text.deleteButtonLabel,
                        ),
                        firstAction: () {
                          showDialog(
                            context: context,
                            builder: (_) => EditColumnDialog(column: column),
                          );
                        },
                        secondAction: () => context.read<BoardBloc>().add(
                          BoardDeleteColumn(columnId: column.columnId!),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: mockTasks.isEmpty
                    ? const SizedBox(height: 12)
                    : Scrollbar(
                        thumbVisibility: showScroll,
                        controller: scrollController,
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: mockTasks.length,
                          itemBuilder: (context, index) {
                            return TaskTile(taskName: mockTasks[index]);
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
