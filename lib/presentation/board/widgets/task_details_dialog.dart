import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/utils.dart';
import 'package:kanban_flutter/logic/models/task_model.dart';
import 'package:kanban_flutter/presentation/board/bloc/board_bloc.dart';

class TaskDetailsDialog extends StatefulWidget {
  final TaskModel task;

  const TaskDetailsDialog({super.key, required this.task});

  @override
  State<TaskDetailsDialog> createState() => _TaskDetailsDialogState();
}

class _TaskDetailsDialogState extends State<TaskDetailsDialog> {
  bool isEditing = false;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? deadline;

  late TaskModel _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    titleController = TextEditingController(text: widget.task.taskTitle);
    descriptionController = TextEditingController(
      text: widget.task.taskDescription,
    );
    deadline = widget.task.deadline;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: deadline ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    setState(() => deadline = picked);
  }

  void _toggleEdit() {
    setState(() => isEditing = !isEditing);
  }

  Future<void> _saveChanges() async {
    final updatedTask = _task.copyWith(
      taskTitle: titleController.text.trim(),
      taskDescription: descriptionController.text.trim(),
      deadline: deadline,
      resetDeadline: deadline == null,
    );

    context.read<BoardBloc>().add(
      BoardUpdateTask(
        taskId: updatedTask.taskId!,
        taskTitle: updatedTask.taskTitle,
        taskDescription: updatedTask.taskDescription,
        deadline: updatedTask.deadline,
        creationDate: updatedTask.creationDate,
        resetDeadline: updatedTask.deadline == null,
      ),
    );

    setState(() {
      _task = updatedTask;
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isEditing
              ? Expanded(
                  child: TextField(
                    controller: titleController,
                    style: GoogleFonts.jost(
                      textStyle: context.text.mediumTitle,
                    ),
                  ),
                )
              : Text(
                  _task.taskTitle,
                  style: GoogleFonts.jost(textStyle: context.text.mediumTitle),
                ),
          IconButton(
            icon: Icon(
              isEditing ? Icons.close : Icons.edit_outlined,
              color: context.color.primaryText,
            ),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isEditing
                ? SizedBox(
                    height: 100,
                    child: Scrollbar(
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        style: GoogleFonts.jost(
                          textStyle: context.text.smallTitle,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _task.taskDescription,
                          style: GoogleFonts.jost(
                            textStyle: context.text.smallTitle,
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${context.l10n.deadline}:',
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
                const SizedBox(width: 8),
                if (isEditing)
                  TextButton(
                    onPressed: _selectDeadline,
                    child: Text(
                      deadline != null
                          ? Utils.dateFormat.format(deadline!)
                          : context.l10n.noDeadline,
                      style: GoogleFonts.jost(
                        textStyle: context.text.smallTitle,
                      ),
                    ),
                  )
                else
                  Text(
                    deadline != null
                        ? Utils.dateFormat.format(deadline!)
                        : context.l10n.noDeadline,
                    style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                  ),
              ],
            ),
            if (isEditing && deadline != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => setState(() => deadline = null),
                  icon: Icon(Icons.clear, color: context.color.primaryText),
                  label: Text(
                    context.l10n.removeDeadline,
                    style: GoogleFonts.jost(
                      textStyle: context.text.smallTitle?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${context.l10n.created}:',
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
                const SizedBox(width: 8),
                Text(
                  Utils.dateFormat.format(_task.creationDate),
                  style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        if (!isEditing)
          TextButton(
            onPressed: () {
              context.read<BoardBloc>().add(
                BoardDeleteTask(taskId: _task.taskId!),
              );
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.l10n.delete,
                style: GoogleFonts.jost(
                  textStyle: context.text.deleteButtonLabel,
                ),
              ),
            ),
          ),
        isEditing
            ? ElevatedButton(
                onPressed: _saveChanges,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.l10n.save,
                    style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                  ),
                ),
              )
            : TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.l10n.close,
                    style: GoogleFonts.jost(textStyle: context.text.smallTitle),
                  ),
                ),
              ),
      ],
    );
  }
}
