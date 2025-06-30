import 'package:kanban_flutter/core/utils/utils.dart';

class TaskModel {
  final int? taskId;
  final String taskTitle;
  final String taskDescription;
  final DateTime? deadline;
  final int columnId;
  final DateTime creationDate;

  TaskModel({
    this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.deadline,
    required this.columnId,
    required this.creationDate,
  });

  TaskModel copyWith({
    String? taskTitle,
    String? taskDescription,
    DateTime? deadline,
    int? columnId,
    DateTime? creationDate,
    bool resetDeadline = false,
  }) {
    return TaskModel(
      taskId: taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      deadline: resetDeadline ? null : (deadline ?? this.deadline),
      columnId: columnId ?? this.columnId,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'],
      taskTitle: json['task_title'],
      taskDescription: json['task_description'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      columnId: json['column_id'],
      creationDate: DateTime.parse(json['creation_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_title': taskTitle,
      'task_description': taskDescription,
      'deadline': deadline != null
          ? Utils.dateDBFormat.format(deadline!)
          : null,
      'column_id': columnId,
      'creation_date': Utils.dateDBFormat.format(creationDate),
    };
  }
}
