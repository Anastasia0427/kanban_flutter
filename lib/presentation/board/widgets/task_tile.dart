import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/task_model.dart';
import 'package:kanban_flutter/presentation/board/widgets/task_details_dialog.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => TaskDetailsDialog(task: task),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.color.tertiaryBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.color.shadowColor!.withAlpha(50),
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  task.taskTitle,
                  style: GoogleFonts.jost(
                    textStyle: context.text.smallTitle?.copyWith(fontSize: 26),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${context.l10n.deadline}: ',
                    style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                  ),
                  Text(
                    task.deadline != null
                        ? Utils.dateFormat.format(task.deadline!)
                        : '',
                    style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
